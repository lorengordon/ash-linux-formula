#!/bin/sh
# STIG ID:	RHEL-07-030750
# Rule ID:	SV-86797r5_rule
# Vuln ID:	V-72173
# SRG ID:	SRG-OS-000042-GPOS-00020
# Finding Level:	medium
# 
# Rule Summary:
#	All uses of the umount command must be audited.
#
# CCI-000135 
# CCI-002884 
#    NIST SP 800-53 :: AU-3 (1) 
#    NIST SP 800-53A :: AU-3 (1).1 (ii) 
#    NIST SP 800-53 Revision 4 :: AU-3 (1) 
#    NIST SP 800-53 Revision 4 :: MA-4 (1) (a) 
#
#################################################################
# Standard outputter function
diag_out() {
   echo "${1}"
}

diag_out "----------------------------------------"
diag_out "STIG Finding ID: RHEL-07-030750"
diag_out "   All uses of the umount command must"
diag_out "   be audited."
diag_out "----------------------------------------"
