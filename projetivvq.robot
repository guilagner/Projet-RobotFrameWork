*** Settings ***
Library    SeleniumLibrary
Library    String
Library    FakerLibrary
Library    Dialogs
Resource    keyivvq.robot
Library    ExcelLibrary
Test Setup    Opennn
Test Teardown    Closs

*** Variables ***


*** Test Cases ***
CreateAccept
    [Tags]    success
    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}    ${add}    ${postal}    ${city}    Fakegenerate
    Creationcomptep1    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp} 
    boutonsuivant
    Creationcomptep2    ${add}    ${city}    ${postal}
    writeexcel          ${nom}   ${lastname}     ${mail}    ${mdp}

CreateError1
    [Tags]    error1
    Creationcompteempty
    boutonsuivant
    Tchek1
    scroll to element    //*[@id="userInfoForm"]/div/div[1]/div[1]/div[2]    
    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}    ${add}    ${postal}    ${city}    Fakegenerate
    Creationcomptep1    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}
    Sleep    1
    boutonsuivant
    scroll to element    //*[@id="submitAllForm"]
    Click Button    //*[@id="submitAllForm"]
    Sleep    1
    Tchek2
CreateError2
    [Tags]    error2
    Creationcomptep1    Guillaumé@gmail.com    guillaum3    aulagn$    6516    azer
    boutonsuivant
    tchek3
    scroll to element    //*[@id="userInfoForm"]/div/div[1]/div[1]/div[2]    
    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}    ${add}    ${postal}    ${city}    Fakegenerate
    Creationcomptep1    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}
    boutonsuivant
    ErrorCreationcomptep2    ${add}    ${city}    1
    tchek4
Connexion Valide
    [Tags]    COsuccess

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}

Connexion invalide - Champ obligatoire manquant
    [Tags]    COerror

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   3
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[1]/label    Information obligatoire
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[2]/label    Information obligatoire

Connexion invalide - Données invalide
    [Tags]    COerror1

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   4
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[3]/span   Couple login/mot de passe invalide



Commande panier [nom article]
    [Tags]    panier


    Commande panier

Validation d'achat
    [tags]    buy
    Validation du panier


