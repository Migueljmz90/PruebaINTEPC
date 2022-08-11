global class LXD_EinsteinChatbotsSearchArticles {
	global class KnowledgeArticleTitleRequest {
         @InvocableVariable
         global String queryString;
    }      
    
    global class KnowledgeArticleTitleResult {
        @InvocableVariable
        global String KnowledgeTitle;
        
        @InvocableVariable
        global String ChatAnswer;
    }
    
    @InvocableMethod(label='Einstein Chatbots - Search Knowledge Articles' description='Returns a list of Knowledge Articles for provided Data Category and Search String')
    global static List<Knowledge__kav> fetchKnowledgeArticleSearchAndFilter(List<KnowledgeArticleTitleRequest> queryParams) {
        List<Knowledge__kav> results = new List<Knowledge__kav>();
        for(KnowledgeArticleTitleRequest param : queryParams) {
            results.addAll(fetchKnowledgeArticle(param.queryString));                         
        }
        return results;

    }    
    
    public static List<Knowledge__kav> fetchKnowledgeArticle(string searchQuery) { 
        
        string searchString = '%' + searchQuery + '%';
        List<Knowledge__kav> catdata = [Select ID, Title, UrlName, KnowledgeArticleId, Summary From Knowledge__kav Where Title like: searchString];
        System.debug('Lista de knowledges devuelta = '+catdata);		
        return catdata;
    }
}