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
         
        /**
         * picklist options to set on this list to show on UI
         */
         @AuraEnabled
         public List<Option> options;

         @AuraEnabled
         public String objName;
        /**
         * field to used for indexing record
         */
         @AuraEnabled
         public Record record;
        /**
         * Api name for the field that value needs to be updated
         */
         @AuraEnabled
         public String fieldApiName;

         @AuraEnabled
         public Integer maxLength;
 
         @AuraEnabled
         public Double precision;
 
         @AuraEnabled
         public Integer scale;
    }


    public class Option{

        @AuraEnabled
        public String label;

        @AuraEnabled
        public String value;
    } 
    
    public class Record {

        @AuraEnabled
        public String fieldName;
    }
}
