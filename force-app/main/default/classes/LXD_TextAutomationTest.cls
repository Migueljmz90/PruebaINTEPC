@isTest
public with sharing class LXD_TextAutomationTest {
    @IsTest
    static void shouldReturnStringWithOutHTMLTags(){
        List<String> textoHtml = new List<String>{'<h1>Hola Mundo</h1>'};
        Test.startTest();
        List<String> textoPlano = LXD_TextAutomation.removeHtmlTags(textoHtml);
        Test.stopTest();
        System.assertEquals('Hola Mundo', textoPlano[0], 'el texto no es el esperado');
    }
}