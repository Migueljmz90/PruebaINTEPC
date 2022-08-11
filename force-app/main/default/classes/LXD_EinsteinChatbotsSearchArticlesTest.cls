@isTest
public class LXD_EinsteinChatbotsSearchArticlesTest {
	@isTest
    public static void searchKnowledgeArticlesWithInvocableMethod(){
        Knowledge__kav k = new Knowledge__kav(URLName = 'Apex-Test-URLName', Title = 'Apex Test URLName', Summary = 'Esto es una knowledge de prueba.' ); 
        Insert k; 
        
        Knowledge__kav k2 = new Knowledge__kav(URLName = 'Apex-Test2-URLName', Title = 'Apex Test URLName 2', Summary = 'Esto es una knowledge de prueba parte 2.' ); 
        Insert k2;
        
        LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest kat1 = new LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest();
        kat1.querystring = 'Apex Test URLName';
        LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest kat2 = new LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest();
        kat2.querystring = 'Apex Test URLName 2';
        
        List<LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest> knowledgesToSearch = new List<LXD_EinsteinChatbotsSearchArticles.KnowledgeArticleTitleRequest>();
        knowledgesToSearch.add(kat1);
        knowledgesToSearch.add(kat2);
        
        List<Knowledge__kav> knowledges = new List<Knowledge__kav>();
        
        Test.startTest();
        knowledges = LXD_EinsteinChatbotsSearchArticles.fetchKnowledgeArticleSearchAndFilter(knowledgesToSearch);
        Test.stopTest();
        
        system.assertequals('Apex-Test-URLName', knowledges[0].URLName);
        system.assertequals('Apex Test URLName', knowledges[0].Title);
        system.assertequals('Esto es una knowledge de prueba.', knowledges[0].Summary);
        
        system.assertequals('Apex-Test2-URLName', knowledges[1].URLName);
        system.assertequals('Apex Test URLName 2', knowledges[1].Title);
        system.assertequals('Esto es una knowledge de prueba parte 2.', knowledges[1].Summary);
    }
}