public without sharing class LXD_SkyUtils {
    public static Boolean checkEnteOperativo(String IdDistribuidor) {
        LXD_Endpoints__mdt WS_CONFIG = LXD_ConfigUtils.getWebServiceConfig('SKY.EnteOperativo');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WS_CONFIG.LXD_Url__c+WS_CONFIG.LXD_funtion__c);///InterfaceServices/Salesforce/ConsultarEnteOperativoSapRest
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(blob.valueOf(WS_CONFIG.LXD_usuario__c + ':' + WS_CONFIG.LXD_accessToken__c)));
        request.setBody('{'+
            '"cabecera" : {'+
            '"OPERACION" : "ConsultaEnte",'+
            '"APLICATIVO" : "salesforce",'+
            '"PARAMETRO" : [ {'+
                '"NOMBRE" : "",'+
                '"VALOR" : ""'+
            '} ]'+
            '},'+
            '"input" : {'+
            '"DISTRIBUIDOR" : "'+IdDistribuidor+'"'+
            '}'+
        '}'
        );
        try {
            HttpResponse response = http.send(request);
            if(response.getStatusCode() != 200){
                throw new HandledException(response.getBody());
            }
        } catch (Exception e) {
            throw new HandledException(e.getMessage());
        }

        return true;
    }
    public static Boolean AltaClaveOperativa(String IdContacto) {
        LXD_Endpoints__mdt WS_CONFIG = LXD_ConfigUtils.getWebServiceConfig('SKY.AltaClaves');
        Contact contacto = [SELECT 
                LastName,FirstName,MiddleName,Suffix,Phone,MobilePhone,
                Email,LXD_Clave_operativa__c,LXD_Estatus_de_la_clave_operativa__c,
                LXD_Tipo_de_clave_operativa__c,AccountId,Account.LXD_N_Distribuidor__c,MailingPostalCode,
                MailingCity, Title, LXD_Nivel_de_estudios__c, MX_SKY_NumExtEnv__c, MX_SKY_NumIntEnv__c,
                MX_SKY_ColoiaEnv__c, MX_SKY_MuniAlca__c, MX_SKY_EntrecalleUnoEnv__c, MX_SKY_EntrecalIeEnvDos__c,
                LXD_Estatus_de_la_relacion__c,LXD_Atributos__c,LXD_Banderas__c,MailingCountry,
                LXD_Fecha_alta__c,LXD_Genero__c,LXD_Nacionalidad__c,LXD_Estado_civil__c,MailingStreet,MailingState,
                LXD_Tipo_ID__c,LXD_Numero_ID__c,LXD_Dato_secreto__c,LXD_Notas_1__c,
                LXD_Notas_2__c,LXD_Contrasena_personal__c
            FROM Contact
            WHERE Id =: IdContacto
            LIMIT 1
        ];
        system.debug('Contacto = '+ contacto);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WS_CONFIG.LXD_Url__c+WS_CONFIG.LXD_funtion__c);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(blob.valueOf(WS_CONFIG.LXD_usuario__c + ':' + WS_CONFIG.LXD_accessToken__c)));
        String JSONBody = '{'+ 
            '"Tipos_clave_operativa" : "'+(contacto.LXD_Tipo_de_clave_operativa__c != null ? contacto.LXD_Tipo_de_clave_operativa__c : '')+'",'+
            '"Clave_operativa" : "'+(contacto.LXD_Clave_operativa__c != null ? contacto.LXD_Clave_operativa__c : '')+'",'+
            '"Estatus_Clave" : "'+(contacto.LXD_Estatus_de_la_clave_operativa__c != null ? contacto.LXD_Estatus_de_la_clave_operativa__c : '')+'",'+
            '"Distribuidor_asociado" : "'+(contacto.Account.LXD_N_Distribuidor__c != null ? contacto.Account.LXD_N_Distribuidor__c : '')+'",'+// se debe modificar
            '"Nombre" : "'+(contacto.FirstName != null ? contacto.FirstName : '')+(contacto.MiddleName != null ? ' '+contacto.MiddleName : '')+'",'+
            '"Apellido_Paterno" : "'+(contacto.LastName != null ? contacto.LastName : '')+'",'+
            '"Apellido_Materno" : "'+(contacto.Suffix != null ? contacto.Suffix : '')+'",'+
            '"Pais" : "'+(contacto.MailingCountry != null ? contacto.MailingCountry : '')+'",'+
            '"Calle" : "'+(contacto.MailingStreet != null ? contacto.MailingStreet : '')+'",'+
            '"Numero" : "'+(contacto.MX_SKY_NumIntEnv__c != null ? contacto.MX_SKY_NumIntEnv__c : '')+'",'+
            '"Codigo_postal" : "'+(contacto.MailingPostalCode != null ? contacto.MailingPostalCode : '')+'",'+
            '"Colonia" : "'+(contacto.MX_SKY_ColoiaEnv__c != null ? contacto.MX_SKY_ColoiaEnv__c : '')+'",'+
            '"Delegacion_municipio" : "'+(contacto.MX_SKY_MuniAlca__c != null ? contacto.MX_SKY_MuniAlca__c : '')+'",'+
            '"Ciudad" : "'+(contacto.MailingCity != null ? contacto.MailingCity : '')+'",'+
            '"Estado" : "'+(contacto.MailingState != null ? contacto.MailingState : '')+'",'+
            '"Referencia_calle1" : "'+(contacto.MX_SKY_EntrecalleUnoEnv__c != null ? contacto.MX_SKY_EntrecalleUnoEnv__c : '')+'",'+
            '"Referencia_calle2" : "'+(contacto.MX_SKY_EntrecalIeEnvDos__c != null ? contacto.MX_SKY_EntrecalIeEnvDos__c : '')+'",'+
            '"Telefono" : "'+(contacto.Phone != null ? contacto.Phone : '')+'",'+
            '"Comentarios" : "'+(contacto.LXD_Notas_1__c != null ? contacto.LXD_Notas_1__c : '')+'",'+
            '"Titulo" : "'+(contacto.Title != null ? contacto.Title : '')+'",'+
            '"Email" : "'+(contacto.Email != null ? contacto.Email : '')+'",'+
            '"Nivel" : "'+(contacto.LXD_Nivel_de_estudios__c != null ? contacto.LXD_Nivel_de_estudios__c : '')+'",'+
            '"Responsibilities" : "'+(contacto.LXD_Atributos__c != null ? contacto.LXD_Atributos__c : '')+'",'+
            '"password" : "'+(contacto.LXD_Contrasena_personal__c != null ? contacto.LXD_Contrasena_personal__c : '')+'"'+
        '}';
        system.debug('JSONBody '+JSONBody);
        request.setBody(JSONBody);
        try {
            HttpResponse response = http.send(request);
            if(response.getStatusCode() != 200 && test.isRunningTest()){
                throw new DMLException('No se pudo crear el contacto');
            } else if (response.getStatusCode() != 200) {
            	throw new HandledException(response.getBody());
        	}
        } catch (Exception e) {
            system.debug('Exception = '+ e);
            throw new HandledException(e.getMessage());
        }

        return true;
    }
    @AuraEnabled (cacheable = false)
    public static String getNotasUsuario(String userCode){
        LXD_Endpoints__mdt WS_CONFIG = LXD_ConfigUtils.getWebServiceConfig('SKY.MOODLE');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WS_CONFIG.LXD_Url__c+'?wstoken='+WS_CONFIG.LXD_accessToken__c+'&wsfunction='+WS_CONFIG.LXD_funtion__c+'&moodlewsrestformat=json&username='+userCode);
        //http://eusmoodledev.eastus2.cloudapp.azure.com/moodle/webservice/rest/server.php?wstoken=8dc8308c3fa6afaf3b015b07347a73de&wsfunction=local_remote_grades_courses_get_grades_courses_by_username&moodlewsrestformat=json&username=aa68735
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200){
            throw new HandledException(response.getBody());
        }
        return response.getBody();
    }
    
    @InvocableMethod(label='Generar Clave Operativa' description='Devuelve un contacto con Clave Operativa' category='Contact')
    public static List<Contact> generarClaveOperativa(List<Id> contactoId){
        
        Decimal clave = 00000;
        String strClave = '';
        String inicialApellido = '';
        List<Contact> contactoConClaveMasAlta;
        List<Contact> contactsResult = new List<Contact>();

        Contact contacto = [
            SELECT Id, LXD_Clave_operativa__c, LastName, Suffix, FirstName 
                FROM Contact 
                WHERE Id = :contactoId[0] 
            LIMIT 1
        ];
        
        if (string.isBlank(contacto.LastName) || contacto.LastName == '.') {
            inicialApellido = contacto.Suffix.toUppercase().left(1);
        }else{
            inicialApellido = contacto.LastName.toUppercase().left(1);
        }
        
        String inicioCO = contacto.FirstName.toUppercase().left(1) + inicialApellido;

        try{
            contactoConClaveMasAlta = [
                SELECT Id, LXD_Clave_operativa__c 
                    FROM Contact
                    WHERE LXD_Clave_operativa__c 
                    LIKE :inicioCO + '%' 
                ORDER BY LXD_Clave_operativa__c DESC 
                LIMIT 1
            ];
            
            if (!contactoConClaveMasAlta.isEmpty()) {
                clave = Decimal.valueOf(contactoConClaveMasAlta[0].LXD_Clave_operativa__c.substring(2,7));
            }            

        } catch (Exception e){
            system.debug('Exception '+ e);
        }

        strClave = String.valueOf(clave+1).leftPad(5, '0');
        contacto.LXD_Clave_operativa__c = inicioCO + strClave;
        update contacto;
        contactsResult.add(contacto);
        return contactsResult;
    }
    public static Integer getRandomElement(Integer ListSice){
        Double randomNumber = Math.random(); 
        Integer randomIndex = (randomNumber *(ListSice-1)).intValue(); 
        return randomIndex;
    }
}