/***
 * @description: Wrapper class to generate customized coloumn
 * @date 07.01.2023
 * @author Danish Farooq
 */
public with sharing class DataTableWrapper {
    public DataTableWrapper() {

    }
 
    @InvocableMethod
    public static List<Response> execute (List<Request> req) {

        Response res = new Response();
        res.definedColumns = modifyColumnStructure(req[0].sObjectName,req[0].definedColumns);
        return new List<Response> { res };
      
    }

    public static List<DataTableColumns> modifyColumnStructure(string sObjectName, List<DataTableColumns> columns ){
         
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objectSchema = schemaMap.get(sObjectName);
        Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();
        DataTableColumns.Attributes attributes;
        DataTableColumns.Option option;
      
        for(DataTableColumns iCol : columns){
             
            if(iCol.editable == null || !iCol.editable) continue;
             
            attributes = new DataTableColumns.Attributes();
            option = null;
           
            Schema.DescribeFieldResult fieldResult = fieldMap.get(iCol.fieldName).getDescribe();
            Schema.DisplayType fielddataType = fieldResult.getType();
            List<Schema.PicklistEntry> lstPickListValues = fieldResult.getPickListValues();
            if(fielddataType == Schema.DisplayType.Picklist){
                option = new DataTableColumns.Option();
                iCol.type = 'customPicklist';
                iCol.editable = false;
                iCol.wrapText = true;
                attributes.options = fetchPickListData(lstPickListValues);
                iCol.typeAttributes = attributes;   
                continue;    
            }   
            if(fielddataType == Schema.DisplayType.Reference){
                iCol.type = 'customLookup';
                iCol.editable = false;
                iCol.wrapText = true;
                attributes.objName = sObjectName;
                iCol.typeAttributes = attributes;   
                continue;    
            }    
        }
        return columns;
    }

    private static List<DataTableColumns.Option> fetchPickListData(List<Schema.PicklistEntry> lstPickListValues){

        List<DataTableColumns.Option> options = new  List<DataTableColumns.Option>();
        for( Schema.PicklistEntry pickList : lstPickListValues){
            DataTableColumns.Option option =  new DataTableColumns.Option();
            option.label = pickList.getLabel();
            option.value = pickList.getValue();
            options.add(option);
        }
        return options;

    }


    public class Request{

        @InvocableVariable(label='Selected Columns' description='sObject records for Input' required=true)
        public List<DataTableColumns> definedColumns;

        @InvocableVariable(label='sObject Name' description='Object name to get the Fields Details' required=true)
        public string sObjectName;

    }

    public class Response{

        @InvocableVariable(label='Modified Columns' description='sObject records for Input' required=true)
        public List<DataTableColumns> definedColumns;


    }

    

}
