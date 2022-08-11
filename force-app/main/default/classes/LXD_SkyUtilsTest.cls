@isTest
public with sharing class LXD_SkyUtilsTest {
    @IsTest
    static void ShouldGetInformationAboutEnteOperativo(){
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                'Complete',
                                                '{'+
                                                    '"COD_MESSAGE": null,'+
                                                    '"output": {'+
                                                        '"MSG_ERROR": null,'+
                                                        '"DET_ERROR": null,'+
                                                        '"RETRY_STEP": null,'+
                                                        '"RETRY_ID_PADRE": null'+
                                                    '},'+
                                                    '"result": {'+
                                                        '"ID_DISTRIBUIDOR": "DI19100061",'+
                                                        '"ID_MASTER": "401000009180",'+
                                                        '"TIPO_DISTRIBUIDOR": "OK",'+
                                                        '"NOMBRE_DISTRIBUDOR": "DI COMPLETO",'+
                                                        '"ESTADO": "DF",'+
                                                        '"CALLE": "Vianilla 244",'+
                                                        '"NUMERO_INT": "0000032322",'+
                                                        '"COLONIA": "MARIO MORENO",'+
                                                        '"DEL_MUNICIPIO": "MARIO MORENO",'+
                                                        '"CIUDAD": "DF",'+
                                                        '"CP": "08400",'+
                                                        '"CALLEREF1": "Vianilla 244",'+
                                                        '"CALLEREF2": "Vianilla 244",'+
                                                        '"COMENTARIOS": "OK"'+
                                                    '}'+
                                                '}',
                                                null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Boolean enteOperativoExiste = LXD_SkyUtils.checkEnteOperativo('DI19100061');
        Test.stopTest(); 
        System.assert(enteOperativoExiste);
    }

    @IsTest
    static void ShouldGetAnErrorFromMethodConsultaEnteOperativo(){
        String error;
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                'Error',
                                                '{'+
                                                    '"DET_ERROR": "Error en el flujo de SAP."'+
                                                '}',
                                                null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            try{
                LXD_SkyUtils.checkEnteOperativo('DI19100061');
            }catch(Exception e){
                error=e.getMessage();
            }
        Test.stopTest(); 
        System.assertEquals('{"DET_ERROR": "Error en el flujo de SAP."}', error);
    }

    @IsTest
    static void ShouldRecieveASuccessFromCreateClaveOperativa(){
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                        'Success',
                                                        'Se creo correctamente el contacto',
                                                        null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account cuenta = new Account (
            LXD_N_Distribuidor__c = 'DI111111',
            Name='Test'
        );
        insert cuenta;
        Contact contacto = new Contact(
            LastName = 'test',
            FirstName = 'test',
            MiddleName = 'test',
            Suffix = 'test',
            Phone = '111111111',
            MobilePhone = '11111111',
            Email = 'test@test.com',
            LXD_Clave_operativa__c = 'TT00001',
            LXD_Estatus_de_la_clave_operativa__c = 'Activo',
            LXD_Tipo_de_clave_operativa__c = 'Técnico',
            AccountId = cuenta.Id,
            MailingPostalCode = '2158',
            MailingCity = 'Buenos Aires',
            Title = 'Tecnico',
            LXD_Nivel_de_estudios__c = 'Carrera técnica',
            MX_SKY_NumExtEnv__c = '12',
            MX_SKY_NumIntEnv__c = '12',
            MX_SKY_ColoiaEnv__c = 'test',
            MX_SKY_MuniAlca__c = 'test',
            MX_SKY_EntrecalleUnoEnv__c = 'test',
            MX_SKY_EntrecalIeEnvDos__c = 'test',
            LXD_Estatus_de_la_relacion__c = 'Activo',
            LXD_Atributos__c = 'test',
            LXD_Banderas__c = 'test',
            MailingCountry = 'Mexico',
            LXD_Fecha_alta__c = date.newInstance(1987, 12, 17),
            LXD_Genero__c = 'Masculino',
            LXD_Nacionalidad__c = 'MEXICANA',
            LXD_Estado_civil__c = 'Soltero',
            LXD_Numero_ID__c = '11111111',
            LXD_Dato_secreto__c = 'test',
            LXD_Notas_1__c = 'test',
            LXD_Notas_2__c = 'test',
            LXD_Contrasena_personal__c = 'test'
        );
        insert contacto;
        Test.startTest();
            Boolean respuesta = LXD_SkyUtils.AltaClaveOperativa(contacto.Id);
        Test.stopTest();
        system.assert(respuesta);
        
    }

    @IsTest
    static void ShouldRecieveAnErrorFromCreateClaveOperativa(){
        String error;
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                        'Error',
                                                        'No se pudo crear el contacto',
                                                        null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account cuenta = new Account (
            LXD_N_Distribuidor__c = 'DI111111',
            Name='Test'
        );
        insert cuenta;
        Contact contacto = new Contact(
            LastName = 'test',
            FirstName = 'test',
            MiddleName = 'test',
            Suffix = 'test',
            Phone = '111111111',
            MobilePhone = '11111111',
            Email = 'test@test.com',
            LXD_Clave_operativa__c = 'TT00001',
            LXD_Estatus_de_la_clave_operativa__c = 'Activo',
            LXD_Tipo_de_clave_operativa__c = 'Técnico',
            AccountId = cuenta.Id,
            MailingPostalCode = '2158',
            MailingCity = 'Buenos Aires',
            Title = 'Tecnico',
            LXD_Nivel_de_estudios__c = 'Carrera técnica',
            MX_SKY_NumExtEnv__c = '12',
            MX_SKY_NumIntEnv__c = '12',
            MX_SKY_ColoiaEnv__c = 'test',
            MX_SKY_MuniAlca__c = 'test',
            MX_SKY_EntrecalleUnoEnv__c = 'test',
            MX_SKY_EntrecalIeEnvDos__c = 'test',
            LXD_Estatus_de_la_relacion__c = 'Activo',
            LXD_Atributos__c = 'test',
            LXD_Banderas__c = 'test',
            MailingCountry = 'Mexico',
            LXD_Fecha_alta__c = date.newInstance(1987, 12, 17),
            LXD_Genero__c = 'Masculino',
            LXD_Nacionalidad__c = 'MEXICANA',
            LXD_Estado_civil__c = 'Soltero',
            LXD_Numero_ID__c = '11111111',
            LXD_Dato_secreto__c = 'test',
            LXD_Notas_1__c = 'test',
            LXD_Notas_2__c = 'test',
            LXD_Contrasena_personal__c = 'test'
        );
        insert contacto;
        Test.startTest();
            try{
                LXD_SkyUtils.AltaClaveOperativa(contacto.Id);
            }catch(Exception e){
                error=e.getMessage();
            }
        Test.stopTest(); 
        System.assertEquals('No se pudo crear el contacto', error);
        
    }

    @IsTest
    static void shouldRecieveListOfGradesOfUserFromMoodle(){
        String userCode = '';
        String responseBody ='['+
        '    {'+
        '        "Usuario": "AA68735",'+
        '        "Nombre": "ALONSO GEOVANI ARZATE SUSANO",'+
        '        "Curso": "Auto capacitación sobre el Receptor Digital XH10\t\t\t",'+
        '        "Categoria": "Pruebas",'+
        '        "Fecha": "2017-04-26 17:46:49",'+
        '        "Calificacion": "100.00000"'+
        '    },'+
        '    {'+
        '        "Usuario": "AA68735",'+
        '        "Nombre": "ALONSO GEOVANI ARZATE SUSANO",'+
        '        "Curso": "Procedimientos_Operativos_y_Seguridad_en_el_Trabajo",'+
        '        "Categoria": "Cursos técnicos",'+
        '        "Fecha": "2017-04-26 17:46:49",'+
        '        "Calificacion": "80.00000"'+
        '    }'+
        ']';
        SingleRequestMock mock = new SingleRequestMock(200,
                                                        'Success',
                                                        responseBody,
                                                        null);
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            String respuesta = LXD_SkyUtils.getNotasUsuario('AA68735');
        Test.stopTest();
        System.assertEquals(responseBody, respuesta);
        
    }
    @IsTest
    static void shoyldGetAnErrorOfWrongUserFromMoodle(){
        SingleRequestMock mock = new SingleRequestMock(400,
                                                        'Error',
                                                        'No se pudo obtener ningun curso',
                                                        null);
        Test.setMock(HttpCalloutMock.class, mock);
        String mensaje;
        Test.startTest();
        try {
            String respuesta = LXD_SkyUtils.getNotasUsuario('error');
        } catch (Exception e) {
            mensaje = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('No se pudo obtener ningun curso', mensaje);
        
    }
    @IsTest
    static void shouldRecieveListOfGradesOfBussinessFromMoodle(){
        String userCode = '';
        String responseBody ='['+
        '    {'+
        '        "Usuario": "DI16100041",'+
        '        "Nombre": "FRANCISCO JAVIER FLORES TAGLE",'+
        '        "Curso": "SKY Mobile",'+
        '        "Categoria": "Cursos de sistemas",'+
        '        "Fecha": "2017-07-17 14:55:18",'+
        '        "Calificacion": "18.00000"'+
        '    },'+
        '    {'+
        '        "Usuario": "DI16100041",'+
        '        "Nombre": "FRANCISCO JAVIER FLORES TAGLE",'+
        '        "Curso": "Nuevos Distribuidores",'+
        '        "Categoria": "Cursos comerciales",'+
        '        "Fecha": "2017-07-17 14:55:18",'+
        '        "Calificacion": "96.66667"'+
        '    }'+
        ']';
        SingleRequestMock mock = new SingleRequestMock(200,
                                                        'Success',
                                                        responseBody,
                                                        null);
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            String respuesta = LXD_SkyUtils.getNotasUsuario('DI16100041');
        Test.stopTest();
        System.assertEquals(responseBody, respuesta);
        
    }
    @IsTest
    static void shoyldGetAnErrorOfWrongBussinessFromMoodle(){
        SingleRequestMock mock = new SingleRequestMock(400,
                                                        'Error',
                                                        'No se pudo obtener ningun curso',
                                                        null);
        Test.setMock(HttpCalloutMock.class, mock);
        String mensaje;
        Test.startTest();
        try {
            String respuesta = LXD_SkyUtils.getNotasUsuario('error');
        } catch (Exception e) {
            mensaje = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('No se pudo obtener ningun curso', mensaje);
    }

    @IsTest
    static void shouldGetARandomAccountContactRelationFromList(){
        Account cuenta1 = new Account (
            LXD_N_Distribuidor__c = 'DI111111',
            Name='Test'
        );
        insert cuenta1;
        Contact contacto1 = new Contact(
            LastName = 'test',
            FirstName = 'test',
            MiddleName = 'test',
            Suffix = 'test',
            Phone = '111111111',
            MobilePhone = '11111111',
            Email = 'test@test.com',
            LXD_Clave_operativa__c = 'TT00001',
            LXD_Estatus_de_la_clave_operativa__c = 'Activo',
            LXD_Tipo_de_clave_operativa__c = 'Técnico',
            AccountId = cuenta1.Id,
            MailingPostalCode = '2158',
            MailingCity = 'Buenos Aires',
            Title = 'Tecnico',
            LXD_Nivel_de_estudios__c = 'Carrera técnica',
            MX_SKY_NumExtEnv__c = '12',
            MX_SKY_NumIntEnv__c = '12',
            MX_SKY_ColoiaEnv__c = 'test',
            MX_SKY_MuniAlca__c = 'test',
            MX_SKY_EntrecalleUnoEnv__c = 'test',
            MX_SKY_EntrecalIeEnvDos__c = 'test',
            LXD_Estatus_de_la_relacion__c = 'Activo',
            LXD_Atributos__c = 'test',
            LXD_Banderas__c = 'test',
            MailingCountry = 'Mexico',
            LXD_Fecha_alta__c = date.newInstance(1987, 12, 17),
            LXD_Genero__c = 'Masculino',
            LXD_Nacionalidad__c = 'MEXICANA',
            LXD_Estado_civil__c = 'Soltero',
            LXD_Numero_ID__c = '11111111',
            LXD_Dato_secreto__c = 'test',
            LXD_Notas_1__c = 'test',
            LXD_Notas_2__c = 'test',
            LXD_Contrasena_personal__c = 'test',
            LXD_TipoPerfil_del__c = 'Revisor'
        );
        insert contacto1;
        Account cuenta2 = new Account (
            LXD_N_Distribuidor__c = 'DI111111',
            Name='Test2'
        );
        insert cuenta2;
        Contact contacto2 = new Contact(
            LastName = 'test2',
            FirstName = 'test2',
            MiddleName = 'test2',
            Suffix = 'test2',
            Phone = '1111111211',
            MobilePhone = '112111111',
            Email = 'test@tes2t.com',
            LXD_Clave_operativa__c = 'TT02001',
            LXD_Estatus_de_la_clave_operativa__c = 'Activo',
            LXD_Tipo_de_clave_operativa__c = 'Técnico',
            AccountId = cuenta2.Id,
            MailingPostalCode = '2158',
            MailingCity = 'Buenos Aires',
            Title = 'Tecnico',
            LXD_Nivel_de_estudios__c = 'Carrera técnica',
            MX_SKY_NumExtEnv__c = '12',
            MX_SKY_NumIntEnv__c = '12',
            MX_SKY_ColoiaEnv__c = 'test',
            MX_SKY_MuniAlca__c = 'test',
            MX_SKY_EntrecalleUnoEnv__c = 'test',
            MX_SKY_EntrecalIeEnvDos__c = 'test',
            LXD_Estatus_de_la_relacion__c = 'Activo',
            LXD_Atributos__c = 'test',
            LXD_Banderas__c = 'test',
            MailingCountry = 'Mexico',
            LXD_Fecha_alta__c = date.newInstance(1987, 12, 17),
            LXD_Genero__c = 'Masculino',
            LXD_Nacionalidad__c = 'MEXICANA',
            LXD_Estado_civil__c = 'Soltero',
            LXD_Numero_ID__c = '11111111',
            LXD_Dato_secreto__c = 'test',
            LXD_Notas_1__c = 'test',
            LXD_Notas_2__c = 'test',
            LXD_Contrasena_personal__c = 'test'
        );
        insert contacto2;
        List<Contact> AccountContactRelationLST = [SELECT Id FROM Contact];
        List<List<Contact>> accountContactRelationLstLst = new List<List<Contact>>();
        accountContactRelationLstLst.add(AccountContactRelationLST);
        Test.startTest();
        List<List<Contact>> accountContactRelationLstLstDevuelto = LXD_InvocableClass.getAccountContactRelation(accountContactRelationLstLst);
        Test.stopTest();
        System.assert(!accountContactRelationLstLstDevuelto.isEmpty());
        
    }

    @IsTest
    static void shouldGetARandomUserFromList(){
        List<User> usuarioLST = new List<User>();
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);

        Profile profile1 = [Select Id from Profile where name = 'Administrador del sistema'];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test25@test.com',
            Alias = 'batman1',
            Email='bruce.wayne1@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce1',
            Lastname='Wayne1',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        User portalAccountOwner2 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman2',
            Email='bruce.wayne2@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce2',
            Lastname='Wayne2',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        User portalAccountOwner3 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test23@test.com',
            Alias = 'batman3',
            Email='bruce.wayne3@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce3',
            Lastname='Wayne3',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        usuarioLST.add(portalAccountOwner1);
        usuarioLST.add(portalAccountOwner2);
        usuarioLST.add(portalAccountOwner3);
        List<List<User>> usuarioLstLst = new List<List<User>>();
        usuarioLstLst.add(usuarioLST);
        Database.insert(usuarioLST);
        Test.startTest();
        List<List<User>> usuarioLstLstDevuelto = LXD_InvocableClass2.getUser(usuarioLstLst);
        Test.stopTest();
        System.assert(!usuarioLstLstDevuelto.isEmpty());
        
    }

    // -----------------------------
    //no hay clave operativa 00001
    // ya hay clave operativa 00123
    // ingresa con apellido paterno . -> suffix
    /*@IsTest
    static void LXD_ContactWithPaternalLastNameAndWithoutCO(){
        Contact contactWithLastName = new Contact(
            LXD_Estatus_de_la_clave_operativa__c = 'Pendiente',
            LXD_Estatus_de_la_relacion__c = 'activo',
            LXD_Fecha_alta__c = date.valueOf('2021-10-5 12:20:20') , //puede ser obligatorio??
            FirstName = 'Martin',
            LastName ='Noy',
            LXD_Nacionalidad__c ='Mexicana',
            LXD_Genero__c='Masculino',
            LXD_Tipo_ID__c ='Licencia para conducir',
            LXD_Estado_civil__c ='Soltero',
            LXD_Numero_ID__c ='112233445566',
            LXD_Dato_secreto__c ='testeo1234', //Puede ser obligatorio?
            LXD_Contrasena_personal__c ='testeo1234' //no puede ser obligatorio
        );
        insert contactWithLastName;

        List<Id> contactIdList = new List<Id>();
        contactIdList.add(contactWithLastName.Id);
        Test.startTest();
        LXD_SkyUtils.generarClaveOperativa(contactIdList);
        Test.stopTest();
        Contact contactWithClaveOperativa = [
            SELECT Id, LXD_Clave_operativa__c
            FROM Contact
            WHERE Id =: contactWithLastName.Id
        ];
        System.assertEquals(contactWithClaveOperativa.LXD_Clave_operativa__c, 'MN00001');

    }


    @IsTest
    static void LXD_ContactLastnameAnd_AContactLivedBeforeOnDataBase(){
        Contact contactWithPaternalOnly = new Contact(
            LXD_Estatus_de_la_clave_operativa__c = 'Pendiente',
            LXD_Estatus_de_la_relacion__c = 'activo',
            LXD_Fecha_alta__c = date.valueOf('2021-10-5 12:20:20') , //puede ser obligatorio??
            FirstName = 'Martin',
            LastName ='Noy',
            Suffix ='.',
            LXD_Nacionalidad__c ='Mexicana',
            LXD_Clave_operativa__c = 'MN00123',
            LXD_Genero__c='Masculino',
            LXD_Tipo_ID__c ='Licencia para conducir',
            LXD_Estado_civil__c ='Soltero',
            LXD_Numero_ID__c ='112233445566',
            LXD_Dato_secreto__c ='testeo1234', //Puede ser obligatorio?
            LXD_Contrasena_personal__c ='testeo1234' //no puede ser obligatorio
        );
        insert contactWithPaternalOnly;
        Contact contactNew = new Contact(
            LXD_Estatus_de_la_clave_operativa__c = 'Pendiente',
            LXD_Estatus_de_la_relacion__c = 'activo',
            LXD_Fecha_alta__c = date.valueOf('2021-10-5 12:20:20') , //puede ser obligatorio??
            FirstName = 'Martin',
            LastName ='Norman',
            Suffix ='Gonzalez',
            LXD_Nacionalidad__c ='Mexicana',
            LXD_Genero__c='Masculino',
            LXD_Tipo_ID__c ='Licencia para conducir',
            LXD_Estado_civil__c ='Soltero',
            LXD_Numero_ID__c ='112233445566',
            LXD_Dato_secreto__c ='testeo1234', //Puede ser obligatorio?
            LXD_Contrasena_personal__c ='testeo1234' //no puede ser obligatorio
        );
        insert contactNew;

        List<Id> contactIdList = new List<Id>();
        contactIdList.add(contactNew.Id);
        Test.startTest();
        LXD_SkyUtils.generarClaveOperativa(contactIdList);
        Test.stopTest();
        Contact contactWithClaveOperativa = [
            SELECT Id, LXD_Clave_operativa__c
            FROM Contact
            WHERE Id =: contactNew.Id
        ];
        system.debug('contactWithClaveOperativa = '+ contactWithClaveOperativa);
        System.assertEquals(contactWithClaveOperativa.LXD_Clave_operativa__c, 'MN00124');
    }


    @IsTest
    static void LXD_ContactWithOutPaternalLastName(){
        Contact contactWithPaternalOnly = new Contact(
            LXD_Estatus_de_la_clave_operativa__c = 'Pendiente',
            LXD_Estatus_de_la_relacion__c = 'activo',
            LXD_Fecha_alta__c = date.valueOf('2021-10-5 12:20:20') , //puede ser obligatorio??
            FirstName = 'Martin',
            LastName ='.',
            Suffix ='Lopez',
            LXD_Nacionalidad__c ='Mexicana',
            LXD_Genero__c='Masculino',
            LXD_Tipo_ID__c ='Licencia para conducir',
            LXD_Estado_civil__c ='Soltero',
            LXD_Numero_ID__c ='112233445566',
            LXD_Dato_secreto__c ='testeo1234', //Puede ser obligatorio?
            LXD_Contrasena_personal__c ='testeo1234' //no puede ser obligatorio
        );
        insert contactWithPaternalOnly;
        
        List<Id> contactIdList = new List<Id>();
        contactIdList.add(contactWithPaternalOnly.Id);
        Test.startTest();
        LXD_SkyUtils.generarClaveOperativa(contactIdList);
        Test.stopTest();

        Contact contactWithClaveOperativa = [
            SELECT Id, LXD_Clave_operativa__c
            FROM Contact
            WHERE Id =: contactWithPaternalOnly.Id
        ];
        System.assertEquals(contactWithClaveOperativa.LXD_Clave_operativa__c, 'ML00001');
    }*/
}