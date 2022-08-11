trigger LXD_ContactTrigger on Contact (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        List<Contact> cntToUpdate = new List<Contact>();
        List<String> preClaves = new List<String>{'Pre-Técnico',
                                                    'Pre-Vendedor',
                                                    'Pre-Administrativo',
                                                    'Pre-Reparador',
                                                    'Pre-Técnico;Pre-Vendedor',
                                                    'Pre-Técnico;Pre-Administrativo',
                                                    'Pre-Técnico;Pre-Administrativo;Pre-Vendedor',
                                                    'Pre-Reparador;Pre-Administrativo'};
        List<String> postClaves = new List<String>{'Técnico',
                                                    'Vendedor',
                                                    'Validador',
                                                    'Administrativo',
                                                    'Gestor',
                                                    'Técnico;Vendedor',
                                                    'Administrativo;Gestor',
                                                    'Administrativo;Técnico',
                                                    'Administrativo;Técnico;Vendedor',
                                                    'Administrativo;Vendedor',
                                                    'Administrativo;Validador',
                                                    'Gestor;Técnico'};
                                                        
        try {
            for(Contact cnt : trigger.new){ 
                if(postClaves.contains(cnt.LXD_Tipo_de_clave_operativa__c) 
                    && preClaves.contains(trigger.oldMap.get(cnt.Id).LXD_Tipo_de_clave_operativa__c)
                ){
                    cntToUpdate.add(cnt);
                }
            }
            if(!cntToUpdate.isEmpty()) {
                LXD_ContactTriggerHelper.callAltaOperativa(cntToUpdate);  
            } 
        } catch (Exception e) {
            system.debug('Exception = '+ e.getMessage());
            throw new DMLException(e.getMessage());
        }  
    }
}