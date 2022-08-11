@isTest
public without sharing class LXD_CommunityDetailsCheckControllerTest {
    @TestSetup
    static void makeData(){
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);

        Profile profile1 = [Select Id from Profile where name = 'Administrador del sistema'];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman',
            Email='bruce.wayne@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        Database.insert(portalAccountOwner1);
        
    }
    @IsTest // REVISAR, NO SE PUEDE OBTENER EL USUARIO POR PERMISOLOGIA
    static void shouldGetContactIdFromUser(){
        
        User portalAccountOwner1 = [
            SELECT Id
            FROM User
            WHERE Alias = 'batman'
        ];
        //Create account
        Account portalAccount1 = new Account(
            Name = 'TestAccount',
            OwnerId = portalAccountOwner1.Id
        );
        Database.insert(portalAccount1);

        //Create contact
        Contact contact1 = new Contact(
            FirstName = 'Test',
            Lastname = 'McTesty',
            AccountId = portalAccount1.Id,
            Email = System.now().millisecond() + 'test@test.com'
        );
        Database.insert(contact1);

        //Create user   
        Profile portalProfile = [
            SELECT Id,name,UserLicenseId 
            FROM Profile 
            where UserLicenseId  
            in (
                SELECT Id 
                FROM UserLicense 
                where name ='Partner Community'
                )
            LIMIT 1
            ];
        User user1 = new User(
            Username = 'test12345@labsxd.com.dev',
            ContactId = contact1.Id,
            ProfileId = portalProfile.Id,
            Alias = 'test123',
            Email = 'test12345@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'McTesty',
            CommunityNickname = 'test12345',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        Database.insert(user1);
        Contact info = new Contact();
        Test.startTest();
        System.runAs(user1){
            info= LXD_CommunityDetailsCheckController.fetchContactInfo();
        }
        Test.stopTest();
        system.assertEquals(contact1.Id, info.Id, 'Los IDs no coinciden');
    }
    @IsTest
    static void shouldGetExceptionFromUserContactId(){
        String error;
        Test.startTest();
        try {
            Contact info = LXD_CommunityDetailsCheckController.fetchContactInfo();
        } catch (Exception e) {
            error = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('Script-thrown exception', error);
    }

    @IsTest
    static void showldGetDetallesFromKnowledgeArticle(){
        knowledge__kav newArticle = new knowledge__kav(
            Title='Aviso de privacidad',
            summary='xyz',
            urlname='test',
            Detalles__c = 'cuerpo');
        insert newArticle;
        Test.startTest();
        string articulo = LXD_CommunityDetailsCheckController.fetchKnowledge();
        Test.stopTest();
        System.assertEquals('cuerpo', articulo);
        
    }
    @IsTest
    static void showldGetExceptionFromKnowledg(){
        String error;
        Test.startTest();
        try {
            string articulo = LXD_CommunityDetailsCheckController.fetchKnowledge();
        } catch (Exception e) {
            error = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('Script-thrown exception', error);
        
    }
    @IsTest
    static void shouldUpdateContact(){
        Contact contact1 = new Contact(
            FirstName = 'Test',
            Lastname = 'McTesty',
            Email ='test@test.com',
            LXD_Acepto_aviso_de_privacidad__c = false
        );
        insert contact1;
        Test.startTest();
            LXD_CommunityDetailsCheckController.updateContact(contact1.Id);
        Test.stopTest();
        Contact updatedContact = [
            SELECT Id, LXD_Acepto_aviso_de_privacidad__c
            FROM Contact
            WHERE Id =:contact1.Id
        ];
        System.assert(updatedContact.LXD_Acepto_aviso_de_privacidad__c, 'el aviso de privasidad no ah cambiado');
        
    }
}