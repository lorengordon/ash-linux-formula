# Finding ID:	RHEL-07-010250
# Version:	RHEL-07-010250_rule
# SRG ID:	SRG-OS-000078-GPOS-00046
# Finding Level:	medium
# 
# Rule Summary:
#	Passwords must be a minimum of 15 characters in length.
#
# CCI-000205 
#    NIST SP 800-53 :: IA-5 (1) (a) 
#    NIST SP 800-53A :: IA-5 (1).1 (i) 
#    NIST SP 800-53 Revision 4 :: IA-5 (1) (a) 
#
#################################################################
{%- set stig_id = 'RHEL-07-010250' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat2/files' %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

