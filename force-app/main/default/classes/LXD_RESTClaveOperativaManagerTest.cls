@IsTest
private class LXD_RESTClaveOperativaManagerTest {
    
    @isTest static void RequestShouldReturnResponse200() { //Test positivo
        String contactId = createTestRecord();  //crea un object Asset para Test
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Get';
        request.addHeader('Content-Type', 'application/json');
        request.addParameter('ClaveOperativa', 'MN00001');
        request.addParameter('Pais', 'Mexico');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_RequestClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Contact:{LastName=Noy, FirstName=Martin, MailingCountry=Mexico, LXD_Clave_operativa__c=MN00001, Id='+contactId+', MiddleName=, Suffix=, Phone=, MobilePhone=, Email=, LXD_Estatus_de_la_clave_operativa__c=, LXD_Estatus_de_la_relacion__c=, LXD_Atributos__c=, LXD_Banderas__c=, LXD_Fecha_alta__c=null, LXD_Genero__c=, LXD_Nacionalidad__c=, LXD_Estado_civil__c=, LXD_Tipo_ID__c=, LXD_Numero_ID__c=, LXD_Dato_secreto__c=, LXD_Notas_1__c=, LXD_Notas_2__c=, LXD_Contrasena_personal__c=, LXD_Clave_o_Numero__c=, LXD_Identificacion_Personal__c=, LXD_Telefono_Celular__c=}', 
            'Code' => '200'
        };
        System.assertEquals(expextedResult, svResult);
    } 
    
    @isTest static void RequestShouldReturnResponse404() { //Test negativo
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Get';
        request.addHeader('Content-Type', 'application/json');
        request.addParameter('ClaveOperativa', 'MN00001');
        request.addParameter('Pais', 'Mexico');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_RequestClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Contact not found', 
            'Code' => '404'
        };
        System.assertEquals(expextedResult, svResult);
    } 

    @isTest static void RequestShouldReturnResponse400() { //Test exception
        String contactId = createTestRecord();  //crea un object Asset para Test
        Map<String,String> params =new Map<String,String>{'ClaveOperativa'=>'MN00001','Pais'=>'Mexico'};
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Get';
        request.addHeader('Content-Type', 'application/json');
        request.addParameter('ClaveOperativa', 'MN00001');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_RequestClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Bad Request Error', 
            'Code' => '400',
            'Detail' => 'Por favor asegurese de pasar todos los parametros'
        };
        System.assertEquals(expextedResult, svResult);
    }       
    
    // Metodos test del update
    @isTest static void UpadteShouldReturnResponse200() { //Test positivo
        String contactId = createTestRecord();  //crea un object Asset para Test
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Post';
        request.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        request.requestBody = Blob.valueOf('{'+
        '"ClaveOperativa": "MN00001",'+
        '"Pais": "Mexico",'+
        '"LastName": ".",'+
        '"FirstName": "Florencia",'+
        '"MiddleName": null,'+
        '"Suffix": "apellido2",'+
        '"Phone": "54911218029 44",'+
        '"MobilePhone": null,'+
        '"Email": "fviacava@labsxd.com",'+
        '"LXD_Clave_operativa__c": "MN00001",'+
        '"LXD_Estatus_de_la_clave_operativa__c": "Activo",'+
        '"LXD_Estatus_de_la_relacion__c": "Activo",'+
        '"LXD_Atributos__c": null,'+
        '"LXD_Banderas__c": null,'+
        '"LXD_Genero__c": "Masculino",'+
        '"LXD_Nacionalidad__c": "MEXICANA",'+
        '"LXD_Estado_civil__c": "Soltero",'+
        '"LXD_Tipo_ID__c": "PASAPORTE",'+
        '"LXD_Numero_ID__c": "2143",'+
        '"LXD_Dato_secreto__c": "asd",'+
        '"LXD_Notas_1__c": null,'+
        '"LXD_Notas_2__c": null,'+
        '"LXD_Contrasena_personal__c": "abc",'+
        '"MailingCountry": "Mexico"'+
        '}');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_UpdateClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Contact Updated', 
            'Code' => '200'
        };
        System.assertEquals(expextedResult, svResult);
    } 
    
    @isTest static void UpadteShouldReturnResponse404() { //Test negativo
         RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Post';
        
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{'+
        '"ClaveOperativa": "MN00001",'+
        '"Pais": "Mexico",'+
        '"LastName": ".",'+
        '"FirstName": "Florencia",'+
        '"MiddleName": null,'+
        '"Suffix": "apellido2",'+
        '"Phone": "54911218029 44",'+
        '"MobilePhone": null,'+
        '"Email": "fviacava@labsxd.com",'+
        '"LXD_Clave_operativa__c": "MN00002",'+
        '"LXD_Estatus_de_la_clave_operativa__c": "Activo",'+
        '"LXD_Estatus_de_la_relacion__c": "Activo",'+
        '"LXD_Atributos__c": null,'+
        '"LXD_Banderas__c": null,'+
        '"LXD_Genero__c": "Masculino",'+
        '"LXD_Nacionalidad__c": "MEXICANA",'+
        '"LXD_Estado_civil__c": "Soltero",'+
        '"LXD_Tipo_ID__c": "PASAPORTE",'+
        '"LXD_Numero_ID__c": "2143",'+
        '"LXD_Dato_secreto__c": "asd",'+
        '"LXD_Notas_1__c": null,'+
        '"LXD_Notas_2__c": null,'+
        '"LXD_Contrasena_personal__c": "abc",'+
        '"MailingCountry": "Mexico"'+
        '}');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_UpdateClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Policy not found', 
            'Detail' => 'La combinacion de clave: MN00001 y el pais: Mexico no fue encontrado en la base de datos',
            'Code' => '404'
        };
        System.assertEquals(expextedResult, svResult);
    } 
    
    @isTest static void UpadteShouldReturnResponse400() { //Test exception
        String contactId = createTestRecord();  //crea un object Asset para Test
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Post';
        request.requestBody = Blob.valueOf('{'+
        '"LastName": ".",'+
        '"FirstName": "Florencia",'+
        '"MiddleName": null,'+
        '"Suffix": "apellido2",'+
        '"Phone": "54911218029 44",'+
        '"MobilePhone": null,'+
        '"Email": "fviacava@labsxd.com",'+
        '"LXD_Estatus_de_la_clave_operativa__c": "Activo",'+
        '"LXD_Estatus_de_la_relacion__c": "Activo",'+
        '"LXD_Atributos__c": null,'+
        '"LXD_Banderas__c": null,'+
        '"LXD_Genero__c": "Masculino",'+
        '"LXD_Nacionalidad__c": "MEXICANA",'+
        '"LXD_Estado_civil__c": "Soltero",'+
        '"LXD_Tipo_ID__c": "PASAPORTE",'+
        '"LXD_Numero_ID__c": "2143",'+
        '"LXD_Dato_secreto__c": "asd",'+
        '"LXD_Notas_1__c": null,'+
        '"LXD_Notas_2__c": null,'+
        '"LXD_Contrasena_personal__c": "abc",'+
        '"MailingCountry": "Mexico"'+
        '}');

        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_UpdateClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Bad Request Error', 
            'Code' => '400',
            'Detail' => 'Por favor asegurese de pasar todos los parametros'
        };
        System.assertEquals(expextedResult, svResult);
    } 
    
    // Metodos test del update
    @isTest static void UpadteShouldReturnResponse200AndCreateRelationAccounContact() { //Test positivo
        String contactId = createTestRecord();  //crea un object Asset para Test
        contacto.AccountId = cuentaBase.Id;
        update contacto;
        
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Contact/';
        request.httpMethod = 'Post';
        request.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        request.requestBody = Blob.valueOf('{'+
        '"ClaveOperativa": "MN00001",'+
        '"Pais": "Mexico",'+
        '"LastName": ".",'+
        '"FirstName": "Florencia",'+
        '"MiddleName": null,'+
        '"Suffix": "apellido2",'+
        '"Phone": "54911218029 44",'+
        '"MobilePhone": null,'+
        '"Email": "fviacava@labsxd.com",'+
        '"LXD_Clave_operativa__c": "MN00001",'+
        '"LXD_N_Distribuidor__c":"1234",'+
        '"LXD_Estatus_de_la_clave_operativa__c": "Activo",'+
        '"LXD_Estatus_de_la_relacion__c": "Activo",'+
        '"LXD_Atributos__c": null,'+
        '"LXD_Banderas__c": null,'+
        '"LXD_Genero__c": "Masculino",'+
        '"LXD_Nacionalidad__c": "MEXICANA",'+
        '"LXD_Estado_civil__c": "Soltero",'+
        '"LXD_Tipo_ID__c": "PASAPORTE",'+
        '"LXD_Numero_ID__c": "2143",'+
        '"LXD_Dato_secreto__c": "asd",'+
        '"LXD_Notas_1__c": null,'+
        '"LXD_Notas_2__c": null,'+
        '"LXD_Contrasena_personal__c": "abc",'+
        '"MailingCountry": "Mexico"'+
        '}');
        RestContext.request = request;    
        Map<String, String> svResult = LXD_RESTClaveOperativaManager.LXD_UpdateClaveOperativa();  // Actualiza el Asset Test
        Map<String,String> expextedResult = new Map<String, String>{
            'Message' => 'Contact Updated', 
            'Code' => '200'
        };
            
        List<AccountContactRelation> accConRelationList = [
            SELECT Id, AccountId, ContactId, IsActive
                FROM AccountContactRelation 
                WHERE ContactId = :contactId
            		AND AccountId = :cuenta.Id
                    AND IsActive = True
        ];
        System.assertEquals(expextedResult, svResult);
        System.assertEquals(1, accConRelationList.size());
    } 
    // Helper method for create the Contact
    Static Contact contacto;
    Static Account cuentaBase, cuenta;

    static String createTestRecord() {
        cuentaBase = new Account(
        	Name = 'Martin Noy base',
            LXD_N_Distribuidor__c = '12345',
            LXD_Estatus__c = 'Activa'
        );
        insert cuentaBase;
        cuenta = new Account(
        	Name = 'Martin Noy',
            LXD_N_Distribuidor__c = '1234',
            LXD_Estatus__c = 'Activa'
        );
        insert cuenta;
        contacto = new Contact(
            FirstName = 'Martin',
            LastName = 'Noy',
            LXD_Clave_operativa__c = 'MN00001',
            MailingCountry = 'Mexico'
        );
        insert contacto;
        return contacto.Id;
    }       
}