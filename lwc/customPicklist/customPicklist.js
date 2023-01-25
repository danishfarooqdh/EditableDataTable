import { LightningElement,api } from 'lwc';

export default class CustomPicklist extends LightningElement {

    @api value;
    @api picklistValues;
    @api recordId;
    @api fieldApiName;

    get options(){

        return this.picklistValues;
    }

    handleChange(event){
        
        //var params = { value : event.detail.value , selectedId :  'abc'};
        const custEvent = CustomEvent('customfieldchange', {
            composed: true,
            bubbles: true,
            cancelable: true,
            detail : {
                value : event.detail.value,
                selectedId : this.recordId,
                fieldApiName : this.fieldApiName
            }
        });
      this.dispatchEvent(custEvent);
    }
}
