# Finding ID: V-230470
# Rule ID:    SV-230470r744006_rule
# STIG ID:    RHEL-08-030603
# SRG ID:     SRG-OS-000062-GPOS-00031
#
# Finding Level: low
#
# Rule Summary:
#       The OS must enable Linux audit logging for the USBGuard daemon
#
# References:
#   CCI:
#     - CCI-000169
#   NIST SP 800-53 :: AU-12 a
#   NIST SP 800-53A :: AU-12.1 (ii)
#   NIST SP 800-53 Revision 4 :: AU-12 a
#
###########################################################################
{%- set stig_id = 'RHEL-08-030470' %}
{%- set helperLoc = 'ash-linux/el8/STIGbyID/cat3/files' %}
{%- set skipIt = salt.pillar.get('ash-linux:lookup:skip-stigs', []) %}
{%- set targFile = '/etc/usbguard/usbguard-daemon.conf' %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if stig_id in skipIt %}
notify_{{ stig_id }}-skipSet:
  cmd.run:
    - name: 'printf "\nchanged=no comment=''Handler for {{ stig_id }} has been selected for skip.''\n"'
    - stateful: True
    - cwd: /root
{%- else %}
file_{{ stig_id }}_{{ targFile }}:
  file.line:
    - name: '{{ targFile }}'
    - create: true
    - user: 'root'
    - group: 'root'
    - file_mode: 0644
    - match: '^AuditBackend'
    - mode: 'replace'
    - content: 'AuditBackend=LinuxAudit'
{%- endif %}

