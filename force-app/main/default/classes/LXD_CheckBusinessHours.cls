public class LXD_CheckBusinessHours {
    
	@InvocableMethod(label = 'Within Business Hours Check')
    public static List<Boolean> makeGetCallout(List<String> Name) {
        String BHName= String.valueOf(+Name[0]);
        Datetime targetTime;
        // Get Business hours based on name, input from bot
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name= :BHName];
        // Create Datetime with current date/time in local time zone
        if(Test.isRunningTest()){
            targetTime  = datetime.newInstance(2022, 9, 15, 12, 30, 0);
        }else{
            targetTime = Datetime.now();
        }        
        // Find whether the time is within business hours
        Boolean isWithin= BusinessHours.isWithin(bh.id, targetTime);
        return new List<Boolean>{isWithin};
    }
    
}