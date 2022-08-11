@isTest
public class LXD_BotPreChatCmpCntTest {
    @isTest
    public static void getCurrentUserTest(){
        UserRole portalRole = [Select Id, DeveloperName From UserRole Where DeveloperName = 'Administrador' Limit 1];
        Profile adminProfile = [Select Id from Profile where name IN ('System Administrator', 'Administrador del sistema')];
        
        User portalAccountOwner = new User(
            UserRoleId = portalRole.Id,
            ProfileId = adminProfile.Id,
            Username = 'adminTests@skytest.com',
            Alias = 'AdmTes',
            Email='adminTests@skytest.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        insert portalAccountOwner;
        
        String resultUser = '';
         System.runAs(portalAccountOwner) {
            Account portalAccount = new Account(
            Name = 'TestAccount',
            OwnerId = portalAccountOwner.Id);
            insert portalAccount;
            
            Contact c = new Contact();
            c.LastName = 'Testing';
            c.Email= 'standarduser@testorg.com';
            c.AccountId = portalAccount.Id;
            c.FirstName = 'Test';
            insert c;
             
            Profile p = [SELECT Id FROM Profile WHERE Name='LXD_Distribuidor']; 
            User u = new User(
                Alias = 'standt', 
                Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', 
                FirstName = 'Test',
                LastName='Testing', 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', 
                UserName='standarduser@skytestorg.com', 
                ContactId = c.Id
            );
            insert u;
            
            System.runAs(u) {
                test.startTest();
                resultUser = LXD_BotPreChatCmpCnt.getCurrentUser();
                test.stopTest();
                
                
                system.AssertEquals('{"email":"standarduser@testorg.com","lastName":"Testing","firstName":"Test","userId":"standarduser@skytestorg.com"}', resultUser);
        	}   
        }  
    }
    
    @isTest
    public static void getCurrentUserTestDontHaveContactId(){
        UserRole portalRole = [Select Id, DeveloperName From UserRole Where DeveloperName = 'Administrador' Limit 1];
        Profile adminProfile = [Select Id from Profile where name IN('System Administrator', 'Administrador del sistema')];
        
        User portalAccountOwner = new User(
            UserRoleId = portalRole.Id,
            ProfileId = adminProfile.Id,
            Username = 'adminTests@skytest.com',
            Alias = 'AdmTes',
            Email='adminTests@skytest.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        insert portalAccountOwner;
        
        String resultUser = '';
         System.runAs(portalAccountOwner) {
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            User u = new User(
                Alias = 'standt', 
                Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', 
                FirstName = 'Test',
                LastName='Testing', 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles', 
                UserName='standarduser@skytestorg.com' 
            );
            insert u;
            
            System.runAs(u) {
                test.startTest();
                resultUser = LXD_BotPreChatCmpCnt.getCurrentUser();
                test.stopTest();
                
                
                system.AssertEquals('{"userId":""}', resultUser);
        	}   
        }  
    }
}