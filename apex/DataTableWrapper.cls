/***
 * @description: Wrapper class to generate customized coloumn
 * @date 07.01.2023
 * @author Danish Farooq
 */
public  inherited sharing class DataTableWrapper {

    public DataTableWrapper() {

    }
 
    /**
     * Override the column type based of the field type
     * @param sObjectName 
     * @param columns 
     * @return  `List<DataTableColumns>`
     */
    public static List<DataTableColumns> modifyColumnStructure(string sObjectName, List<DataTableColumns> columns ){
         
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objectSchema = schemaMap.get(sObjectName);
        Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();
        DataTableColumns.Attributes attributes;
        DataTableColumns.Record record;
      
        for(DataTableColumns iCol : columns){
             
            if(iCol.editable == null || !iCol.editable) continue;
             
            attributes = new DataTableColumns.Attributes();
            Schema.DescribeFieldResult fieldResult = fieldMap.get(iCol.fieldName).getDescribe();
            Schema.DisplayType fielddataType = fieldResult.getType();

            iCol.editable = false;
            iCol.wrapText = true;

            if(fielddataType == Schema.DisplayType.PICKLIST){

                List<Schema.PicklistEntry> lstPickListValues = fieldResult.getPickListValues();
                record = new DataTableColumns.Record();
                iCol.type = 'customPicklist';
                iCol.editable = false;
                iCol.wrapText = true;
                attributes.options = getPickListValues(lstPickListValues);
                record.fieldName = 'Id';
                attributes.record = record;
                attributes.fieldApiName = iCol.fieldName;
                iCol.typeAttributes = attributes;   
                continue;    
            }   
            if(fielddataType == Schema.DisplayType.REFERENCE){
                iCol.type = 'customLookup';
                attributes.objName = sObjectName;
                iCol.typeAttributes = attributes;   
                continue;    
            }    
        }
        return columns;
    }

    private static List<DataTableColumns.Option> getPickListValues(List<Schema.PicklistEntry> lstPickListValues){

        List<DataTableColumns.Option> options = new  List<DataTableColumns.Option>();
        for( Schema.PicklistEntry pickList : lstPickListValues){
            DataTableColumns.Option option =  new DataTableColumns.Option();
            option.label = pickList.getLabel();
            option.value = pickList.getValue();
            options.add(option);
        }
        return options;

    }
}
