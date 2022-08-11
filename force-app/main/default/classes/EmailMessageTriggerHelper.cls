public with sharing class EmailMessageTriggerHelper {
    @InvocableMethod(label='smaxEmailRecieved')
    public static void smaxEmailRecieved(List<EmailMessage> smaxEmails){
        String mensajeExterno = '';
        String mensajeInterno = '';
        String tipoNotificacion = '';
        String titulo = '';
        
        Map<String,Profile> perfilesInternos = new Map<String,profile>([SELECT Id,UserLicenseId FROM Profile where UserLicenseId  in (SELECT Id FROM UserLicense where name ='Salesforce')]);
        Map<String,user> usuariosInternos = new Map<String,user>([select id from user where profileId in:perfilesInternos.Keyset() AND IsActive = true]);
        Map<String,Profile> perfilesExternos = new Map<String,profile>([SELECT Id,UserLicenseId FROM Profile where UserLicenseId  in (SELECT Id FROM UserLicense where name ='Partner Community')]);
        Map<String,user> usuariosExternos = new Map<String,user>([select id from user where profileId in:perfilesExternos.Keyset() AND IsActive = true]);
        for(EmailMessage message : smaxEmails){

            String prioridad = '';
            String servicio = '';
            String messageBodyFormat = message.TextBody.remove('\n');

            tipoNotificacion = messageBodyFormat.substringBetween('*Tipo de notificación:*','*Mensaje Interno:*');
            if (tipoNotificacion.contains('No Aplica')) {
                throw new DMLException('No se envia ninguna Notificacion');
            }

            Boolean haveMessageInternal = messageBodyFormat.contains('*Mensaje Interno:*');
            Boolean haveMessageExternal = messageBodyFormat.contains('*Mensaje Externo:*');

            if (tipoNotificacion.contains('Interna') && haveMessageInternal) {
                mensajeInterno = messageBodyFormat.substringBetween('*Mensaje Interno:*','*Mensaje Externo:*');
            } else if (tipoNotificacion.contains('Externa') && haveMessageExternal && haveMessageInternal) {
                mensajeInterno = messageBodyFormat.substringBetween('*Mensaje Interno:*','*Mensaje Externo:*');
                mensajeExterno = messageBodyFormat.substringBetween('*Mensaje Externo:*','*Para ver el registro,');
            } else {
                throw new DMLException('No se envia ninguna Notificacion');
            }

            Boolean havePrioridad = messageBodyFormat.contains('*Prioridad:*');
            Boolean haveServicio = messageBodyFormat.contains('*Servicio:*');
            
            if (havePrioridad && haveServicio) {
                prioridad = messageBodyFormat.substringBetween('*Prioridad:*','*Estado:*');
                servicio = messageBodyFormat.substringBetween('*Servicio:*','*Categoría:*');
            } else {
                throw new DMLException('No se envia ninguna Notificacion');
            }

            if (String.isNotBlank(prioridad) && String.isNotBlank(servicio)) {
                titulo = 'Mensaje de prioridad ' + prioridad + ' del servicio ' + servicio;
            } else {
                throw new DMLException('No se envia ninguna Notificacion');
            }

            if(tipoNotificacion.contains('Interna') && String.isNotBlank(titulo)){
                sendCustomNotification(titulo, mensajeInterno, message.ParentId, usuariosInternos.keySet());////mensajeInternoByCaseId.put(message.ParentId, mensajeInterno);
            }else if(tipoNotificacion.contains('Externa') && String.isNotBlank(titulo)){
                sendCustomNotification(titulo, mensajeExterno, message.ParentId, usuariosExternos.keySet());//mensajeExternoByCaseId.put(message.ParentId, mensajeExterno);
                sendCustomNotification(titulo, mensajeInterno, message.ParentId, usuariosInternos.keySet());//mensajeInternoByCaseId.put(message.ParentId, mensajeInterno);           
            }else{
                throw new DMLException('No se envia ninguna Notificacion');
            }

        }   
    }
    public static void sendCustomNotification(String title, String body, String target, Set<String> usersId) {
    Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle(title);
        notification.setBody(body);
        notification.setSenderId(Userinfo.getUserId());
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'LXD_Notification_Response'];
        notification.setNotificationTypeId(type.id);
        
        notification.setTargetId(target); // target object id
        
        if(!Test.isRunningTest()){
            notification.send(usersId);
        }else{
            throw new DMLException('Se Envio la notificacion : '+body);
        }
    }
}