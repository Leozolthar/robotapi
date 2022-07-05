*Settings*
Documentation           POST /partners

Library                 RequestsLibrary
Library                 RobotMongoDBLibrary.Delete


*Variables*

${URL_BASE}     http://localhost:3333/partners
&{MONGO_URI}    connection=mongodb+srv://bugereats:11m1ja011@cluster0.jkctb.mongodb.net/PartnerDB?retryWrites=true&w=majority    database=PartnerDB   collection=partner


*Test Cases*
Should create a new partner
    
    # payload é 'carga util'
    ${payload}      Create Dictionary
    ...             name=Leo robo 
    ...             email=leorobo@contato.com
    ...             whatsapp=11999999991
    ...             business=Restaurante


    ${headers}      Create Dictionary
    ...             Content-Type=application/json
    ...             auth_user=qa
    ...             auth_password=ninja

    #Nestes dois comandos abaixo, o usuário será deletado antes de realizar o POST novamente. Assim, não haverá problemas de duplicidade.
    ${filter}           Create Dictionary       
    ...                 name=Leo robo
    ...                 email=leorobo@contato.com
    ...                 whatsapp=11999999991
    ...                 business=Restaurante

    DeleteOne           ${MONGO_URI}            ${filter}


    ${response}     POST        ${URL_BASE}     json=${payload}     headers=${headers}


    Status Should Be        201