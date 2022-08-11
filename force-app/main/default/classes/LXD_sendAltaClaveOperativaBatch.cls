global class LXD_sendAltaClaveOperativaBatch implements Database.Batchable<Contact>, Database.AllowsCallouts, Database.Stateful {
    private List<Contact>contactLst;

    public LXD_sendAltaClaveOperativaBatch(List<Contact> contactLst){
        this.contactLst = contactLst;
    }
    global List<Contact> start(Database.BatchableContext BC) {
        return contactLst;
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> contactLst) {
        try {
            LXD_SkyUtils.AltaClaveOperativa(contactLst[0].Id);
            
        } catch(Exception e) {
            throw new DMLException('No se pudo crear el contacto');
        }
    }   
    global void finish(Database.BatchableContext BC) {
        if (test.isRunningTest()) {
            throw new DMLException('Envio de Claves Operativas a Jhonny Rocket');
        }
        System.debug('se finalizo el envio de Claves Operativas a Jhonny Rocket');
    }
}