import pyautogui

class ActionClickGui():

    def __init__(self):
        self.resolution = str(pyautogui.size())

    def check_agree_box_visual(self):
        if self.resolution == 'Size(width=1920, height=1080)':
            pyautogui.click(740, 611)
        if self.resolution == 'Size(width=1366, height=768)':
            pyautogui.click(459, 456)
        if self.resolution == 'Size(width=1360, height=768)':
            pyautogui.click(457, 454)
        if self.resolution == 'Size(width=1024, height=768)':
            pyautogui.click(290, 454)
        if self.resolution == 'Size(width=800, height=600)':
            pyautogui.click(178, 371)

    def click_install_visual(self):
        if self.resolution == 'Size(width=1920, height=1080)':
            pyautogui.click(1087, 645)
        if self.resolution == 'Size(width=1366, height=768)':
            pyautogui.click(795, 488)
        if self.resolution == 'Size(width=1360, height=768)':
            pyautogui.click(790, 487)
        if self.resolution == 'Size(width=1024, height=768)':
            pyautogui.click(625, 488)
        if self.resolution == 'Size(width=800, height=600)':
            pyautogui.click(513, 404)

    def click_cancel_visual(self):
        if self.resolution == 'Size(width=1920, height=1080)':
            pyautogui.click(1139, 643)
        if self.resolution == 'Size(width=1366, height=768)':
            pyautogui.click(869, 488)
        if self.resolution == 'Size(width=1360, height=768)':
            pyautogui.click(871, 488)
        if self.resolution == 'Size(width=1024, height=768)':
            pyautogui.click(699, 488)
        if self.resolution == 'Size(width=800, height=600)':
            pyautogui.click(598, 404)

    def confirm_yes_cancel_visual(self):
        if self.resolution == 'Size(width=1920, height=1080)':
            pyautogui.click(1018, 594)
        if self.resolution == 'Size(width=1366, height=768)':
            pyautogui.click(739, 437)
        if self.resolution == 'Size(width=1360, height=768)':
            pyautogui.click(740, 440)
        if self.resolution == 'Size(width=1024, height=768)':
            pyautogui.click(574, 440)
        if self.resolution == 'Size(width=800, height=600)':
            pyautogui.click(459, 356)

    def click_close_visual(self):
        if self.resolution == 'Size(width=1920, height=1080)':
            pyautogui.click(1174, 645)
        if self.resolution == 'Size(width=1366, height=768)':
            pyautogui.click(869, 488)
        if self.resolution == 'Size(width=1360, height=768)':
            pyautogui.click(871, 488)
        if self.resolution == 'Size(width=1024, height=768)':
            pyautogui.click(699, 488)
        if self.resolution == 'Size(width=800, height=600)':
            pyautogui.click(598, 404)
