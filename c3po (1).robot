*** Settings ***
Library             SeleniumLibrary
Resource            resources/Res.robot

# Test Setup s'éxécute avant chaque cas de test
Test Setup          Open Google
# Test Teardown s'exécute après chaque cas de test
Test Teardown       Close Browser


*** Test Cases ***
Connexion Valide
    [Tags]    success

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}

Connexion invalide - Champ obligatoire manquant
    [Tags]    error

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   3
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[1]/label    Information obligatoire
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[2]/label    Information obligatoire

Connexion invalide - Données invalide
    [Tags]    error

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   4
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[3]/span   Couple login/mot de passe invalide