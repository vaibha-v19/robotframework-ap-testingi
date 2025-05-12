*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}        https://reqres.in
${endpoint}        /api/users/599
${api_key}         reqres-free-v1

* Test Cases ***
Get Info With API Key
    &{headers}=    Create Dictionary    x-api-key=${api_key}
    Create Session    mySession    ${base_url}    headers=${headers}
    ${body}=    Create Dictionary   name=pawan      job=engineer
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=        Put Request    mySession    ${endpoint}      data=${body}    headers=${header}


    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    ${status_code}      Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    pawan
    Should Contain    ${res_body}    engineer
