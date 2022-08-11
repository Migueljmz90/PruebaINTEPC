public with sharing class LXD_CreateNewCaseController {
    @AuraEnabled        
        //Get Record Type ID
    public static String getCaseRecordTypeID() {
        Id CaseRTID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Caso').getRecordTypeId();
        return CaseRTID;
    } 
    @AuraEnabled        
        //Get Record Type ID
    public static String getContactId(){
        String contactId = [
                            SELECT ContactId
                            FROM User
                            WHERE Id = : UserInfo.getUserId()
        ].ContactId;
        return contactId;
    }
}