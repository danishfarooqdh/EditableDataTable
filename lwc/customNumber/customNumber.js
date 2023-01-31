import { LightningElement,api } from 'lwc';

export default class CustomNumber extends LightningElement {

    @api scale;
    @api maxLength;
    @api value;
    @api fieldApiName;
    @api recordId;
 

    handleChange(event){
        
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
