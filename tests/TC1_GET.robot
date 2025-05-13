*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}        https://reqres.in
${endpoint}        /api/users?page=2
${api_key}         reqres-free-v1
${expected_content_type}    application/json; charset=utf-8

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

    #Headers
    ${content_type_value}=    get from dictionary    ${response.headers}    Content-Type
    Log To Console    Content-Type: ${content_type_value}

    Should Be Equal    ${content_type_value}    ${expected_content_type}

    #Cookies
    Log To Console    ${response.cookies}
    Should Be Empty    ${response.cookies}