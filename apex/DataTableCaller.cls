/***
 * @description: Generic caller class for AuraEnabled Method
 * @date 11.01.2023
 * @author Danish Farooq
 */
public inherited sharing class DataTableCaller implements Callable {
    
    private static DataTableCaller callerInstance;

    /**
     * Used to instantiate class according to singleton pattern
     * @return  `DataTableCaller`
     */
    public static DataTableCaller getInstance(){

        if (callerInstance == null) {
            callerInstance = new DataTableCaller();
        }
        return callerInstance;
    }
    /**
     * implementation for dynamic method calling
     * @param action action to call
     * @param parameters each method parameters
     * @return  `Object`
     */
    public Object call(String action, Map<String, Object> parameters ){

        Object callResult;

        switch on action{

            when 'modifyColumns'{
                       
                String columns = (String)parameters.get('columns');
                Id recordId = (Id)parameters.get('recordId');
                String objApiName = recordId.getsObjectType().getDescribe().getName();
                List<DataTableColumns> dtCols = (List<DataTableColumns>) JSON.deserialize(columns,List<DataTableColumns>.class);
                callResult =  DataTableWrapper.modifyColumnStructure(objApiName, dtCols);
            }

        }
        return callResult;
    }
}
