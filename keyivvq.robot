*** Settings ***
Library    SeleniumLibrary
Library    String
Library    FakerLibrary
Library    Dialogs
Library    ExcelLibrary
*** Variables ***

# Charger l'URL du site
${URL}      http://www.raja.fr
${DB}       C:/Users/utilisateur/Downloads/pythonexo/connexion.xlsx


*** Keywords ***
Opennn
    Open Browser    https://www.raja.fr/   chrome
    Maximize Browser Window
    # Coockie
    Click Element    xpath=/html/body/div[4]/div[2]/div/button[2]

Fakegenerate
    ${mail}   FakerLibrary.Email
    ${nom}    FakerLibrary.First Name
    ${lastname}    FakerLibrary.Last Name
    ${number}    Generate random string    9    123456789
    ${mdp}    FakerLibrary.Password
    ${add}    FakerLibrary.Address
    ${postal}    FakerLibrary.Postalcode
    ${city}    FakerLibrary.City
    
    [Return]    ${mail}    ${nom}   ${lastname}    ${number}    ${mdp}    ${add}    ${postal}    ${city}

Creationcomptep1
    [Arguments]    ${email}    ${prenom}    ${nomdefamille}    ${téléphon}    ${password}
    #bouton se connecter
    Click Element    xpath=//*[@id="dropdown-account"]/button
    # bouton crée un compte
    Click Element    xpath= //*[@id="redirectCreateAccount"]
    #bouton Statut
    Click Element    //*[@id="userInfoForm"]/div/fieldset/div[2]/label/span
    #Champs mail
    Input Text    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[2]/div/fieldset/input    ${email}
    Sleep    1
    #Champs mdp
    Input Text    xpath=/html/body/main/div/section[2]/div[2]/div[1]/form/div/div[3]/div/fieldset/input    ${password}
    Select From List By Index    //*[@id="civilitie"]    1
    #champs prenom
    Input Text    //*[@id="InfoFirstname"]    ${prenom}
    Sleep    1
    #champs nom
    Input Text    //*[@id="InfoLastname"]    ${nomdefamille}
    Sleep    1
    #champs Telephone
    Input Text    //*[@id="directPhone"]    0${téléphon}
    Sleep    1
boutonsuivant
    #scroll
    scroll to element    //*[@id="nextStepBtn"]
    Sleep    1
    #bouton suivant
    Click Element    //*[@id="nextStepBtn"]
    Sleep    1
scroll to element
    [Arguments]    ${locator}
    ${horizontal_pos}    Get Horizontal Position    ${locator}
    ${vertical_pos}    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${horizontal_pos}, ${vertical_pos})
    Sleep    1

Creationcomptep2
    [Arguments]    ${adresse}    ${ville}    ${zip}
    #champs n et voie
    Input Text    //*[@id="CompaniesAddress"]    ${adresse}

    #champs code postal
    Input Text    //*[@id="CompaniesPostCode"]    ${zip}

    #champs ville
    Input Text    //*[@id="CompaniesCity"]   ${ville}

    #Pays
    Select From List By Index    //*[@id="CompaniesCountryPost"]    1

    Sleep    3

    Execute Manual Step    valider le captcha

    Click Element    //*[@id="submitAllForm"]

Creationcompteempty
    
    #bouton se connecter
    Click Element    xpath=//*[@id="dropdown-account"]/button
    # bouton crée un compte
    Click Element    xpath= //*[@id="redirectCreateAccount"]

Closs
    Close All Browsers

ErrorCreationcomptep2
    [Arguments]    ${adresse}    ${ville}    ${zip}
    #champs n et voie
    Input Text    //*[@id="CompaniesAddress"]    ${adresse}

    #champs code postal
    Input Text    //*[@id="CompaniesPostCode"]    ${zip}

    #champs ville
    Input Text    //*[@id="CompaniesCity"]   ${ville}

    #Pays
    Select From List By Index    //*[@id="CompaniesCountryPost"]    1

    Sleep    3

