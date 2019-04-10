*** Settings ***
Library  ../library/HandlerInstall.py


*** Variables ***
${PATH_FILE_SETUP_32}               file_install\\elinkviewer-1.3.0-win32.exe
${PATH_FILE_SETUP_64}               file_install\\elinkviewer-1.3.0-win64.exe
${PATH_STORE_SETUP}                 None
${PATH_FILE_START_32}               C:\\Program Files (x86)\\eLinkViewer\\elinkviewer.exe
${PATH_FILE_START_64}               C:\\Program Files\\eLinkViewer\\elinkviewer.exe
${PATH_FILE_SETUP_VISUAL_32}        file_install\\vc_redist.x86.exe
${PATH_FILE_SETUP_VISUAL_64}        file_install\\vc_redist.x64.exe
${PATH_FILE_SETUP_VISUAL_32_13}     file_install\\vcredist_x86_2013.exe
${PATH_FILE_SETUP_VISUAL_64_13}     file_install\\vcredist_x64_2013.exe
${PATH_FILE_SETUP_VISUAL_32_17}     file_install\\vc_redist.x86_2017.exe
${PATH_FILE_SETUP_VISUAL_64_17}     file_install\\vc_redist.x64_2017.exe
${VERSION_32}                       win86
${VERSION_64}                       win64
${OLD_VERSION}                      True
${NEW_VERSION}                      True


*** Test Cases ***
Test Case Setup 001
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}       ${VERSION_32}
    should be equal      ${status}      ${True}

Test Case Setup 002
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}      ${None}         ${False}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    should be equal      ${status}      ${False}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_32}     ${VERSION_32}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}       ${VERSION_32}
    should be equal      ${status}      ${True}

Test Case Setup 003
    [Documentation]     Install eLinkViewer 64bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_64}       ${VERSION_64}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}       ${VERSION_64}
    should be equal      ${status}      ${True}

Test Case Setup 004
    [Documentation]     Install eLinkViewer 64bit
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_64}      ${VERSION_64}    ${None}         ${False}
    ${status_not_visual}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_64}     ${VERSION_64}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}       ${VERSION_64}
    should be equal      ${status_not_visual}      ${False}
    should be equal      ${status}      ${True}

Test Case Setup 005
    [Documentation]     Remove Microsoft Visual C++ 2015 when the eLinkViewer was running
        ...     - Install eLinkViewer and open eLinkViewer and connect to server
        ...     - Remove Microsoft Visual C++ 2015
        ...     - Close eLinkViewer
        ...     - Install manual Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}      ${VERSION_32}    ${None}         ${True}
    ${status_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}      ${False}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}     ${VERSION_32}
    ${status_close_32}     Close Elinkviewer
    Install Visual    ${PATH_FILE_SETUP_VISUAL_32}       ${VERSION_32}
    ${status_reconnect_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}      ${True}

    Install Elinkviewer     ${PATH_FILE_SETUP_64}      ${VERSION_64}    ${None}         ${True}
    ${status_64}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}      ${False}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}     ${VERSION_64}
    ${status_close_64}     Close Elinkviewer
    Install Visual    ${PATH_FILE_SETUP_VISUAL_64}       ${VERSION_64}
    ${status_reconnect_64}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}      ${True}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}     ${VERSION_64}

    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}     ${VERSION_32}
    should be equal      ${status_32}      ${True}
    should be equal      ${status_close_32}      ${True}
    should be equal      ${status_reconnect_32}      ${True}

    should be equal      ${status_64}      ${True}
    should be equal      ${status_close_64}      ${True}
    should be equal      ${status_reconnect_64}      ${True}

Test Case Setup 006
    [Documentation]     Upgrade from eLinkViewer 32bit to eLinkViewer 64bit
        ...     - Install eLinkViewer 32bit
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install eLinkViewer 64bit
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}
    ${status_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Install Elinkviewer     ${PATH_FILE_SETUP_64}       ${VERSION_64}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}       ${VERSION_64}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}       ${VERSION_32}
    should be equal      ${status_32}      ${True}
    should be equal      ${status}      ${True}

Test Case Setup 007
    [Documentation]     Downgrade from eLinkViewer 64bit to eLinkViewer 32bit
        ...     - Install eLinkViewer 64bit
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install eLinkViewer 32bit
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_64}       ${VERSION_64}
    ${status}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}
    ${status_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64}       ${VERSION_64}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32}       ${VERSION_32}
    should be equal      ${status}      ${True}
    should be equal      ${status_32}      ${True}

Test Case Setup 008
    [Documentation]     Install eLinkViewer with Microsoft Visual C++ 2013
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2013
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}       ${PATH_STORE_SETUP}     ${False}
    ${status_32_not_visual}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_32_13}     ${VERSION_32}     ${OLD_VERSION}
    ${status_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Install Elinkviewer     ${PATH_FILE_SETUP_64}        ${VERSION_64}      ${PATH_STORE_SETUP}     ${False}
    ${status_64_not_visual}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_64_13}     ${VERSION_64}     ${OLD_VERSION}
    ${status_64}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}

    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32_13}       ${VERSION_32}     ${OLD_VERSION}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64_13}       ${VERSION_64}     ${OLD_VERSION}

    should be equal      ${status_32_not_visual}      ${False}
    should be equal      ${status_32}      ${False}
    should be equal      ${status_64_not_visual}      ${False}
    should be equal      ${status_64}      ${False}

Test Case Setup 009
    [Documentation]     Install eLinkViewer with Microsoft Visual C++ 2017
        ...     - Install eLinkViewer
        ...     - Disagree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
        ...     - Install manual Microsoft Visual C++ 2017
        ...     - After install, open eLinkViewer and connect it

    Install Elinkviewer     ${PATH_FILE_SETUP_32}       ${VERSION_32}       ${PATH_STORE_SETUP}     ${False}
    ${status_32_not_visual}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_32_17}     ${VERSION_32}     ${None}     ${NEW_VERSION}
    ${status_32}       Start Elink Viewer      ${PATH_FILE_START_32}      ${SERVER_IP}        ${password}
    Install Elinkviewer     ${PATH_FILE_SETUP_64}       ${VERSION_64}       ${PATH_STORE_SETUP}     ${False}
    ${status_64_not_visual}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}
    Install Visual    ${PATH_FILE_SETUP_VISUAL_64_17}     ${VERSION_64}     ${None}      ${NEW_VERSION}
    ${status_64}       Start Elink Viewer      ${PATH_FILE_START_64}      ${SERVER_IP}        ${password}

    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_32_17}       ${VERSION_32}     ${None}     ${NEW_VERSION}
    Uninstall Visual    ${PATH_FILE_SETUP_VISUAL_64_17}       ${VERSION_64}     ${None}     ${NEW_VERSION}

    should be equal      ${status_32_not_visual}      ${False}
    should be equal      ${status_32}      ${True}
    should be equal      ${status_64_not_visual}      ${False}
    should be equal      ${status_64}      ${True}

