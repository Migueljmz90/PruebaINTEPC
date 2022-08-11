public with sharing class LXD_ContactTriggerHelper {
    public static void callAltaOperativa(List<Contact> contactLst) {
      	Database.executeBatch(new LXD_sendAltaClaveOperativaBatch(contactLst), 1);
    }
}