*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}        https://reqres.in
${endpoint}        /api/users?page=2
${api_key}         reqres-free-v1

*** Test Cases ***
Get Info With API Key
    &{headers}=    Create Dictionary    x-api-key=${api_key}
    Create Session    mySession    ${base_url}    headers=${headers}
    ${response}=    Get Request    mySession    ${endpoint}
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${body}=    convert to string   ${response.content}
    Should Contain    ${body}    Michael
    Log To Console    Body contains Michael