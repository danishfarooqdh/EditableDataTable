public inherited sharing class DataTableCtrl {
    
    
    @AuraEnabled
    public static object executeApex(String action,
                                    Map<string,object> parameters ){

        return DataTableCaller.getInstance().call(action,parameters);    
    }
}
