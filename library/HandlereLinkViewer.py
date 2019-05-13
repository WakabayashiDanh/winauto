from pywinauto.application import Application
import warnings, time, subprocess, os
warnings.simplefilter('ignore', category=UserWarning)

class HandlereLinkViewer(object):

    def __init__(self, path_store_app, server_ip, password):
        self.path_store_app = path_store_app
        self.server_ip = server_ip
        self.password = password
        self.path_optionsfile = path_store_app + '\optionsfile.vnc'
        self.path_expected_file = os.getcwd() + '\expected\elink_viewer_help.txt'

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

    def start_elink_viewers(self):
        Application().start(cmd_line=self.path_store_app)
        time.sleep(5)
        try:
            Application().connect(title='eLinkViewer Login')
            return True
        except:
            return False

    def login_elink_viewer(self, password, username=None):
        connect = Application().connect(title='eLinkViewer Login')
        connect.Dialog.ComboBox.Edit.wait('ready', timeout=30).type_keys(self.server_ip, with_spaces=True)
        connect.Dialog.ConnectButton.wait('ready', timeout=30).click_input()
        try:
            connect.Authentication.Edit2.wait('ready', timeout=30).type_keys(password, with_spaces=True)
            connect.Authentication.Ok.wait('ready', timeout=30).click_input()
            return True
        except():
            connect.Dialog.Button.wait('ready', timeout=30).click_input()
            print('Do not connect to server')
            return False

    def handler_authentication_login(self, retry=False, cancel=False):
        connect = Application().connect(title='%s - eLinkViewer' % self.server_ip)
        error = connect.Dialog.Static2.window_text()
        print(error)
        if retry:
            connect.Dialog.Button.wait('ready', timeout=30).click_input()
        if cancel:
            connect.Dialog.CancelButton.wait('ready', timeout=30).click_input()

    def verify_elink_viewer_help(self):
        connect = Application().connect(title='eLinkViewer - Command Line Help')
        viewer_help = connect.Dialog.Edit.window_text()
        connect.Dialog.close()
        with open(self.path_expected_file, 'r') as f:
            actual = f.read()
        return True if actual == viewer_help else False

    def save_connection_info(self):
        try:
            app = Application(backend="uia").connect(title='win-ul74uf8ujrp - eLinkViewer')['Dialog']
            app.Toolbar.Button2.click()
            app.SaveAs.ComboBox.type_keys(self.path_optionsfile, with_spaces=True)
            app.SaveAs.Save.click()
            app.Dialog.YesButton.click()
            return self.path_optionsfile
        except():
            return False

    def verify_connection(self):
        try:
            connect = Application().connect(title='win-ul74uf8ujrp - eLinkViewer')
            connect.eLinkWindowClass.close()
            return True
        except():
            return False

    def verify_authentication_login(self):
        expect_error = 'Authentication reason: Authentication failed from 192.168.82.13'
        connect = Application().connect(title='%s - eLinkViewer' % self.server_ip)
        error = connect.Dialog.Static2.window_text()
        if error == expect_error:
            return True
        else:
            return False

    def send_command_line(self, cmd):
        ## run it ##
        subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE)
        time.sleep(2)

    def goto_folder(self, path):
        os.chdir(path)

    def get_current_path(self):
        return os.getcwd()

    def remove_file(self, path):
        os.remove(path)