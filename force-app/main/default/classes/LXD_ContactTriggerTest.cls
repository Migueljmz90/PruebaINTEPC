@isTest
public with sharing class LXD_ContactTriggerTest {
    public static Account cuenta;
    public static Contact contacto;
    public static string resultMessage;
    static{
        resultMessage = '';
        cuenta = new Account (
            LXD_N_Distribuidor__c = 'DI111111',
            Name='Test'
        );
        insert cuenta;
        contacto = new Contact(
            LastName = 'test',
            FirstName = 'test',
            MiddleName = 'test',
            Suffix = 'test',
            Phone = '111111111',
            MobilePhone = '11111111',
            Email = 'test@test.com',
            LXD_Clave_operativa__c = 'TT00001',
            LXD_Estatus_de_la_clave_operativa__c = 'Activo',
            LXD_Tipo_de_clave_operativa__c = 'Pre-Técnico',
            AccountId = cuenta.Id,
            MailingPostalCode = '2158',
            MailingCity = 'Buenos Aires',
            Title = 'Tecnico',
            LXD_Nivel_de_estudios__c = 'Carrera técnica',
            MX_SKY_NumExtEnv__c = '12',
            MX_SKY_NumIntEnv__c = '12',
            MX_SKY_ColoiaEnv__c = 'test',
            MX_SKY_MuniAlca__c = 'test',
            MX_SKY_EntrecalleUnoEnv__c = 'test',
            MX_SKY_EntrecalIeEnvDos__c = 'test',
            LXD_Estatus_de_la_relacion__c = 'Activo',
            LXD_Atributos__c = 'test',
            LXD_Banderas__c = 'test',
            MailingCountry = 'Mexico',
            LXD_Fecha_alta__c = date.newInstance(1987, 12, 17),
            LXD_Genero__c = 'Masculino',
            LXD_Nacionalidad__c = 'MEXICANA',
            LXD_Estado_civil__c = 'Soltero',
            LXD_Numero_ID__c = '11111111',
            LXD_Dato_secreto__c = 'test',
            LXD_Notas_1__c = 'test',
            LXD_Notas_2__c = 'test',
            LXD_Contrasena_personal__c = 'test'
        );
        insert contacto;
    }
    @IsTest
    static void ShouldCallJohnnyRocketWithSuccessMessage(){
        
        SingleRequestMock mock = new SingleRequestMock(
            200,
            'Complete',
            '{Messagge: Success}',
            null
        );
        Test.setMock(HttpCalloutMock.class, mock);
        contacto.LXD_Tipo_de_clave_operativa__c = 'Técnico';
        resultMessage = '';
        try{
            Test.startTest();
                update contacto;
            Test.stopTest();
        } catch (DmlException ex) {
            system.debug('Envio de Claves Operativas a Jhonny Rocket'+ ex.getMessage());
            resultMessage = ex.getMessage();
        }  
        System.assertEquals('Envio de Claves Operativas a Jhonny Rocket', resultMessage);
    }


    @IsTest
    static void ShouldCallJohnnyRocketWithErrorMessage(){
        SingleRequestMock mock = new SingleRequestMock(
            400,
            'Error',
            '{Messagge: Error}',
            null
        );
        Test.setMock(HttpCalloutMock.class, mock);
        contacto.LXD_Tipo_de_clave_operativa__c = 'Técnico';
        resultMessage = '';
        try{
            Test.startTest();
                update contacto;
            Test.stopTest();
        } catch (DmlException ex) {
            system.debug('No se pudo crear el contacto'+ ex.getMessage());
            resultMessage = ex.getMessage();
        }  
        System.assertEquals('No se pudo crear el contacto', resultMessage);
    }
}