Tchek1
    
    Element Should Contain    //*[@id="userInfoForm"]/div/fieldset/div[1]/span    Ce champ est obligatoire
    Element Should Contain    //*[@id="userInfoForm"]/div/div[2]/div/label[2]    Champ obligatoire  
    Element Should Contain    //*[@id="userInfoForm"]/div/div[3]/div/label[2]    Champ obligatoire 
    Element Should Contain    //*[@id="ServiceSelect"]/span    Information obligatoire
    Element Should Contain    //*[@id="userInfoForm"]/div/div[6]/div[1]/label[2]    Champ obligatoire 
    Element Should Contain    //*[@id="userInfoForm"]/div/div[6]/div[2]/label[2]    Champ obligatoire 
    Element Should Contain    //*[@id="userInfoForm"]/div/div[8]/div/label[2]    Information obligatoire



Tchek2
    Element Should Contain    //*[@id="userInfoCompletedForm"]/div/div[12]/div/label[2]    Street is mandatory. Please provide a street.
    Element Should Contain    //*[@id="userInfoCompletedForm"]/div/div[15]/div[1]/label[2]    Code postal obligatoire. 
    Element Should Contain    //*[@id="userInfoCompletedForm"]/div/div[15]/div[2]/label[2]    La ville est obligatoire. Veuillez entrer une ville


tchek3
    Element Should Contain    //*[@id="userInfoForm"]/div/div[2]/div/label[2]    Ce format est incorrect. Merci de supprimer les espaces, les caractères spéciaux et les accents
    Element Should Contain    //*[@id="userInfoForm"]/div/div[3]/div/label[2]    Le mot de passe doit contenir au moins 8 caractères dont 1 chiffre, 1 lettre majuscule et 1 lettre minuscule 
    Element Should Contain    //*[@id="userInfoForm"]/div/div[6]/div[1]/label[2]    Ce format est incorrect. Les caractères spéciaux sont interdits.
    Element Should Contain    //*[@id="userInfoForm"]/div/div[6]/div[2]/label[2]    Ce format est incorrect. Les caractères spéciaux sont interdits.
    Element Should Contain    //*[@id="userInfoForm"]/div/div[8]/div/label[2]    Ce format est incorrect. Veuillez saisir 10 chiffres.

tchek4
    Element Should Contain    //*[@id="userInfoCompletedForm"]/div/div[15]/div[1]/label[2]    Ce format est incorrect. Merci de renseigner les 5 chiffres de votre code

writeexcel
    [Arguments]    ${prenom}    ${nom}    ${email}    ${password}
   
    Open Excel Document      C:/Users/utilisateur/Downloads/pythonexo/choubidou.xlsx    choubidou
    ${line}    Set Variable   2
    ${data}    Read Excel Cell    ${line}       1

    WHILE    "${data}" != "None"
        ${line}    Evaluate    ${line}+1
        ${data}=    Read Excel Cell    ${line}   1
    END

    Write Excel Cell        ${line}    1    ${prenom}
    Write Excel Cell        ${line}    2    ${nom}
    Write Excel Cell        ${line}    3    ${password} 
    Write Excel Cell        ${line}    4    ${email}
    Save Excel Document    C:/Users/utilisateur/Downloads/pythonexo/choubidou.xlsx
    Close Current Excel Document
Recup DB
    # Fonction qui charge les data d'Excel avec la ligne comme argument
    [Arguments]    ${ligne}
    # On ouvre le doc Excel qui s'appelle connexion
    Open Excel Document    ${DB}    connexion
    # On définit 2 variables avec comme différence la colonne (2 ou 3) qui varie. Pas besoin de créer une variable ${colonne} car il y a que 2 et 3 comme valeur d'où les 2 variables dataLogin et dataPassword
    ${dataEmail}=    Read Excel Cell    ${ligne}    2
    ${dataPassword}=    Read Excel Cell    ${ligne}    3
    Close All Excel Documents
    [Return]    ${dataEmail}    ${dataPassword}
    # Il retourne les 2 variables

Se connecter
    [Arguments]    ${email}    ${password}
    # Cliquer sur le bonhomme pour afficher la fenêtre de connexion
    Click Element    xpath=/html/body/div[3]/div/header/div[6]
    # Remplir les data user
    Run Keyword IF    "${email}" != "None"    Input Text    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[1]/input[5]    ${email}
    Run Keyword IF    "${password}" != "None"    Input Password    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[1]/fieldset/div[2]/input    ${password}
    # Valider le formulaire
    Click Button    xpath=/html/body/div[3]/div/header/div[6]/div/section/div[1]/section[1]/form/div[3]/button
    Sleep    5



scroll to down
    
    Execute Javascript    window.scrollTo(1000, 1000)


