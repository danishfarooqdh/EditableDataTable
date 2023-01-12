import { LightningElement,api } from 'lwc';
import executeApex from '@salesforce/apex/DataTableCtrl.executeApex';

export default class DataTable extends LightningElement {

    
    @api records;
    @api tableColumns;

    connectedCallback(){

        this.fetchModifiedColumns();       
    }



    fetchModifiedColumns(){

     
        let columnsJson = JSON.stringify(this.tableColumns);
        let paramsObj = 
            {'columns' : columnsJson }
    
        executeApex({action : 'modifyColumns' , parameters : paramsObj}).then(response => {
            this.updatedColumns = response;
        
        }).catch(error => {

        });
    }

    renderedCallback(){
      
    }


}
