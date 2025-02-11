#!/bin/bash
# platform = Red Hat Enterprise Linux 7,multi_platform_ol,multi_platform_ubuntu

{{% if product in ["sle12", "sle15"] or 'ubuntu' in product %}}
{{% set pam_lastlog_path = "/etc/pam.d/login" %}}
{{% else %}}
{{% set pam_lastlog_path = "/etc/pam.d/postlogin" %}}
{{% endif %}}

rm -f {{{ pam_lastlog_path }}}

# pamd ansible module has a bug that if there is only one line in the file it raises an Out of Index exception
# so let's add more lines there
echo "session     required pam_lastlog.so showfailed" >> {{{ pam_lastlog_path }}}
echo "session     optional pam_lastlog.so silent showfailed" >> {{{ pam_lastlog_path }}}
