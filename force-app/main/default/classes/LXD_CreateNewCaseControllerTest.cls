@isTest
public with sharing class LXD_CreateNewCaseControllerTest {
    @IsTest
    static void ShouldRecieveRecordTypeID(){
        Test.startTest();
        String recordTypeID = LXD_CreateNewCaseController.getCaseRecordTypeID();
        Test.stopTest();
        System.assert(String.isNotBlank(recordTypeID));
        
    }
    @IsTest
    static void ShouldRecieveContactID(){
        Test.startTest();
        String ContactId = LXD_CreateNewCaseController.getContactId();
        Test.stopTest();
        System.assert(String.isBlank(ContactId));
    }
}