*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      chrome
${SIGNINBUTTON}    xpath=//*[@type='submit']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*/header/div/h6
${PASSWORD_WARNING}     xpath=//*/div[1]/div[3]/span
${LOGOUTBUTTON}     xpath=//*/div/ul[2]/div[2]
${ADDPLAYERBUTTON}      xpath=//*/div[2]/div/div/a/button/span[1]
${PLAYERNAMEINPUT}      xpath=//*/div[2]/div/div/input
${PLAYERSURNAMEINPUT}       xpath=//*/div[3]/div/div/input
${PLAYERAGEINPUT}       xpath=//*/div[7]/div/div/input
${PLAYERMAINPOSITIONINPUT}      xpath=//*/div[11]/div/div/input
${SUBMITBUTTON}     xpath=//*/div[3]/button[1]/span[1]
${PLAYERSBUTTON}    xpath=//*/ul[1]/div[2]/div[2]/span
${FILTERTABLEBUTTON}        xpath=//*/div[2]/span[3]/button
${FILTERNAME}       xpath=//*/div[2]/div[1]/div/div/div/input
${FILTERSURNAME}        xpath=//*/div[2]/div[2]/div/div/div/input
${MAINPOSITIONTABLE}        xpath=//*[@id='MUIDataTableBodyRow-0']/td[4]/div[2]
${TOASTER}      xpath=//*[@id="__next"]/div[2]/*
${ORIG_TIMEOUT}     15

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click On The Signin Button
    Assert dashboard
    [Teardown]    Close Browser
Login with wrong password
    Open login page
    Type in email
    Type in wrong_password
    Click On The Signin Button
    Assert password_warning
    [Teardown]    Close Browser
Logout
    Open Login Page
    Type In Email
    Type In Password
    Click On The Signin Button
    Assert Dashboard
    Click On The Logout Button
    Assert Login
    [Teardown]    Close Browser
Add player
    Open login page
    Type in email
    Type in password
    Click On The Signin Button
    Assert dashboard
    Click on the Add player button
    Type In Name
    Type In Surname
    Type In Age
    Type In Main Position
    Click On The Submit Button
    [Teardown]    Close Browser
Add player verification
    Open login page
    Type in email
    Type in password
    Click On The Signin Button
    Assert dashboard
    Click On The Players Button
    Click On The Filter Table Button
    Type In Filter Name
    Type In Filter Surname
    Assert Main Position
    [Teardown]    Close Browser
*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}   user02@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}   Test-1234
Type in wrong_password
    Input Text      ${PASSWORDINPUT}   test-1234
Click on the Signin button
    Click Element       ${SIGNINBUTTON}
Click on the Logout button
    Click Element       ${LOGOUTBUTTON}
Assert dashboard
    Wait Until Element Is Visible       ${PAGELOGO}
    title should be     Scouts panel
    Capture Page Screenshot     alert.png
Assert password_warning
    Wait Until Element Is Visible       ${PASSWORD_WARNING}
    Wait Until Element Contains     ${PASSWORD_WARNING}   Identifier or password invalid.
    Capture Page Screenshot     alert.png
Assert Login
    Wait Until Element Is Visible       ${SIGNINBUTTON}
    title should be     Scouts panel - sign in
    Capture Page Screenshot     alert.png
Click on the Add player button
    Click Element       ${ADDPLAYERBUTTON}
Type in name
    Input text      ${PLAYERNAMEINPUT}  Second
Type in surname
    Input text      ${PLAYERSURNAMEINPUT}   Attempt
Type in age
    Input text      ${PLAYERAGEINPUT}   20.10.1995
Type in main position
    Input text      ${PLAYERMAINPOSITIONINPUT}   Forward
Click on the Submit button
    Wait Until Element Is Visible       ${SUBMITBUTTON}
    Click Element       ${SUBMITBUTTON}
    Wait Until Element Contains       ${TOASTER}    Added player.
Click on the Players button
    Click Element       ${PLAYERSBUTTON}
Click on the filter table button
    Wait Until Element Is Visible       ${FILTERTABLEBUTTON}
    Click Element       ${FILTERTABLEBUTTON}
Type in filter name
    Input text      ${FILTERNAME}   Second
Type in filter surname
    Input text      ${FILTERSURNAME}    Attempt
Assert main position
    Wait Until Element Contains     ${MAINPOSITIONTABLE}    Forward