# Finding ID:	RHEL-07-040680
# Version:	RHEL-07-040680_rule
# SRG ID:	SRG-OS-000480-GPOS-00227
# Finding Level:	medium
# 
# Rule Summary:
#	The SSH daemon must perform strict mode checking of home
#	directory configuration files.
#
# CCI-000366 
#    NIST SP 800-53 :: CM-6 b 
#    NIST SP 800-53A :: CM-6.1 (iv) 
#    NIST SP 800-53 Revision 4 :: CM-6 b 
#
#################################################################
{%- set stig_id = 'RHEL-07-040680' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat2/files' %}
{%- set svcName = 'sshd' %}
{%- set cfgFile = '/etc/ssh/sshd_config' %}
{%- set parmName = 'StrictModes' %}
{%- set parmValu = 'yes' %}
{%- set skipIt = salt.pillar.get('ash-linux:lookup:skip-stigs', []) %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if stig_id in skipIt %}
notify_{{ stig_id }}-skipSet:
  cmd.run:
    - name: 'printf "\nchanged=no comment=''Handler for {{ stig_id }} has been selected for skip.''\n"'
    - cwd: /root
    - stateful: True
{%- else %}
file_{{ stig_id }}-{{ cfgFile }}:
  file.replace:
    - name: '{{ cfgFile }}'
    - pattern: '^\s{{ parmName }} .*$'
    - repl: '{{ parmName }} {{ parmValu }}'
    - append_if_not_found: True
    - not_found_content: |-
        # Inserted per STIG {{ stig_id }}
        {{ parmName }} {{ parmValu }}

service_{{ stig_id }}-{{ cfgFile }}:
  service.running:
    - name: '{{ svcName }}'
    - listen:
      - file: file_{{ stig_id }}-{{ cfgFile }}
{%- endif %}
