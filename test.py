#!/usr/bin/python
# import subprocess, sys, os
# #
# # ## Go to folder eLinkViewerTest
# # # os.chdir(r"C:\\eLinkViewerTest")
# # ## command to run - tcp only ##
# # if sys.argv[3] == 'win64':
# #     cmd = r"robot -d Result --variable SERVER_IP:%s --variable PASSWORD:%s test_case\\test_setup_elinkviewer_win64.robot" % (sys.argv[1], sys.argv[2])
# # else:
# #     cmd = r"robot -d Result --variable SERVER_IP:%s --variable PASSWORD:%s test_case\\test_setup_elinkviewer_win32.robot" % (sys.argv[1], sys.argv[2])
# #
# # ## run it ##
# # p = subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE)
# #
# # ## But do not wait till netstat finish, start displaying output immediately ##
# # while True:
# #     out = p.stderr.read(1)
# #     if out == '' and p.poll() != None:
# #         break
# #     if out != '':
# #         # sys.stdout.write(out)
# #         sys.stdout.flush()

# import time
#
#
# def sleep(iTime, iInterval=10):
#     iRemainTime = iTime
#     print('Sleeping %s second(s)' % iTime)
#     while iRemainTime > 0:
#         iSleep = iInterval if iRemainTime >= iInterval else iRemainTime
#         time.sleep(iSleep)
#         iRemainTime -= iSleep
#         print('Sleeping ... %s out of %s seconds' % (iTime - iRemainTime, iTime))
#
# sleep(150)
from pywinauto.application import Application
import warnings,  time
warnings.simplefilter('ignore', category=UserWarning)


element = False
index = 0

title = "Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.24212 Setup"
Application().start(r'C:\Users\Danh Nguyen\PycharmProjects\eLinkViewer\file_install\vc_redist.x64.exe')
# while not element:
#     try:
#
#         element = True
#
#     except:
#         element = False
#         index += 1
#         print('Time sleep %s' %index)
#         if index > 60:
#             break
# vc_redist = Application(backend="win32").connect(title=title)['WixStdBA'].wait(timeout=5)
# print(vc_redist.print_control_identifiers())
# print(vc_redist.Static1.window_text())
# vc_redist.CheckBox.wait('ready', timeout=5).click_input()
# vc_redist.InstallButton.wait('ready', timeout=30).click_input()
# time.sleep(15)
# vc_redist.CloseButton5.wait('ready', timeout=30).click_input()
time.sleep(2)
vc_redist = Application(backend="win32").connect(title=title)['WixStdBA']
vc_redist.CheckBox.wait('ready', timeout=5).click_input()
vc_redist.InstallButton.wait('ready', timeout=30).click_input()
while not element:
    try:
        status = vc_redist.Static1.window_text()
        if status == 'Setup Successful':
            element = True
    except:
        element = False
        index += 1
        print('Time sleep %s' %index)
        if index > 60:
            break
vc_redist.CloseButton.wait('ready', timeout=45).click_input()