*** Settings ***
Library    AzureADAuthentication.py
Library    RequestsLibrary

*** Variables ***
${tenant_id}    your_tenant_id
${client_id}    your_client_id
${client_secret}    your_client_secret
${base_url}    https://graph.microsoft.com/v1.0

*** Test Cases ***
Get User Info
    ${auth}=    AzureADAuthentication    ${tenant_id}    ${client_id}    ${client_secret}
    ${token}=    Get Access Token    ${auth}
    Create Session    mySession    ${base_url}    headers={"Authorization": "Bearer ${token}"}
    ${response}=    Get Request    mySession    /me
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    Log To Console    ${response.json()}