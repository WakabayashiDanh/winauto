from pywinauto.application import Application
from ActionClickGui import ActionClickGui
import time
import pyuac
import warnings
warnings.simplefilter('ignore', category=UserWarning)


class HandlerInstall(object):

   def install_elinkviewer(self, path_file_setup, path_store_install=None, install_vc_redist=True):
       try:
           if not pyuac.isUserAdmin():
               pyuac.runAsAdmin()
           print(path_file_setup)
           elink_viewer = Application(backend="win32").start(path_file_setup)
           elink_viewer.InstallDialog.NextButton.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.IAgreeRadioButton.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.RadioButton2.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.CheckBox.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.NextButton.wait('ready', timeout=30).click_input()
           if path_store_install:
               elink_viewer.InstallDialog.Edit.Wait('ready', timeout=30).type_keys(path_store_install,with_spaces=True)
           elink_viewer.InstallDialog.NextButton.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.NextButton.wait('ready', timeout=30).click_input()
           elink_viewer.InstallDialog.InstallButton.wait('ready', timeout=30).click_input()
           time.sleep(15)
           # Install Microsoft Visual C++
           if install_vc_redist:
               ActionClickGui().check_agree_box_visual()
               ActionClickGui().click_install_visual()
               time.sleep(35)
               ActionClickGui().click_close_visual()
           else:
               ActionClickGui().click_cancel_visual()
               ActionClickGui().confirm_yes_cancel_visual()

           elink_viewer.InstallDialog.FinishButton.wait('ready', timeout=30).click_input()
       except:
           print('Do not error')

   def install_visual(self, path_file_setup, version, old_version=False, new_version=False):
       title = "Microsoft Visual C++ 2015 Redistributable (x86) - 14.0.24123 Setup"
       if version == '64':
           title = "Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.24212 Setup"
       if version == '64' and old_version:
           title = "Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501 Setup"
       if version == '86' and old_version:
           title = "Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.30501 Setup"
       if version == '64' and new_version:
           title = "Microsoft Visual C++ 2017 Redistributable (x64) - 14.16.27027 Setup"
       if version == '86' and new_version:
           title = "Microsoft Visual C++ 2017 Redistributable (x86) - 14.16.27027 Setup"

       Application().start(path_file_setup)
       time.sleep(2)
       vc_redist = Application(backend="win32").connect(title=title)['WixStdBA']
       vc_redist.CheckBox.wait('ready', timeout=5).click_input()
       vc_redist.InstallButton.wait('ready', timeout=30).click_input()
       time.sleep(35)
       vc_redist.CloseButton5.wait('ready', timeout=30).click_input()

   def start_elink_viewer(self, path_store_app, server_ip, password, close=True):

        elink_viewer = Application().start(cmd_line=path_store_app)
        try:
            # Select a menu item
            elink_viewer.Dialog.ComboBox.Edit.wait('ready', timeout=30).type_keys(server_ip, with_spaces=True)
            elink_viewer.Dialog.ConnectButton.wait('ready', timeout=30).click_input()
            try:
                elink_viewer.Authentication.Edit2.wait('ready', timeout=30).type_keys(password, with_spaces=True)
                elink_viewer.Authentication.Ok.wait('ready', timeout=30).click_input()
            except:
                elink_viewer.Dialog.Button.wait('ready', timeout=30).click_input()
                print('Do not connect to server')
                return False
            if close:
                elink_viewer.eLinkWindowClass.close()
            return True
        except:
            print("Error: Do not start eLinkViewer")
            return False

   def uninstall_visual(self, path_file_setup, version, old_version=False, new_version=False):

       title = "Microsoft Visual C++ 2015 Redistributable (x86) - 14.0.24123 Setup"
       if version == 'win64':
           title = "Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.24212 Setup"
       if version == 'win64' and old_version:
           title = "Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501 Setup"
       if version == 'win86' and old_version:
           title = "Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.30501 Setup"
       if version == 'win64' and new_version:
           title = "Microsoft Visual C++ 2017 Redistributable (x64) - 14.16.27027 Setup"
       if version == 'win86' and new_version:
           title = "Microsoft Visual C++ 2017 Redistributable (x86) - 14.16.27027 Setup"
       Application().start(path_file_setup)
       time.sleep(2)
       vc_redist = Application(backend="win32").connect(title=title)['WixStdBA']
       vc_redist.UninstallButton.wait('ready', timeout=5).click_input()
       time.sleep(35)
       vc_redist.CloseButton5.wait('ready', timeout=30).click_input()

   def close_elinkviewer(self):
       try:
            connect = Application().connect(title='win-ul74uf8ujrp - eLinkViewer')
            connect.eLinkWindowClass.close()
            return True
       except:
           return False






