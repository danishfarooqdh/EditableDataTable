import LightningDatatable from 'lightning/datatable';
import customPicklistTemplate from './customPickListTemplate.html';
import customLookupTemplate from './customLookupTemplate.html';


export default class CustomDataTable extends LightningDatatable {


    static customTypes = {
       
        customPicklist: {
            template: customPicklistTemplate,
            standardCellLayout: true,
            typeAttributes: ['options','record','fieldApiName']
        },
        customLookup: {
            template: customLookupTemplate,
            standardCellLayout: true,
            typeAttributes: ['objName']
        }
    }
}