RecupPanier

    Open Excel Document    C:/Users/utilisateur/Downloads/RajaJDD__300__0.xlsx    mondoc
    ${ligne}    ${colonne}       set variable    2    4    
    ${reference}=    Read Excel Cell    ${ligne}   1
    ${nom}=    Read Excel Cell    ${ligne}   2
    ${prix}=    Read Excel Cell    ${ligne}   3
    ${categorie}=    Read Excel Cell    ${ligne}   4  
    ${sousCategorie}=    Read Excel Cell    ${ligne}   5
    ${sousCategorie2}=    Read Excel Cell    ${ligne}   6
    ${bonPlans}=    Read Excel Cell    ${ligne}   7
    ${marque}=    Read Excel Cell    ${ligne}   8
    ${matiere}=    Read Excel Cell    ${ligne}   9
    ${longueur}=    Read Excel Cell    ${ligne}   10
    ${largeur}=    Read Excel Cell    ${ligne}   11
    ${diametre}=    Read Excel Cell    ${ligne}   12
    ${Couleur}=    Read Excel Cell    ${ligne}   13
    ${Nouveauxproduits}=    Read Excel Cell    ${ligne}   14 
    ${Chargeenkg}=    Read Excel Cell    ${ligne}   15
    ${Typedefermeture}=    Read Excel Cell    ${ligne}   16
    ${Epaisseurenmicro}=    Read Excel Cell    ${ligne}   17
    ${Adapteaucontactalimentaire}=    Read Excel Cell    ${ligne}   18
    ${Cannelure}=    Read Excel Cell    ${ligne}   19

    [Return]    ${nom}     ${prix}    ${categorie}    ${sousCategorie}    ${sousCategorie2}    ${bonPlans}     ${marque}    ${matiere}    ${longueur}    ${largeur}    ${diametre}     
    ...    ${Couleur}    ${Nouveauxproduits}    ${Chargeenkg}    ${Typedefermeture}    ${Epaisseurenmicro}     ${Epaisseurenmicro}    ${Adapteaucontactalimentaire}    ${Cannelure}    
Commande_panier 

    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}
    
    ${nom}     ${prix}    ${categorie}    ${sousCategorie}    ${sousCategorie2}    ${bonPlans}     ${marque}    ${matiere}    ${longueur}    ${largeur}    ${diametre}     ${Couleur}    ${Nouveauxproduits}    ${Chargeenkg}    ${Typedefermeture}    ${Epaisseurenmicro}     ${Epaisseurenmicro}    ${Adapteaucontactalimentaire}    ${Cannelure}=    RecupPanier    

    Page Should Contain Element    //*[@id="dropdown-account"]/span[2]
    Sleep    1
    Click Element    //*[@id="algolia-loader"]
    Sleep    1
    Input Text    //*[@id="searchAlgolia"]/div[1]/section/div/div/input    Ruban
    Sleep    1


    Click Element    //*[@id="filters-layer-content"]/div[2]/section[1]/div/button
    Sleep    2
    Run Keyword If    "${categorie}" != "None"    Click Element    //*[contains(text(),'${categorie}')]
    Sleep    2
    Run Keyword If    "${sousCategorie}" != "None"    Click Element    //*[contains(text(),'${sousCategorie}')]
    Sleep    2
    Run Keyword If    "${sousCategorie2}" != "None"    Click Element    //*[contains(text(),'${sousCategorie2}')]
    Sleep    2
    Run Keyword If    "${marque}" != "None"    Click Element    //*[contains(text(),'${marque}')]
    Sleep    2
    Run Keyword If    "${matiere}" != "None"    Click Element    //*[contains(text(),'${matiere}')]
    Sleep    2
    Run Keyword If    "${longueur}" != "None"    Click Element    //*[contains(text(),'${longueur}')]
    Sleep    2
    Run Keyword If    "${largeur}" !="None"    Click Element    //*[contains(text(),'${largeur}')]
    Sleep    2
    scroll to down
    Run Keyword If    "${Couleur}" !="None"    Click Element    //*[@id="filters-layer-content"]/button
    Sleep    2
    scroll to down
    Run Keyword If    "${Couleur}" !="None"    Click Element    //*[contains(text(),'${Couleur}')]
    Sleep    2
    scroll to down
    Run Keyword If    "${Nouveauxproduits}" !="None"    Click Element    //*[@id="filters-layer-content"]/div[2]/section[7]/div/div/label/input
    Sleep    2
    
    Click Element    //*[@id="searchAlgolia"]/div[1]/div[1]/div[3]/div[3]/div/article/a[2]
    Sleep    2
    Click Element    //*[@id="btnQuantityMore_471BLA"]
    Sleep    2
    Click Element    //*[@id="btnQuantityMore_471BLA"]
    Sleep    2
    Click Element    //*[@id="addToCart"]/span[2]
    Sleep    1 
    Page Should Contain    Le produit suivant a bien été ajouté
    Sleep    15

