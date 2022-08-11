public class LXD_TextAutomation {

    @InvocableMethod(label='Remove HTML Tags')
    public static List<String> removeHtmlTags (List<String> richTextList) {
        String richText = richTextList[0];
        
        // plainText List that will be returned by the method
        List<String> plainTextList = new List<String>();
        
        // Use the stripHtmlTags function to remove the HTML tags
        richText = richText.stripHtmlTags();
        
        // Add the updated richText string to the list of plain text that will be returned
        plainTextList.add(richText);
        return plainTextList;
	}
}