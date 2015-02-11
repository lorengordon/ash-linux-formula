# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38449
# Finding ID:	V-38449
# Version:	RHEL-06-000038
# Finding Level:	Medium
#
#     The /etc/gshadow file must have mode 0000. The /etc/gshadow file 
#     contains group password hashes. Protection of this file is critical 
#     for system security.
#
#  CCI: CCI-000366
#  NIST SP 800-53 :: CM-6 b
#  NIST SP 800-53A :: CM-6.1 (iv)
#  NIST SP 800-53 Revision 4 :: CM-6 b
#
############################################################

script_V38449-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38449.sh

file_38449:
  file.managed:
    - name: /etc/gshadow
    - mode: '0000'