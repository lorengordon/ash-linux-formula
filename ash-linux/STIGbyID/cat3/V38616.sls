# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38616
# Finding ID:	V-38616
# Version:	RHEL-06-000241
# Finding Level:	Low
#
#     The SSH daemon must not permit user environment settings. SSH 
#     environment options potentially allow users to bypass access 
#     restriction in some configurations.
#
############################################################

{%- set stigId = 'V38616' %}
{%- set helperLoc = 'ash-linux/STIGbyID/cat3/files' %}
{%- set cfgFile = '/etc/ssh/sshd_config' %}
{%- set parmName = 'PermitUserEnvironment' %}
{%- set parmVal = 'no' %}

script_{{ stigId }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stigId }}.sh
    - cwd: /root

{% if salt['file.search'](cfgFile, '^' + parmName) %}
  {% if salt['file.search'](cfgFile, '^' + parmName + ' ' + parmVal) %}
file_{{ stigId }}-configSet:
  cmd.run:
    - name: 'echo "{{ parmName }} already meets STIG-defined requirements"'
  {% else %}
file_{{ stigId }}-configSet:
  file.replace:
    - name: '{{ cfgFile }}'
    - pattern: '^{{ parmName }}.*$'
    - repl: '{{ parmName }} {{ parmVal }}'
  {% endif %}
{% else %}
file_{{ stigId }}-configSet:
  file.append:
    - name: '{{ cfgFile }}'
    - text: |
        
        # SSH service must not allow setting of user environment options (per STIG V-38616)
        {{ parmName }} {{ parmVal }}

{% endif %}
