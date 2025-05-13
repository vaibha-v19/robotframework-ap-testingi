*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}        https://httpbin.org
${endpoint}        /basic-auth/user/passwd
${username}        user
${password}        passwd

*** Test Cases ***
Get Info With Basic Auth
    Create Session    mySession    ${base_url}
    ${response}=    GET On Session    mySession    ${endpoint}    auth=${username}:${password}

    ${status_code}=     Convert To String   ${response.status_code}
    Should Be Equal    ${status_code}    200
    Log To Console    Status Code: ${status_code}
    Log To Console    Response: ${response.content}
    Log To Console    Headers: ${response.headers}
