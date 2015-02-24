# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38670
# Finding ID:	V-38670
# Version:	RHEL-06-000306
# Finding Level:	Medium
#
#     The operating system must detect unauthorized changes to software and 
#     information. By default, AIDE does not install itself for periodic 
#     execution. Periodically running AIDE may reveal unexpected changes in 
#     installed files.
#
#  CCI: CCI-001297
#  NIST SP 800-53 :: SI-7
#  NIST SP 800-53A :: SI-7.1
#
############################################################

script_V38670-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38670.sh
    - cwd: '/root'

notice_V38670:
  cmd.run:
    - name: 'echo "Implementation is system- and tenant-specific. This test will look for scheduled service in typical scheduler file locations. However, this tool cannot verify outside those locations or any frequencies discovered within those locations. **MANUAL VERIFICAION WILL BE REQUIRED.**"'

{% if not salt['pkg.verify']('aide') %}
warn_V38670-aideConf:
   cmd.run:
     - name: 'echo "Package unmodified (AIDE has not been configured)"'
{% endif %}

{% if not salt['file.search']('/etc/crontab', '/usr/sbin/aide') %}
msg_V38670-etcCrontab:
  cmd.run:
    - name: 'echo "Info: AIDE not found in /etc/crontab"'
{% else %}
msg_V38670-etcCrontab:
  cmd.run:
    - name: 'echo "Info: AIDE found in /etc/crontab"'
{% endif %}

{% if salt['file.file_exists']('/var/spool/cron/root') %}
  {% if not salt['file.search']('/var/spool/cron/root', '/usr/sbin/aide') %}
msg_V38670-rootCrontab:
  cmd.run:
    - name: 'echo "Info: AIDE not found in root users crontab (/var/spool/cron/root)"'
  {% else %}
msg_V38670-rootCrontab:
  cmd.run:
    - name: 'echo "Info: AIDE found in root users crontab (/var/spool/cron/root)"'
  {% endif %}
{% else %}
msg_V38670-rootCrontab:
  cmd.run:
    - name: 'echo "Info: root user has no crontab (/var/spool/cron/root)"'
{% endif %}
