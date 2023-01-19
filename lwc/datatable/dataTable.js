import { LightningElement,api } from 'lwc';
import executeApex from '@salesforce/apex/DataTableCtrl.executeApex';


export default class DataTable extends LightningElement {

    
    @api records;
    @api tableColumns;
    updatedColumns;
    @api updatedRecords;
    draftValues = [];


    
    connectedCallback(){

     
        this.fetchModifiedColumns();
        this.updatedRecords = JSON.parse(JSON.stringify(this.records));
       
    }

  
    fetchModifiedColumns(){

      
        let columnsJson = JSON.stringify(this.tableColumns);
        let paramsObj = 
            {'columns' : columnsJson }
    
        executeApex(
            {action : 'modifyColumns' , parameters : paramsObj}
            ).then(response => {
                this.updatedColumns = response;   
             
        }).catch(error => {

        });
    }

    renderedCallback(){
         
    }

    handleCustomType(event){
        
        let searchedRecord = this.updatedRecords.find(record => record.Id == event.detail.selectedId); 
        searchedRecord[event.detail.fieldApiName] = event.detail.value;
        this.updatedRecords = [...this.updatedRecords];
    }
}
