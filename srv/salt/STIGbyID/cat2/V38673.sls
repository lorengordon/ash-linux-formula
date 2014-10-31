# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38673
# Finding ID:	V-38673
# Version:	RHEL-06-000307
# Finding Level:	Medium
#
#     The operating system must ensure unauthorized, security-relevant 
#     configuration changes detected are tracked. By default, AIDE does not 
#     install itself for periodic execution. Periodically running AIDE may 
#     reveal unexpected changes in installed files.
#
############################################################

script_V38673-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38673.sh

notice_V38673:
  cmd.run:
  - name: 'echo "Implementation is system- and tenant-specific. This test will look for scheduled service in typical scheduler file locations. However, this tool cannot verify outside those locations or any frequencies discovered within those locations. **MANUAL VERIFICAION WILL BE REQUIRED.**"'

{% if not salt['pkg.verify']('aide') %}
warn_V38673-aideConf:
   cmd.run:
   - name: 'echo "Package unmodified (AIDE has not been configured)"'
{% endif %}

{% if not salt['file.search']('/etc/crontab', '/usr/sbin/aide') %}
msg_V38673-etcCrontab:
  cmd.run:
  - name: 'echo "Info: AIDE not found in /etc/crontab"'
{% else %}
msg_V38673-etcCrontab:
  cmd.run:
  - name: 'echo "Info: AIDE found in /etc/crontab"'
{% endif %}

{% if salt['file.file_exists']('/var/spool/cron/root') %}
  {% if not salt['file.search']('/var/spool/cron/root', '/usr/sbin/aide') %}
msg_V38673-rootCrontab:
  cmd.run:
  - name: 'echo "Info: AIDE not found in root users crontab (/var/spool/cron/root)"'
  {% else %}
msg_V38673-rootCrontab:
  cmd.run:
  - name: 'echo "Info: AIDE found in root users crontab (/var/spool/cron/root)"'
  {% endif %}
{% else %}
msg_V38673-rootCrontab:
  cmd.run:
  - name: 'echo "Info: root user has no crontab (/var/spool/cron/root)"'
{% endif %}