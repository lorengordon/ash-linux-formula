# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38561
# Finding ID:	V-38561
# Version:	RHEL-06-000194
# Finding Level:	Low
#
#     The audit system must be configured to audit all discretionary access 
#     control permission modifications using lsetxattr. The changing of 
#     file permissions could indicate that a user is attempting to gain 
#     access to information that would otherwise be disallowed. Auditing 
#     DAC modifications can facilitate the identification of patterns of 
#     abuse among both authorized and unauthorized users. 
#
############################################################

script_V38561-describe:
  cmd.script:
  - source: salt://STIGbyID/cat3/files/V38561.sh

# Monitoring of SELinux DAC config
{% if grains['cpuarch'] == 'x86_64' %}
# ...for unprivileged users
  {% if salt['file.search']('/etc/audit/audit.rules', '-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod') %}
file_V38561-auditRules_selDACusers:
  cmd.run:
  - name: 'echo "Appropriate audit rule already in place"'
  {% elif salt['file.search']('/etc/audit/audit.rules', ' lsetxattr -F auid>=500 ') %}
file_V38561-auditRules_selDACusers:
  file.replace:
  - name: '/etc/audit/audit.rules'
  - pattern: '^.* lsetxattr -F auid>=500 .*$'
  - repl: '-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod'
  {% else %}
file_V38561-auditRules_selDACusers:
  file.append:
  - name: '/etc/audit/audit.rules'
  - text:
    - '# Monitor for SELinux DAC changes (per STIG-ID V-38561)'
    - '-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod'
  {% endif %}

# ...for root user
  {% if salt['file.search']('/etc/audit/audit.rules', '-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -k perm_mod') %}
file_V38561-auditRules_selDACroot:
  cmd.run:
  - name: 'echo "Appropriate audit rule already in place"'
  {% elif salt['file.search']('/etc/audit/audit.rules', ' lsetxattr .*auid=0 ') %}
file_V38561-auditRules_selDACroot:
  file.replace:
  - name: '/etc/audit/audit.rules'
  - pattern: '^.* lsetxattr .*auid=0 .*$'
  - repl: '-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -k perm_mod'
  {% else %}
file_V38561-auditRules_selDACroot:
  file.append:
  - name: '/etc/audit/audit.rules'
  - text:
    - '# Monitor for SELinux DAC changes (per STIG-ID V-38561)'
    - '-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -k perm_mod'
  {% endif %}
{% else %}
file_V38561-auditRules_selDAC:
  cmd.run:
  - name: 'echo "Architecture not supported: no changes made"'
{% endif %}
