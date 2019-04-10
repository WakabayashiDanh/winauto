*** Settings ***
Library  ../library/HandlereLinkViewer.py   C:\\Program Files\\eLinkViewer     ${SERVER_IP}        ${password}
Library  ../library/HandlerInstall.py

Suite Setup     Command Suite Setup
Suite Teardown	Command Teardown

*** Keywords ***

Command Suite Setup
    ${PATH_FILE_SETUP} =    Set Variable        file_install\\elinkviewer-1.3.0-win86.exe
    Run Keyword If      "${VERSION}"=="win64"         Set Global Variable     ${PATH_FILE_SETUP}       file_install\\elinkviewer-1.3.0-win64.exe
    Install Elinkviewer     ${PATH_FILE_SETUP}

Command Teardown
    ${PATH_FILE_SETUP_VISUAL} =    Set Variable        file_install\\vc_redist.x86.exe
    Run Keyword If      "${VERSION}"=="win64"       Set Global Variable     ${PATH_FILE_SETUP_VISUAL}       file_install\\vc_redist.x64.exe
    Log     ${VERSION}
    Uninstall Visual        ${PATH_FILE_SETUP_VISUAL}       ${VERSION}


*** Test Cases ***
Test Case Command Line 001
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
    ${status}   Show Elink Viewer Help
    Log     ${status}
    should be equal  ${status}      ${True}

Test Case Command Line 002
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
    ${status}   Start Elink Viewer By Command
    Log     ${status}
    should be equal  ${status}      ${True}

Test Case Command Line 003
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
    ${status}   Connect Device By Default Option
    Log     ${status}
    should be equal  ${status}      ${True}

Test Case Command Line 004
    [Documentation]     Install eLinkViewer 32bit
        ...     - Install eLinkViewer
        ...     - Agree auto install Microsoft Visual C++ 2015
        ...     - After install, open eLinkViewer and connect it
    ${status}   Connect Device With New Option
    Log     ${status}
    should be equal  ${status}      ${True}