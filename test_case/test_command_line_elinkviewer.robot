*** Settings ***
Library  ../library/HandlereLinkViewer.py   C:\\Program Files\\eLinkViewer     ${SERVER_IP}        ${PASSWORD}
Library  ../library/HandlerInstall.py

Suite Setup     Command Suite Setup
Suite Teardown	Command Teardown
Test Setup      Go To Folder Store App
Test Teardown   Comeback Folder Test

*** Variables ***
${PATH_FILE_SETUP}              file_install\\elinkviewer-1.3.0-win86.exe
${PATH_FILE_SETUP_VISUAL}       file_install\\vc_redist.x86.exe
${CMD_ELINKVIEWER_HELP}         elinkviewer -help
${CMD_ELINKVIEWER_START}        elinkviewer
${CMD_REMOTE_DEFAULT}           elinkviewer     -host=${SERVER_IP}  -password=${PASSWORD}
${CMD_REMOTE_OPTIONSFILE}       elinkviewer -optionsfile=optionsfile.vnc
${CMD_SKILL_APP}                Taskkill /IM elinkviewer.exe /F

*** Keywords ***

Command Suite Setup
    Run Keyword If      "${VERSION}"=="win64"         Set Global Variable     ${PATH_FILE_SETUP}       file_install\\elinkviewer-1.3.0-win64.exe
    Install Elinkviewer     ${PATH_FILE_SETUP}      ${VERSION}

Command Teardown
    Send Command Line       ${CMD_SKILL_APP}
    Run Keyword If          "${VERSION}"=="win64"       Set Global Variable     ${PATH_FILE_SETUP_VISUAL}       file_install\\vc_redist.x64.exe
    Uninstall Visual        ${PATH_FILE_SETUP_VISUAL}       ${VERSION}

Go To Folder Store App
    ${CURRENT PATH} =      get current path
    Set Global Variable      ${CURRENT PATH}
    Goto Folder     C:\\Program Files\\eLinkViewer

Comeback Folder Test
    Goto Folder     ${CURRENT PATH}

*** Test Cases ***
Test Case Command Line 001
    [Documentation]     Show commad line help
        ...     - Open aplication command prompt on Windowns
        ...     - Go to the eLinkViewer folder
        ...     - Run command line elinkviewer -help
    Send Command Line   ${CMD_ELINKVIEWER_HELP}
    ${status}           Verify Elink Viewer Help
    should be equal     ${status}      ${True}

Test Case Command Line 002
    [Documentation]     Open aplication eLinkviewer
        ...     - Open aplication command prompt on Windowns
        ...     - Go to the eLinkViewer folder
        ...     - Run command line elinkviewer
        ...     - Login and connect device
    Send Command Line   ${CMD_ELINKVIEWER_START}
    ${status}   Login ELink Viewer     ${PASSWORD}
    should be equal  ${status}      ${True}
    ${status}   Verify Connection
    should be equal  ${status}      ${True}

Test Case Command Line 003
    [Documentation]     Remote to device with default
        ...     - Open aplication command prompt on Windowns
        ...     - Go to the eLinkViewer folder
        ...     - Run command line elinkviewer -host=host  -password=password
    Send Command Line   ${CMD_REMOTE_DEFAULT}
    ${status}   Verify Connection
    should be equal  ${status}      ${True}

Test Case Command Line 004
    [Documentation]     Remote to device with optionsfile
        ...     - Open aplication command prompt on Windowns
        ...     - Go to the eLinkViewer folder
        ...     - Save connection info as name optionsfile.vnc
        ...     - Run command line elinkviewer -optionsfile=optionsfile.vnc
    Send Command Line   ${CMD_REMOTE_DEFAULT}
    ${PATH_CONNECT_FILE}   Save Connection Info
    Verify Connection
    ${status}   Send Command Line   ${CMD_REMOTE_OPTIONSFILE}
    ${status}   Verify Connection
    should be equal  ${status}      ${True}
    Remove File     ${PATH_CONNECT_FILE}

Test Case Command Line 005
    [Documentation]     Open mutible aplication eLinkViewer
        ...     - Open aplication command prompt on Windowns
        ...     - Go to the eLinkViewer folder
        ...     - Run command line elinkviewer -host=host  -password=password
        ...     - Run command line elinkviewer -host=host  -password=password
    Send Command Line   ${CMD_ELINKVIEWER_START}
    ${status_connect_1}   Login ELink Viewer     ${PASSWORD}
    Send Command Line   ${CMD_ELINKVIEWER_START}
    ${status_connect_2}   Login ELink Viewer     ${PASSWORD}
    should be equal  ${status_connect_1}      ${True}
    should be equal  ${status_connect_2}      ${True}
