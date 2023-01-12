import { LightningElement,api } from 'lwc';
import executeApex from '@salesforce/apex/DataTableCtrl.executeApex';

export default class DataTable extends LightningElement {

    
    @api records;
    @api tableColumns;
    @api updatedRecords;

    connectedCallback(){

        this.fetchModifiedColumns();
       
    }



    fetchModifiedColumns(){

        console.log('====>Columns' + JSON.stringify(this.tableColumns));
        let columnsJson = JSON.stringify(this.tableColumns);
        let paramsObj = 
            {'columns' : columnsJson }
    
        executeApex({action : 'modifyColumns' , parameters : paramsObj}).then(response => {
            this.updatedColumns = response;
            console.log('====>Updated' + JSON.stringify(this.updatedColumns));
        }).catch(error => {

        });
    }

    renderedCallback(){
      
    }


}
