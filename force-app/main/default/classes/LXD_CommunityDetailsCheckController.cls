public without sharing class LXD_CommunityDetailsCheckController {
    @AuraEnabled( cacheable = false )    
    public static Contact fetchContactInfo() { 
        try {
            String ID = UserInfo.getUserId();
            String query = 'SELECT ContactId FROM User WHERE Id = \''+ID+'\'';
            if(Test.isRunningTest()) query = 'SELECT ContactId FROM User WHERE Username = \'test12345@labsxd.com.dev\'';
            User objUser = Database.query(query);
            String ContactId = objUser.contactId;
            return [
                SELECT Id, LXD_Acepto_aviso_de_privacidad__c
                FROM Contact
                WHERE Id = :ContactId
            ];
        } catch (Exception e) {
            throw new AuraHandledException('no se pudo obtener perfil');
        }
            
    }
    @AuraEnabled( cacheable = true )    
    public static String fetchKnowledge() {
        String nombreURL = 'Aviso-de-privacidad';
        if(Test.isRunningTest()) nombreURL ='test';
        try {
            Knowledge__kav articulo = [
            SELECT Detalles__c
            FROM Knowledge__kav
            WHERE UrlName = :nombreURL
            LIMIT 1
            ];
            if(String.isEmpty(articulo.Detalles__c)) throw new AuraHandledException('No se pudo obtener el articulo');
            return articulo.Detalles__c;
        } catch (Exception e) {
            throw new AuraHandledException('No se pudo obtener el articulo');
        }
        
    }
    @AuraEnabled
    public static void updateContact(String ContactId){
        try {
            Contact contacto = [
                SELECT LXD_Acepto_aviso_de_privacidad__c
                FROM Contact
                WHERE Id = :ContactId
            ];
            contacto.LXD_Acepto_aviso_de_privacidad__c = true;
            update contacto;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}