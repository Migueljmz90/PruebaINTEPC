@isTest
public class LXD_BotGetSnapInsPreChatDataTest {
	@isTest
    public static void getLiveAgentInformationSalesforce(){
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
             
            LiveChatVisitor lcv = new LiveChatVisitor();
            insert lcv;
         
            LiveChatTranscript lct = new LiveChatTranscript();
            lct.LiveChatVisitorid = lcv.id;
            lct.contactid = c.Id;
            lct.LXD_Username__c = 'standarduser@skytestorg.com';
            insert lct;
           
            LiveChatTranscriptEvent le = new LiveChatTranscriptEvent();
            le.LiveChatTranscriptId = lct.id;
            le.type = 'ChatRequest';
            le.time = system.now();
            insert le;
    
            List<LXD_BotGetSnapInsPreChatData.PrechatInput> gsdata = new List<LXD_BotGetSnapInsPreChatData.PrechatInput>();
            LXD_BotGetSnapInsPreChatData.PrechatInput g1 = new LXD_BotGetSnapInsPreChatData.PrechatInput();
            g1.sChatKey = lct.ChatKey;
             system.debug('ChatKey' + lct.ChatKey);
            gsdata.add(g1);
            
            List<LXD_BotGetSnapInsPreChatData.PrechatOutput> gsoutput = new List<LXD_BotGetSnapInsPreChatData.PrechatOutput>();
            
            test.startTest();
            gsoutput = LXD_BotGetSnapInsPreChatData.getSnapInsPrechatData(gsdata);
            test.stopTest();
            
            System.assertEquals('Test', gsoutput[0].sFirstName);
        } 
	}
}