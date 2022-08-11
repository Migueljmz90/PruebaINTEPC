@isTest
public class LXD_MultiSelectFlowValuestest {
  @isTest

    static void MultiSelectFlowValuesTest(){

        List<string> tempLst = new list<string>();

        tempLst.add('AccidentalCoder');

        tempLst.add('Salesforce');

        LXD_MultiselectFlowvalues.CheckValues(tempLst);

    }
     @isTest
    
        static void MultiSelectFlowValuesTestNull(){
	
        List<string> tempLst = new list<string>();

        LXD_MultiselectFlowvalues.CheckValues(tempLst);

    }
}