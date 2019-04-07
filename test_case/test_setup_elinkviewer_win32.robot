*** Settings ***
Library  ../library/HandlerInstall.py

*** Variables ***
${PATH_FILE_SETUP}               file_install\\elinkviewer-1.3.0-win32.exe
${PATH_STORE_SETUP}              None
${PATH_FILE_START}               C:\\Program Files\\eLinkViewer\\elinkviewer.exe
${PATH_FILE_SETUP_VISUAL}        file_install\\vc_redist.x86.exe
${PATH_FILE_SETUP_VISUAL_13}     file_install\\vcredist_x86_2013.exe
${PATH_FILE_SETUP_VISUAL_17}     file_install\\vc_redist.x86_2017.exe
${VERSION}                       86
${OLD_VERSION}                   True
${NEW_VERSION}                   True



*** Test Cases ***
Test Case Setup 001
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP}
    ${status}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL}       ${VERSION}
    should be equal      ${status}      ${True}

Test Case Setup 002
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP}      ${None}         ${False}
    ${status_not_visual}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL}     ${VERSION}
    ${status}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL}       ${VERSION}
    should be equal      ${status_not_visual}      ${False}
    should be equal      ${status}      ${True}

Test Case Setup 005
    [Documentation]     Remove Microsoft Visual C++ 2015 when the eLinkViewer was running
        ...     - Install eLinkViewer and open eLinkViewer and connect to server
        ...     - Remove Microsoft Visual C++ 2015
        ...     - Close eLinkViewer
        ...     - Install manual Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP}      ${None}         ${True}
    ${status}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}      ${False}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL}     ${VERSION}
    ${status_close}     Close Elinkviewer
    Install Visual    ${PATH_FILE_SETUP_VISUAL}       ${VERSION}
    ${status_reconnect}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}      ${True}
    should be equal      ${status}      ${True}
    should be equal      ${status_close}      ${True}
    should be equal      ${status_reconnect}      ${True}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL}     ${VERSION}

Test Case Setup 008
    [Documentation]     Install eLinkViewer with Microsoft Visual C++ 2013
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2013
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP}       ${PATH_STORE_SETUP}     ${False}
    ${status_not_visual}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_13}     ${VERSION}     ${OLD_VERSION}
    ${status}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_13}       ${VERSION}     ${OLD_VERSION}
    should be equal      ${status_not_visual}      ${False}
    should be equal      ${status}      ${False}

Test Case Setup 009
    [Documentation]     Install eLinkViewer with Microsoft Visual C++ 2017
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2017
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP}       ${PATH_STORE_SETUP}     ${False}
    ${status_not_visual}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_17}       ${VERSION}     ${False}    ${NEW_VERSION}
    ${status}       Start Elink Viewer      ${PATH_FILE_START}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_17}       ${VERSION}     ${False}    ${NEW_VERSION}
    should be equal      ${status_not_visual}      ${False}
    should be equal      ${status}      ${True}

