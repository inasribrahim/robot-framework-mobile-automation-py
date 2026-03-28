*** Settings ***
Documentation    Localization Configuration
...              This file manages language selection for the test framework
...              Change the LANGUAGE variable to switch between languages
...              Supported languages: en (English), ar (Arabic)

*** Variables ***
# Set the active language (en, ar)
${LANGUAGE}    en

*** Keywords ***
Load Localization
    [Documentation]    Load the appropriate localization file based on LANGUAGE setting
    Run Keyword If    '${LANGUAGE}' == 'en'    Import Resource    ${CURDIR}/en.robot
    Run Keyword If    '${LANGUAGE}' == 'ar'    Import Resource    ${CURDIR}/ar.robot
    Log    Loaded localization for language: ${LANGUAGE}
