public with sharing class LXD_InvocableClass {
    @InvocableMethod(label='Obtener AccountContactRelation al azar' description='Devuelve elemento de la lista pasada' category='AccountContactRelation')
    public static List<List<Contact>> getAccountContactRelation(List<List<Contact>> elementos){
        system.debug(elementos.get(0));
        List<Contact> cuentasContactosRelacionados = new List<Contact>();
        cuentasContactosRelacionados.add(elementos[0][LXD_SkyUtils.getRandomElement(elementos.size())]);
        List<List<Contact>> listCuentasContactosRelacionados = new List<List<Contact>>();
        listCuentasContactosRelacionados.add(cuentasContactosRelacionados);
        return listCuentasContactosRelacionados;//{elementos[LXD_SkyUtils.getRandomElement(elementos.size())]};
    }
}