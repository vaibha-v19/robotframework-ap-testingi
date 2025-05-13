*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}        https://reqres.in
${endpoint}        /api/users
${api_key}         reqres-free-v1

* Test Cases ***
Get Info With API Key
    Create Session    mySession    ${base_url}
    &{headers}=    Create Dictionary    x-api-key=${api_key}    Content-Type=application/json
    ${body}=    Create Dictionary   name=pawan      job=trainer
    #${header}=      Create Dictionary   Content-Type=application/json
    ${response}=        Post Request    mySession    ${endpoint}      data=${body}      headers=${headers}
    
    
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    ${status_code}      Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    pawan
    Should Contain    ${res_body}    trainer
