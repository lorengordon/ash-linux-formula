#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38677
# Finding ID:	V-38677
# Version:	
# Finding Level:	High
#
#     The NFS server must not have the insecure file locking option 
#     enabled. Allowing insecure file locking could allow for sensitive 
#     data to be viewed or edited by an unauthorized user.
#
############################################################

# Standard outputter function
diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38677"
diag_out "Turn off insecure file-locking in"
diag_out "NFS exports"
diag_out "----------------------------------"

grep insecure_locks /etc/exports > /dev/null 2>&1

if [ $? -eq 0 ]
then
   diag_out "Found exports with insecure file-locking enabled"
else
   diag_out "No defined-shares with insecure file-locking enabled"
   exit 1
fi