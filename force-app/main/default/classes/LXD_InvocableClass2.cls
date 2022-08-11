public with sharing class LXD_InvocableClass2 {
    @InvocableMethod(label='Obtener User al azar' description='Devuelve elemento de la lista pasada' category='User')
    public static List<List<User>> getUser(List<List<User>> elementos){
        system.debug(elementos.get(0));
        List<User> users = new List<User>();
        users.add(elementos[0][LXD_SkyUtils.getRandomElement(elementos.size())]);
        List<List<User>> listUsers = new List<List<User>>();
        listUsers.add(users);
        return listUsers;//{elementos[LXD_SkyUtils.getRandomElement(elementos.size())]};
    }
}