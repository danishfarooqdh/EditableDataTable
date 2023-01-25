public inherited Sharing class SObjectSelector {
    
    private static SObjectSelector selector;
    private static string defaultQuery;
    public static List<sObject> defaultRecords; 
    
    /**
     * Used to instantiate class according to singleton pattern
     * @param objectName 
     * @return  `SObjectSelector`
     */
    public static SObjectSelector getInstance(string objectName){

        if(selector == null){
            selector = new SObjectSelector();
            defaultQuery = String.format('SELECT Id,' +
                                        'Name FROM {0}' , new List<Object> { objectName });
            return selector;
        } 
        return selector;
    }

    /**
     * Used to get default records every time when request is hit
     * @return  `List<sObject>`
     */
    public List<sObject> getDefaultRecords(){

        /*to avoid mutiple queries for each transaction 
        when default selection is made*/
        if(defaultRecords == null){
            string lastViewedQuery = String.format('{0} ' + 
                                    'WHERE LastViewedDate != NULL ' +
                                    'ORDER BY LastViewedDate DESC ' +  
                                    'LIMIT 5', new List<Object> { defaultQuery });   

            defaultRecords = database.query(lastViewedQuery);
        }
       
        return defaultRecords;
    }

    /**
     * Used to get search records every time when request is hit
     * @param searchText 
     * @return  `List<sObject>`
     */
    public List<sObject> getSearchRecords(string searchText){
        
        searchText = '\'%' + searchText + '%\'';
        string filteredQuery = String.format('{0} ' + 
                                            'WHERE Name like {1} ' +
                                            'LIMIT 5', new List<Object> { defaultQuery, searchText });   
        
        return database.query(filteredQuery);
    }
}
