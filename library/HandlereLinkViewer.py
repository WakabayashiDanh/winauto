from pywinauto.application import Application
from ActionClickGui import ActionClickGui
import warnings, pyuac, time, subprocess, os
warnings.simplefilter('ignore', category=UserWarning)

class HandlereLinkViewer(object):

    def __init__(self, path_store_app, server_ip, password):
        self.path_store_app = path_store_app
        self.server_ip = server_ip
        self.password = password
        self.path_optionsfile = None

    def start_elink_viewer(self, close=True):
        elink_viewer = Application().start(cmd_line=self.path_store_app)
        try:
            # Select a menu item
            elink_viewer.Dialog.ComboBox.Edit.wait('ready', timeout=30).type_keys(self.server_ip, with_spaces=True)
            elink_viewer.Dialog.ConnectButton.wait('ready', timeout=30).click_input()
            try:
                elink_viewer.Authentication.Edit2.wait('ready', timeout=30).type_keys(self.password, with_spaces=True)
                elink_viewer.Authentication.Ok.wait('ready', timeout=30).click_input()
            except():
                elink_viewer.Dialog.Button.wait('ready', timeout=30).click_input()
                print('Do not connect to server')
                return False
            if close:
                elink_viewer.eLinkWindowClass.close()
            return True
        except():
            print("Error: Do not start eLinkViewer")
            return False

    def show_elink_viewer_help(self):
        # self.__goto_folder_store_app()
        # self.__command_line('elinkviewer -help')
        connect = Application().connect(title='eLinkViewer - Command Line Help')
        viewer_help = connect.Dialog.Edit.window_text()
        print(viewer_help)
        actual = open('Expected/elink_viewer_help.txt', 'r').read()
        print(actual)
        connect.Dialog.close()
        actual.close()
        if actual == viewer_help:
            return True

    def start_elink_viewer_by_command(self):
        self.__goto_folder_store_app()
        self.__command_line('elinkviewer')

    def connect_device_by_default_option(self):
        self.__goto_folder_store_app()
        self.__command_line('elinkviewer -host=%s  -password=%s' % (self.server_ip, self.password))

    def connect_device_with_new_option(self):
        self.__goto_folder_store_app()
        self.__command_line('elinkviewer -host=%s  -password=%s -optionsfile= %s' % (self.server_ip, self.password, self.path_optionsfile))

    def __command_line(self, cmd):
        ## run it ##
        p = subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE)
        p.communicate()
    def __goto_folder_store_app(self):
        os.chdir(self.path_store_app)