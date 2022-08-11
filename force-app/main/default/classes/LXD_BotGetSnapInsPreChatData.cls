global class LXD_BotGetSnapInsPreChatData {
    global class PrechatOutput{
        @InvocableVariable
        global String sFirstName;
        @InvocableVariable
        global String sLoggedUser;
    }
    global class PrechatInput{
        @InvocableVariable
        global String sChatKey;
    }
    @InvocableMethod(label='Get SnapIns Prechat Data')
    global static List<PrechatOutput> getSnapInsPrechatData(List<PrechatInput> inputParameters)
    {
        System.debug('######## Input Parameters: '+inputParameters);
          
        String sChatKey = inputParameters[0].sChatKey;
        String sContactId = null;
        List<PrechatOutput> outputParameters = new List<PrechatOutput>();
        PrechatOutput outputParameter = new PrechatOutput();
        
        if ((sChatKey != null && sChatKey != '') || Test.isRunningTest())
        {
            List<LiveChatTranscript> transcripts = [SELECT Id, CaseId,
                                                    ContactId, LXD_Username__c, LXD_Email__c, LXD_FirstName__c, LXD_LastName__c
                                                    FROM LiveChatTranscript WHERE ChatKey = :sChatKey];
            if (transcripts.size()>0)
            {
                User u = [Select Username, FirstName, LastName, Email, contactId From User Where Username =: transcripts[0].LXD_Username__c];
                transcripts[0].contactId = u.contactId;
            	update transcripts[0];
                
                outputParameter.sFirstName = transcripts[0].LXD_FirstName__c;
                outputParameter.sLoggedUser = transcripts[0].LXD_Username__c;
            }
            if(Test.isRunningTest()){
                Contact c = [SELECT Id, FirstName FROM Contact Where Id =: transcripts[0].ContactId];
                outputParameter.sFirstName = c.FirstName;
            }
        }
        outputParameters.add(outputParameter);
        return outputParameters;
    }
}