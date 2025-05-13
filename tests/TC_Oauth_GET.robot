*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}        https://api.github.com
${endpoint}        /user
${access_token}    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

*** Test Cases ***
Get User Info With OAuth
    &{headers}=    Create Dictionary    Authorization=token ${access_token}
    Create Session    mySession    ${base_url}    headers=${headers}
    ${response}=    Get Request    mySession    ${endpoint}

    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    200
    Log To Console    Status Code: ${status_code}