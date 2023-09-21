*** Settings ***
Library             SeleniumLibrary
Resource            resources/Res.robot
# Test Setup s'éxécute avant chaque cas de test
Test Setup          Open Google
# Test Teardown s'exécute après chaque cas de test
Test Teardown       Close Browser

*** Test Cases ***
Connexion Valide
    [Tags]    success01

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}

Connexion invalide - Champ obligatoire manquant
    [Tags]    autE01

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   3
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[1]/label    Information obligatoire
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[2]/label    Information obligatoire

Connexion invalide - Données invalide
    [Tags]    autE02

    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   4
    Se connecter    ${email}    ${password}

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[3]/span   Couple login/mot de passe invalide

Créer un compte Valide
    [Tags]    success02
    
    # Appel du keyword pour accèder à la page de Création
    accesCreation
    Sleep    2
    
    # COmplétion de la page 1 Informations
    ${email}    ${password}    ${prenom}    ${nom}    ${adress}    ${ville}    ${cp}    ${number}    fakerGenerate
    Création de compte Page 1   ${email}    ${password}    ${prenom}    ${nom}    ${number}    1

    # Appel du keyword pour valider le formulaire informations 
    validationCreationP1
    Sleep    2

    # Complétion de la page 2 Adresse
    Création de compte Page 2   ${adress}    ${ville}    ${cp}
    Sleep    2

    # Vérifier la création du compte
    #Page Should Contain    Félicitations ! Votre compte a bien été créé
    Sleep    5

    # Appel du Keyword pour enregistrer les data dans Excel
    Envoi DB    ${email}    ${password}    ${prenom}    ${nom}

Créer un compte invalide - Champ obligatoire manquant
    [Tags]    creE01
    
    # Appel des keywords
    accesCreation
    validationCreationP1

    # Le message d’erreur doit contenir le texte
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/fieldset/div[1]/span    Ce champ est obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[2]/div/label[2]    Champ obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[3]/div/label[2]    Champ obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[5]/div/span   Information obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[6]/div[1]/label[2]    Champ obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[6]/div[2]/label[2]    Champ obligatoire
    Element Should Contain    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[8]/div/label[2]    Information obligatoire
    Sleep    5

    # Complétion de la page 1
    scroll to Element    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[1]/div[1]/div[2]
    ${email}    ${password}    ${prenom}    ${nom}    ${adress}    ${ville}    ${cp}    ${number}    FakerGenerate
    Création de compte Page 1   ${email}    ${password}    ${prenom}    ${nom}    ${number}    1

    # Appel du keyword pour valider le formulaire informations 
    validationCreationP1
    Sleep    2

    # Valider le formulaire adresse 
    Click Button    xpath=/html/body/main/div/section[2]/div[2]/div[3]/form/div/div[24]/button[1]
    Sleep    10

Créer un compte invalide - Données invalide
    [Tags]    creE02

    # Appel du keyword pour accèder à la page de Création
    accesCreation
    Sleep    2
    
    # Remplir le formulaire avec des données fausses page 1
    Création de compte Page 1   test @gmail.com    testpass    Prenom64    Nom64   64    1

    # Appel du keyword pour valider le formulaire informations 
    validationCreationP1
    Sleep    5

    # Complétion de la page 1
    scroll to Element    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[1]/div[1]/div[2]
    ${email}    ${password}    ${prenom}    ${nom}    ${EMPTY}     ${EMPTY}     ${EMPTY}     ${number}    fakerGenerate
    Création de compte Page 1   ${email}    ${password}    ${prenom}    ${nom}    ${number}    1

    # Appel du keyword pour valider le formulaire informations 
    validationCreationP1
    Sleep    2
    
    # Remplir et valider le formulaire avec des données fausses page 2
    Création de compte Page 2   Z?ne51    Par%s    3310
    Sleep    10


Navigation Utilisateur - Selectionner un produit
    [Tags]    navN01
    # SE CONNECTER
    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}
    Page Should Contain Element    //*[@id="dropdown-account"]/span[2]
    Sleep    1
    
    # Appel du keyword de selection d'un produit
    Selectionner un produit    3

    # Voir mon panier
    Click Element    //*[@id="open-cart-confirmation"]
    Sleep    5

Navigation Utilisateur - Selectionner des produits
    [Tags]    navN02
    # SE CONNECTER
    # Appel des keywords nécessaires
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}
    Page Should Contain Element    //*[@id="dropdown-account"]/span[2]
    Sleep    1
    
    ${i}=    Set Variable    5

    WHILE    "${reference}" != "None"
        # Appel du keyword de selection d'un produit
        Selectionner un produit    ${i}
        ${i}=    Evaluate    ${i}+1
        IF    "${i}" != "7"
            Click Element    //*[@id="continuer-achat"]
        END
        Sleep    5
    END
    
    # Voir mon panier
    Click Element    //*[@id="open-cart-confirmation"]
    Sleep    5
    
Validation du panier
    [Tags]    navN02
   # Validation du panier
    Validation du panier




