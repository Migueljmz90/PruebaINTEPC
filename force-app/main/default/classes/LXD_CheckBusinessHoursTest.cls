@isTest
public class LXD_CheckBusinessHoursTest {
    @isTest
    public static void getCurrentUserTest(){
        List<Boolean> resultBusinessHours = new List<Boolean>();
            
        List<String> nameString = new List<String>();
        nameString.add('SKY-BOT');
        
        Test.startTest();
        	resultBusinessHours =  LXD_CheckBusinessHours.makeGetCallout(nameString);
        Test.stopTest();
        
        System.assertEquals(true, resultBusinessHours[0]);
    }
}