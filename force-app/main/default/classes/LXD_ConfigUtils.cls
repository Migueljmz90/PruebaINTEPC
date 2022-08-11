public with sharing class LXD_ConfigUtils {
    private static Organization currentOrg;

	public static Boolean isProductionEnviroment() {

		if (currentOrg == null) {
			currentOrg = [SELECT Id, Name, IsSandbox FROM Organization LIMIT 1];
		}

		return !currentOrg.isSandbox;
	}

	public static LXD_Endpoints__mdt getWebServiceConfig(String wsName) {
		return [
			SELECT
				DeveloperName,
				LXD_Url__c,
				LXD_accessToken__c,
				LXD_usuario__c,
                LXD_funtion__c,
				LXD_IsProduction__c
			FROM LXD_Endpoints__mdt
			WHERE LXD_IsProduction__c = :isProductionEnviroment()
				AND MasterLabel = :wsName
			LIMIT 1
		];
	}
}