Validation du panier
    ${numerocb}    ${cvc}    ${mois}    ${year}    fakercartebleu
    ${email}    ${password}    Recup DB   2
    Se connecter    ${email}    ${password}    
    ${element_exists} =    Run Keyword And Return Status    Element Should Contain     //*[@id="basket-dropper"]/span/span[3]    0
    Run Keyword If    ${element_exists}    achat panier vide    ELSE     achat panier non vide
    Page Should Contain    Veuillez cocher la case ci-dessus
    Sleep    2
    Click Element    xpath=/html/body/div[3]/main/div/section/div/div[1]/label/input
    Sleep    2
    Click Element    //*[@id="next-step-btn"]
    Sleep    2


    #Tchek error local
    scroll to element    xpath=/html/body/div/div[2]/div[2]/a[2]
    Sleep    2
    Click Element    //*[@id="payment-submit"]
    Sleep    2
    Element Should Contain    //*[@id="payment-cardnumber-error"]    Le numéro de la carte est obligatoire
    Element Should Contain    //*[@id="payment-cardexpirationmonth-error"]    La date d'expiration est invalide
    Sleep    2
    # On entre les info "cas passant"
    Input Text    //*[@id="payment-cardnumber"]    ${numerocb}
    Sleep    2
    Input Text    //*[@id="payment-cardholdername"]    Jean MICHEL la Grosse Carte
    Sleep    2
    Select From List By Value    //*[@id="payment-cardexpirationmonth"]   ${mois}
    Sleep    2
    Sleep    2
    Select From List By Value    //*[@id="payment-cardexpirationyear"]    20${year}
    Sleep    2
    Input Text    //*[@id="payment-cvc"]    ${cvc}
    Sleep    2
    scroll to element    xpath=/html/body/div/div[2]/div[2]/a[2]
    Click Element    //*[@id="payment-submit"]

    


achat panier non vide
    ${numerocb}    ${cvc}    ${mois}    ${year}    fakercartebleu
    Click Element    //*[@id="basket-dropper"]/span/span[2]
    Sleep    2
    Click Element    //*[@id="quickcart-container"]/div[1]/button
    Sleep    2
    Click Element    //*[@id="nextBtnStep1"]
    Sleep    2
    Click Element    //*[@id="next-step-btn"]
    Sleep    2
    Click Element    //*[@id="next-step-btn"]
    Sleep    2



achat panier vide
    ${numerocb}    ${cvc}    ${mois}    ${year}    fakercartebleu
    Sleep    2
    Click Element    //*[@id="algolia-loader"]
    Sleep    2
    Input Text    //*[@id="searchAlgolia"]/div[1]/section/div/div/input    Ruban
    Sleep    2
    Click Element    //*[@id="searchAlgolia"]/div[1]/div[1]/div[3]/div[3]/div[1]/article/a[2]
    Sleep    2
    scroll to element    //*[@id="card-0"]/td[1]
    Click Element    //*[@id="btn-quantity-more-ADP83-desktop"]
    Sleep    2
    Click Element    //*[@id="block-table-0"]/div[4]/button
    Sleep    2
    Click Element    //*[@id="open-cart-confirmation"]
    Sleep    2
    Click Element    //*[@id="nextBtnStep1"]
    Sleep    2
    Click Element    //*[@id="next-step-btn"]
    Sleep    2
    Click Element    //*[@id="next-step-btn"]
    Sleep    2


fakercartebleu
    
    ${numerocb}    FakerLibrary.Credit Card Number
    ${cvc}    FakerLibrary.Credit Card Security Code
    ${date}    FakerLibrary.Credit Card Expire
    @{expire}    Split String    ${date}    /
    ${mois}    Set Variable    ${expire}[0]
    ${year}    Set Variable    ${expire}[1]
    [Return]    ${numerocb}    ${cvc}    ${mois}    ${year}
    