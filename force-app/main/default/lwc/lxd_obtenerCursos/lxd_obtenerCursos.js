import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
/** The delay used when debouncing event handlers before invoking Apex. */
const DELAY = 300;
export default class LXD_wsGetCursos extends LightningElement {

    @track columns = [{
            label: 'Nombre',
            fieldName: 'fullname',
            type: 'text',
            sortable: false
        },
        {
            label: 'Grado',
            fieldName: 'grade',
            type: 'text',
            sortable: false
        },
        {
            label: 'Visible',
            fieldName: 'visible',
            type: 'text',
            sortable: false
        },
        {
            label: 'Roles',
            fieldName: 'roles',
            type: 'text',
            sortable: false
        }
    ];


    @track userIdentifier;

    userChange(event) {
        console.log('event '+event.target.name);
        if(event.target.name=='1234')
            this.userIdentifier= event.target.value;

    }

    get userIdentifier(){
        return this.userIdentifier;
    }   


    LXD_WSGetCursosMoodle;

   handleKeyChange(event) {
    // Debouncing this method: Do not update the reactive property as long as this function is
    // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
    window.clearTimeout(this.delayTimeout);
    const searchKey = event.target.value;
    console.log('searchKey '+searchKey);
    this.delayTimeout = setTimeout(() => {
        this.searchKey = searchKey;
    }, DELAY);
}

   handleSuccess(e) {

        this.dispatchEvent(new CloseActionScreenEvent());

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Exitoso',
                message: '¡Los cursos han sido actualizados!',
                variant: 'success'
            })
        );

   }

}