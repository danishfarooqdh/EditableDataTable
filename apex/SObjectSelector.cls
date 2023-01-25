public inherited sharing class CustomLookUpCtrl {

    /**
     * used to search data from sObject 
     * @param searchTerm 
     * @param myObject 
     * @return  `List<sObject>`
     */
    @AuraEnabled(cacheable=true)
    public static List<sObject> search(String searchTerm, string myObject) {
     

        if(String.isBlank(searchTerm)){
            return SObjectSelector.getInstance(myObject).getDefaultRecords();
        }
        
        return SObjectSelector.getInstance(myObject).getSearchRecords(searchTerm);
            
    }
}
