#!/usr/bin/python
import subprocess, sys, os

## Go to folder eLinkViewerTest
# os.chdir(r"C:\\eLinkViewerTest")
## command to run - tcp only ##
if sys.argv[3] == 'win64':
    cmd_test_setup = r"robot -d Result --variable SERVER_IP:%s --variable PASSWORD:%s --variable VERSION:%s test_case\\test_setup_elinkviewer_win64.robot" % (sys.argv[1], sys.argv[2], sys.argv[3])
else:
    cmd_test_setup = r"robot -d Result --variable SERVER_IP:%s --variable PASSWORD:%s --variable VERSION:%s test_case\\test_setup_elinkviewer_win32.robot" % (sys.argv[1], sys.argv[2], sys.argv[3])
cmd_test_cmd = r"robot -d Result --variable SERVER_IP:%s --variable PASSWORD:%s --variable VERSION:%s test_case\\test_command_line_elinkviewer.robot" % (sys.argv[1], sys.argv[2], sys.argv[3])

list_cmd_run = [cmd_test_setup, cmd_test_cmd]
## run it ##
for cmd in list_cmd_run:
    p = subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE)
    p.communicate()
