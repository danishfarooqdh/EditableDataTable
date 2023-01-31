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
                record = new DataTableColumns.Record();
                Schema.DescribeFieldResult fieldResult = fieldMap.get(iCol.fieldName).getDescribe();
                Schema.DisplayType fielddataType = fieldResult.getType();
                iCol.editable = false;
                iCol.wrapText = true;
                attributes.precision = 1;
                attributes.fieldApiName = iCol.fieldName;
                record.fieldName = 'Id';
                attributes.record = record;
                iCol.typeAttributes = attributes;  

                if(fielddataType == Schema.DisplayType.PICKLIST ){

                    List<Schema.PicklistEntry> lstPickListValues = fieldResult.getPickListValues();
                
                    iCol.type = 'customPicklist';
                    attributes.options = getPickListValues(lstPickListValues);
                    continue;    
                }   
                if(fielddataType == Schema.DisplayType.REFERENCE){
                    iCol.type = 'customLookup';
                    attributes.objName = sObjectName; 
                    continue;    
                } 
                
                if(fielddataType == Schema.DisplayType.INTEGER){
                    iCol.type = 'customNumber';
                    attributes.maxLength = fieldResult.getDigits();
                    continue;
                }
                if(fielddataType == Schema.DisplayType.CURRENCY ){
                    iCol.type = 'customNumber';
                    attributes.precision =  createStepValue(fieldResult.getScale());
                    attributes.maxLength = fieldResult.getPrecision();
                    continue;    
                }    

                if(fielddataType == Schema.DisplayType.DOUBLE ){
                    iCol.type = 'customNumber';
                    attributes.precision =  createStepValue(fieldResult.getScale());
                    attributes.maxLength = fieldResult.getPrecision();
                    continue;    
                }   
            }
            return columns;
        }

        private static Double createStepValue(integer scale){

            if(scale == 0) return 1;
            string precision = '.';
            for(integer index = 1 ; index < scale; index++){
                precision += '0';
            }
            precision += '1';
            return Double.valueOf(precision);
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
