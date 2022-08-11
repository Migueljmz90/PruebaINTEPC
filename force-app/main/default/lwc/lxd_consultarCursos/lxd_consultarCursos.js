import { LightningElement, track, api, wire} from 'lwc';

import getNotasUsuario from '@salesforce/apex/LXD_SkyUtils.getNotasUsuario';
import LXD_Clave_operativa__c from "@salesforce/schema/Contact.LXD_Clave_operativa__c";
import { getRecord,getFieldValue } from 'lightning/uiRecordApi';

const FIELDS = [
    LXD_Clave_operativa__c,
    'Contact.Name'
];


export default class Lxd_consultarCursos extends LightningElement {
    @track columns = [{
            label: 'Nombre',
            fieldName: 'Nombre',
            type: 'text',
            sortable: false
        },
        {
            label: 'Curso',
            fieldName: 'Curso',
            type: 'text',
            sortable: false
        },
        {
            label: 'Categoria',
            fieldName: 'Categoria',
            type: 'text',
            sortable: false
        },
        {
            label: 'Fecha',
            fieldName: 'Fecha',
            type: 'text',
            sortable: false
        },
        {
            label: 'Calificacion',
            fieldName: 'Calificacion',
            type: 'text',
            sortable: false
        }
    ];
    @api userIdentifier;
    @track notasCursos;
    showNotasCursos=false;
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact(response){
        console.log(response)
        if(response){
            this.userIdentifier= getFieldValue(response.data, LXD_Clave_operativa__c);
        }
    };
    

    handleSearch(event){
        var userIdentifier = this.template.querySelector('lightning-input').value
        getNotasUsuario({userCode:userIdentifier}).then(data =>{
            this.notasCursos = JSON.parse(data)
            this.showNotasCursos = true
        }).catch(error =>{
            console.log('Error = '+JSON.stringify(error))
        })
    }
}