from pywinauto.application import Application
import warnings, time, subprocess, os
warnings.simplefilter('ignore', category=UserWarning)

class HandlereLinkViewer(object):

    def __init__(self, path_store_app, server_ip, password):
        self.path_store_app = path_store_app
        self.server_ip = server_ip
        self.password = password
        self.path_optionsfile = os.getcwd() + '\expected\optionfile.txt'

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
        current_path = self.get_current_path()
        path_expected_file = os.getcwd() + '\expected\elink_viewer_help.txt'
        self.goto_folder(self.path_store_app)
        self.__command_line('elinkviewer -help')
        connect = Application().connect(title='eLinkViewer - Command Line Help')
        viewer_help = connect.Dialog.Edit.window_text()
        connect.Dialog.close()
        with open(path_expected_file, 'r') as f:
            actual = f.read()
        self.goto_folder(current_path)
        return True if actual == viewer_help else False

    def start_elink_viewer_by_command(self):
        current_path = self.get_current_path()
        self.goto_folder(self.path_store_app)
        self.__command_line('elinkviewer')
        self.goto_folder(current_path)
        try:
            connect = Application().connect(title='eLinkViewer Login')
            connect.Dialog.close()
            return True
        except():
            return False

    def connect_device_by_default_option(self):
        current_path = self.get_current_path()
        self.goto_folder(self.path_store_app)
        self.__command_line('elinkviewer -host=%s  -password=%s' % (self.server_ip, self.password))
        self.goto_folder(current_path)
        try:
            connect = Application().connect(title='win-ul74uf8ujrp - eLinkViewer')
            connect.eLinkWindowClass.close()
            return True
        except():
            return False

    def connect_device_with_new_option(self):
        current_path = self.get_current_path()
        self.goto_folder(self.path_store_app)
        self.__command_line('elinkviewer -optionsfile=%s -host=%s  -password=%s' % (self.path_optionsfile, self.server_ip, self.password))
        self.goto_folder(current_path)
        try:
            connect = Application().connect(title='win-ul74uf8ujrp - eLinkViewer')
            connect.eLinkWindowClass.close()
            return True
        except():
            return False

    def goto_folder(self, path):
        os.chdir(path)

    def get_current_path(self):
        return os.getcwd()

    def __command_line(self, cmd):
        ## run it ##
        subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE)
        time.sleep(2)