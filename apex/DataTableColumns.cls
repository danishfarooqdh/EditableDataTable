/***
 * @description: Wraper class for holding column defination for showing dynamic Datatable
 * @date 05.01.2023
 * @author Danish Farooq
 */
global class DataTableColumns {
    
    @AuraEnabled
    public String label;

    @AuraEnabled
    public String fieldName;

    @AuraEnabled
    public boolean editable;

    @AuraEnabled
    public string type;

    @AuraEnabled
    public boolean wrapText;

    @AuraEnabled
    public Attributes typeAttributes;


    public class Attributes{
         
         @AuraEnabled
         public List<Option> options;

         @AuraEnabled
         public string objName;

         @AuraEnabled
         public Record record;

         @AuraEnabled
         public string fieldApiName;
    }

    public class Option{

        @AuraEnabled
        public string label;

        @AuraEnabled
        public string value;
    } 
    
    public class Record {

        @AuraEnabled
        public string fieldName;
    }
}
