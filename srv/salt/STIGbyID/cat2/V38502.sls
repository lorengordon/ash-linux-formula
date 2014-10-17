#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38502
# Finding ID:	V-38502
# Version:	RHEL-06-000033
# Finding Level:	Medium
#
#     The /etc/shadow file must be owned by root. The "/etc/shadow" file 
#     contains the list of local system accounts and stores password 
#     hashes. Protection of this file is critical for system security. 
#     Failure to give ownership of this file to root ...
#
############################################################

script_V38502-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38502.sh

file_V38502:
  file.managed:
  - name: /etc/shadow
  - user: root