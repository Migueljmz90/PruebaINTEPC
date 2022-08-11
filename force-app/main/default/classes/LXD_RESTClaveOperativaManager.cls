@RestResource(urlMapping='/Contact/*')
global class LXD_RESTClaveOperativaManager {
    
    @HttpGet
    global static Map<String, String> LXD_RequestClaveOperativa() {
        Map<String, String> msg200;
        Map<String, String> msg404 = new Map<String, String>{'Message' => 'Contact not found', 'Code' => '404'}; 
        Map<String, String> msg400;
        Map<String, String> idResult;
        Map<String, Object> acctMap = new Map<String, Object>();
        String[] fields = new String[]{'LastName','FirstName','MiddleName','Suffix','MailingCountry',
                                        'Phone','MobilePhone','Email','LXD_Clave_operativa__c',
                                        'LXD_Estatus_de_la_clave_operativa__c','LXD_Estatus_de_la_relacion__c',
                                        'LXD_Atributos__c','LXD_Banderas__c','LXD_Fecha_alta__c','LXD_Genero__c',
                                        'LXD_Nacionalidad__c','LXD_Estado_civil__c','LXD_Tipo_ID__c',
                                        'LXD_Numero_ID__c','LXD_Dato_secreto__c','LXD_Notas_1__c',
                                        'LXD_Notas_2__c','LXD_Contrasena_personal__c','LXD_Clave_o_Numero__c',
                                        'LXD_Identificacion_Personal__c','LXD_Telefono_Celular__c'};
                                        
        System.debug(fields);
        try {
            RestRequest request = RestContext.request;
            String claveOperativa = request.params.get('ClaveOperativa');
            String pais = request.params.get('Pais');
            if(claveOperativa == null || pais == null) throw new DMLException('Por favor asegurese de pasar todos los parametros');
            List<Contact> thisContact = Database.query(
                'SELECT ' + String.join(fields,',') 
                +' FROM Contact'+
                ' WHERE LXD_Clave_operativa__c LIKE :claveOperativa'+
                ' AND MailingCountry LIKE :pais'+
                ' LIMIT 1');
            System.debug('Contactos '+thisContact);
            if (!thisContact.isEmpty()) {
                acctMap = thisContact[0].getPopulatedFieldsAsMap();
                for (String field : fields){
                    if (!acctMap.containsKey(field)){
                        system.debug('cammpo '+field);
                        if(field == 'LXD_Fecha_alta__c'){
                            thisContact[0].put(field,null);
                        }else{
                            thisContact[0].put(field,'');
                        }
                        
                    }                              
                }
                System.debug('map = '+ thisContact[0]);
                idResult = new Map<String, String>{'Message' => String.valueOf(thisContact[0]), 'Code' => '200'};
            }else{
                idResult = msg404;
            }
            return idResult;   
        }  
        catch(Exception e) {
            System.debug(e);
            return msg400= new Map<String, String>{'Message' => 'Bad Request Error', 'Code' => '400', 'Detail' => e.getMessage()};
        }
    }

    @HttpPost
    global static Map<String, String> LXD_UpdateClaveOperativa() {
        Map<String, String> msg200 = new Map<String, String>{'Message' => 'Contact Updated', 'Code' => '200'}; 
        Map<String, String> msg404;
        Map<String, String> msg500 ;
        Map<String, String> msg400 = new Map<String, String>{'Message' => 'Bad Request Error', 'Code' => '400'};
        Map<String, String> idResult;
        try {
            RestRequest request = RestContext.request;
            Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
            
            String LXD_ClaveOperativa = (String)params.get('ClaveOperativa');
            String pais = (String)params.get('Pais');
            
            if(LXD_ClaveOperativa== null || pais == null) {
                throw new DMLException('Por favor asegurese de pasar todos los parametros');
            }
            
            List<Contact> thisContact = [
                SELECT 
                Id, LastName,FirstName,MiddleName,Suffix,Phone,MobilePhone,
                Email,LXD_Clave_operativa__c,LXD_Estatus_de_la_clave_operativa__c,
                LXD_Estatus_de_la_relacion__c,LXD_Atributos__c,LXD_Banderas__c,
                LXD_Fecha_alta__c,LXD_Genero__c,LXD_Nacionalidad__c,LXD_Estado_civil__c,
                LXD_Identificacion_Personal__c,LXD_Numero_ID__c,LXD_Dato_secreto__c,LXD_Notas_1__c,
                LXD_Notas_2__c,LXD_Clave_o_Numero__c,LXD_Telefono_Celular__c,LXD_Contrasena_personal__c
                FROM Contact 
                WHERE LXD_Clave_operativa__c = :LXD_ClaveOperativa 
                AND MailingCountry = :pais
                LIMIT 1
            ]; 
            
            if (!thisContact.isEmpty()) {

                thisContact[0].LastName = (String)params.get('LastName')== 'null' ? '.' : (String)params.get('LastName');
                thisContact[0].FirstName = (String)params.get('FirstName');
                thisContact[0].MiddleName = (String)params.get('MiddleName')== 'null' ? null : (String)params.get('MiddleName');
                thisContact[0].Suffix = (String)params.get('Suffix') == 'null' ? null : (String)params.get('Suffix');
                thisContact[0].Phone = (String)params.get('Phone')== 'null' ? null : (String)params.get('Phone');
                thisContact[0].LXD_Telefono_Celular__c = (String)params.get('MobilePhone');
                thisContact[0].Email = (String)params.get('Email')== 'null' ? null : (String)params.get('Email');
                thisContact[0].LXD_Estatus_de_la_clave_operativa__c = (String)params.get('LXD_Estatus_de_la_clave_operativa__c');
                thisContact[0].LXD_Estatus_de_la_relacion__c = (String)params.get('LXD_Estatus_de_la_relacion__c');
                thisContact[0].LXD_Atributos__c = (String)params.get('LXD_Atributos__c');
                thisContact[0].LXD_Banderas__c = (String)params.get('LXD_Banderas__c');
                thisContact[0].LXD_Genero__c = (String)params.get('LXD_Genero__c');
                thisContact[0].LXD_Nacionalidad__c = (String)params.get('LXD_Nacionalidad__c');
                thisContact[0].LXD_Estado_civil__c = (String)params.get('LXD_Estado_civil__c');
                thisContact[0].LXD_Identificacion_Personal__c = (String)params.get('LXD_Tipo_ID__c');
                thisContact[0].LXD_Clave_o_Numero__c = (String)params.get('LXD_Numero_ID__c');
                thisContact[0].LXD_Dato_secreto__c = (String)params.get('LXD_Dato_secreto__c');
                thisContact[0].LXD_Notas_1__c = (String)params.get('LXD_Notas_1__c')== 'null' ? null : (String)params.get('LXD_Notas_1__c');
                thisContact[0].LXD_Notas_2__c = (String)params.get('LXD_Notas_2__c')== 'null' ? null : (String)params.get('LXD_Notas_2__c');
                thisContact[0].LXD_Contrasena_personal__c = (String)params.get('LXD_Contrasena_personal__c');
                thisContact[0].MailingCountry = (String)params.get('Pais');

                update thisContact[0];                  
                idResult =  msg200; 
            }else{
                idResult = new Map<String, String>{
                    'Message' => 'Policy not found',
                    'Code' => '404', 
                    'Detail'=> 'La combinacion de clave: '+LXD_ClaveOperativa+' y el pais: '+pais+' no fue encontrado en la base de datos'
                };
            }

            String nDistribuidor = (String)params.get('LXD_N_Distribuidor__c');
            String statusRelacion = (String)params.get('LXD_Estatus_de_la_relacion__c');
            system.debug('nDistribuidor '+nDistribuidor);
            system.debug('statusRelacion '+statusRelacion);

            List<Account> accList = [
                SELECT Id, LXD_N_Distribuidor__c 
                    FROM Account 
                    WHERE LXD_N_Distribuidor__c = :nDistribuidor 
                    LIMIT 1
            ];
            system.debug('accList '+accList);

            if (!accList.isEmpty()) {
                List<AccountContactRelation> accConRelList = [
                    SELECT Id, AccountId, ContactId, IsActive 
                        FROM AccountContactRelation 
                        WHERE AccountId = :accList[0].Id
                    		AND ContactId = :thisContact[0].Id
                ];
                
                system.debug('accConRelList '+accConRelList);

                if (!accConRelList.isEmpty()) {
                    if (statusRelacion == 'Activo') {
                        accConRelList[0].IsActive = True;
                    } else if (statusRelacion == 'Baja logica') {
                        accConRelList[0].IsActive = False;
                    }
                    system.debug('accConRelList2 '+accConRelList);
                    update accConRelList;
                } else {
                    AccountContactRelation newAccConRelation = new AccountContactRelation();
                    newAccConRelation.AccountId = accList[0].Id;
                    newAccConRelation.ContactId = thisContact[0].Id;
                    newAccConRelation.IsActive = True;
                    
                    if (statusRelacion == 'Baja logica') {
                        newAccConRelation.IsActive = False;
                    }
                    system.debug('newAccConRelation '+newAccConRelation);
                    insert newAccConRelation;                
                }
            }
            system.debug('idResult '+idResult);
            return idResult;     
        }catch(Exception e) {
            return msg400 = new Map<String, String>{'Message' => 'Bad Request Error', 'Code' => '400', 'Detail'=>e.getMessage()}; 
        }
    }
}