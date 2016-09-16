# Finding ID:	RHEL-07-010190
# Version:	RHEL-07-010190_rule
# SRG ID:	SRG-OS-000073-GPOS-00041
# Finding Level:	medium
# 
# Rule Summary:
#	User and group account administration utilities must be
#	configured to store only encrypted representations of
#	passwords.
#
# CCI-000196 
#    NIST SP 800-53 :: IA-5 (1) (c) 
#    NIST SP 800-53A :: IA-5 (1).1 (v) 
#    NIST SP 800-53 Revision 4 :: IA-5 (1) (c) 
#
#################################################################
{%- set stig_id = 'RHEL-07-010190' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat2/files' %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

