@isTest
public with sharing class EmailMessageTriggerTest {

    static string bodyInterna, bodyExterna, bodyNoAplica;
    static {
        bodyInterna = '*Detalles de Incidente*\n'+
        '\n'+
        '*Servicio:*\n'+
        '\n'+
        'Siebel\n'+
        '\n'+
        '*Categoría:*\n'+
        '\n'+
        'Bloqueo\n'+
        '\n'+
        '*Prioridad:*\n'+
        '\n'+
        'Crítica\n'+
        '\n'+
        '*Estado:*\n'+
        '\n'+
        'Preparado\n'+
        '\n'+
        '*Descripción:*\n'+
        '\n'+
        'se Presenta una falla en Siebel que no perite que los usuarios se logen y\n'+
        'no hay conectiviadad para consulta de saldos\n'+
        '\n'+
        '*Tipo de notificación:* \n'+
        '\n'+
        'Interna\n'+
        '\n'+
        '*Mensaje Interno:*\n'+
        '\n'+
        'Siebel no esta disponible, por lo tanto, no se están procesando las SS\n'+
        '\n'+
        '*Mensaje Externo:* \n'+
        '\n'+
        'Estamos experimentando inestabilidad en algunos de nuestros sistemas, por\n'+
        'lo tanto, no se estan procesando algunos servicios.\n'+
        '\n'+
        '*Para ver el registro, haga clic aquí* \n';

        bodyExterna = '*Detalles de Incidente*\n'+
        '\n'+
        '*Servicio:*\n'+
        '\n'+
        'Siebel\n'+
        '\n'+
        '*Categoría:*\n'+
        '\n'+
        'Bloqueo\n'+
        '\n'+
        '*Prioridad:*\n'+
        '\n'+
        'Crítica\n'+
        '\n'+
        '*Estado:*\n'+
        '\n'+
        'Preparado\n'+
        '\n'+
        '*Descripción:*\n'+
        '\n'+
        'se Presenta una falla en Siebel que no perite que los usuarios se logen y\n'+
        'no hay conectiviadad para consulta de saldos\n'+
        '\n'+
        '*Tipo de notificación:* \n'+
        '\n'+
        'Externa\n'+
        '\n'+
        '*Mensaje Interno:* \n'+
        '\n'+
        'Siebel no esta disponible, por lo tanto, no se están procesando las SS\n'+
        '\n'+
        '*Mensaje Externo:*\n'+
        '\n'+
        'Estamos experimentando inestabilidad en algunos de nuestros sistemas, por lo tanto, no se estan procesando algunos servicios.\n'+
        '\n'+
        '*Para ver el registro, haga clic aquí* \n';

        bodyNoAplica = '*Detalles de Incidente*\n'+
        '\n'+
        '*Servicio:*\n'+
        '\n'+
        'Siebel\n'+
        '\n'+
        '*Categoría:*\n'+
        '\n'+
        'Bloqueo\n'+
        '\n'+
        '*Prioridad:*\n'+
        '\n'+
        'Crítica\n'+
        '\n'+
        '*Estado:*\n'+
        '\n'+
        'Preparado\n'+
        '\n'+
        '*Descripción:*\n'+
        '\n'+
        'se Presenta una falla en Siebel que no perite que los usuarios se logen y\n'+
        'no hay conectiviadad para consulta de saldos\n'+
        '\n'+
        '*Tipo de notificación:* \n'+
        '\n'+
        'No Aplica\n'+
        '\n'+
        '*Mensaje Interno:* \n'+
        '\n'+
        'Siebel no esta disponible, por lo tanto, no se están procesando las SS\n'+
        '\n'+
        '*Mensaje Externo:* \n'+
        '\n'+
        'Estamos experimentando inestabilidad en algunos de nuestros sistemas, por\n'+
        'lo tanto, no se estan procesando algunos servicios.\n'+
        '\n'+
        '*Para ver el registro, haga clic aquí* \n';
    }
    @IsTest
    static void shouldSendInternalNotification(){
        String mensaje;
        Case c = new Case();
        c.Subject = 'Om Test';  
        c.Status ='New';
        c.Priority = 'Medium';
        c.Origin = 'Email';
        insert c;
      
        List<EmailMessage> smaxEmails = new List<EmailMessage>();
        smaxEmails.add(New EmailMessage(
            ParentId = c.Id, 
            TextBody = bodyInterna,
            HtmlBody = bodyInterna,
            Subject = 'LXD_Test_SMAX_2022', 
            FromAddress = 'test@labsxd.com', 
            ToAddress = 'sopreddes@sky.com.mx', 
            Incoming = true, 
            Status='New'
        ));

        Test.startTest();
            try {
                EmailMessageTriggerHelper.smaxEmailRecieved(smaxEmails);
            } catch (Exception e) {
                system.debug('e.getMessage() '+ e.getMessage());
                mensaje = e.getMessage(); 
                system.debug('mensaje '+ mensaje);
            }
        Test.stopTest();
        System.assertEquals(
            'Se Envio la notificacion : Siebel no esta disponible, por lo tanto, no se están procesando las SS',
            mensaje
        );
        
    }
    @IsTest
    static void shouldSendExternalNotification(){
        String mensaje;
        Case c = new Case();
        c.Subject = 'Om Test';  
        c.Status ='New';
        c.Priority = 'Medium';
        c.Origin = 'Email';
        insert c;

        //Insert emailmessage for case
        List<EmailMessage> smaxEmails = new List<EmailMessage>();
        smaxEmails.add(New EmailMessage(
            ParentId = c.Id, 
            TextBody = bodyExterna,
            HtmlBody = bodyExterna,
            Subject = 'LXD_Test_SMAX_2022', 
            FromAddress = 'test@labsxd.com', 
            ToAddress = 'sopreddes@sky.com.mx', 
            Incoming = true, 
            Status='New'
        ));
        
        Test.startTest();
            try {
                EmailMessageTriggerHelper.smaxEmailRecieved(smaxEmails);
            } catch (Exception e) {
                system.debug('e.getMessage() '+ e.getMessage());
                mensaje = e.getMessage(); 
                system.debug('mensaje '+ mensaje);
            }
        Test.stopTest();
        System.assertEquals(
            'Se Envio la notificacion : Estamos experimentando inestabilidad en algunos de nuestros sistemas, por lo tanto, no se estan procesando algunos servicios.',
             mensaje
        );
    }

    @IsTest
    static void shouldNotSendAnyNotification(){
        String mensaje;
        Case c = new Case();
        c.Subject = 'Om Test';  
        c.Status ='New';
        c.Priority = 'Medium';
        c.Origin = 'Email';
        insert c;

        //Insert emailmessage for case
        List<EmailMessage> smaxEmails = new List<EmailMessage>();
        smaxEmails.add(New EmailMessage(
            ParentId = c.Id, 
            TextBody = bodyNoAplica,
            HtmlBody = bodyNoAplica,
            Subject = 'LXD_Test_SMAX_2022', 
            FromAddress = 'test@labsxd.com', 
            ToAddress = 'sopreddes@sky.com.mx', 
            Incoming = true, 
            Status='New'
        ));

        Test.startTest();
            try {
                EmailMessageTriggerHelper.smaxEmailRecieved(smaxEmails);
            } catch (Exception e) {
                system.debug('e.getMessage() '+ e.getMessage());
                mensaje = e.getMessage(); 
                system.debug('mensaje '+ mensaje);
            }
        Test.stopTest();
        System.assertEquals('No se envia ninguna Notificacion', mensaje);
    }
}