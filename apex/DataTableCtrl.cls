public inherited sharing class DataTableCtrl {
    
    
    /**
     * Main front-end facing method to control the class flow
     * @param action 
     * @param parameters 
     * @return  `Object`
     */
    @AuraEnabled
    public static Object executeApex(String action,
                                    Map<String,Object> parameters ){
        
        Object response = DataTableCaller.getInstance().call(action,parameters);
        return response;
        
    }
}
