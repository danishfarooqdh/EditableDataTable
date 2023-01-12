public inherited sharing class DataTableCaller implements Callable {
    
    private static DataTableCaller callerInstance;

    public static DataTableCaller getInstance(){

        if (callerInstance == null) {
            callerInstance = new DataTableCaller();
        }
        return callerInstance;
    }

    public Object call(string action, Map<String, Object> parameters ){

        Object callResult;
        switch on action{

            when 'modifyColumns'{
                String columns = (String)parameters.get('columns');
                List<DataTableColumns> dtCols = (List<DataTableColumns>) JSON.deserialize(columns,List<DataTableColumns>.class);
                callResult =  DataTableWrapper.modifyColumnStructure('Account' , dtCols);
            }

        }
        return callResult;
    }
}
