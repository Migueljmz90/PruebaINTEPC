window._snapinsSnippetSettingsFile = (function() {
    console.log("Snippet settings file loaded.");
    embedded_svc.snippetSettingsFile.extraPrechatFormDetails = [
        { 
        "label":"LXD_Username", "transcriptFields":[ "LXD_Username__c" ],
        },{
        "label":"LastName", "transcriptFields": ["LXD_LastName__c"]
        },{
        "label":"FirstName", "transcriptFields": ["LXD_FirstName__c"]
        },{
        "label":"Email", "transcriptFields": ["LXD_Email__c"]
    }];
})();