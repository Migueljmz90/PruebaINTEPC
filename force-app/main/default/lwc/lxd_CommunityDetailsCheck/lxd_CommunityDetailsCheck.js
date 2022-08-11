import { LightningElement, track, wire } from 'lwc';  
import fetchContactInfo from '@salesforce/apex/LXD_CommunityDetailsCheckController.fetchContactInfo'; 
import fetchKnowledge from '@salesforce/apex/LXD_CommunityDetailsCheckController.fetchKnowledge';
import updateContact from '@salesforce/apex/LXD_CommunityDetailsCheckController.updateContact';

export default class Lxd_CommunityDetailsCheck extends LightningElement {
    avisoDePrivasidad = true;
    @track error;   
    @track objContact;
    @track knowledgeContent;
    @track isknowledgeContent = false;
    @wire (fetchKnowledge,{})
    fetchKnowledge(respuesta){
        console.log('articulos = '+respuesta.data);
        this.knowledgeContent = respuesta.data;
        this.isknowledgeContent = true;
    }
    connectedCallback() {    
        fetchContactInfo()      
        .then(result => {    
            this.objContact = result.Id;
            this.avisoDePrivasidad = result.LXD_Acepto_aviso_de_privacidad__c    
        })    
        .catch(error => {   
            console.log(JSON.stringify(error)) 
            this.error = JSON.stringify(error) ;    
        });   
        console.log('ID de CONTACTO = '+this.objContact)
    }   

    OnClick() {
        updateContact({ContactId:this.objContact}).then(()=>{
            this.avisoDePrivasidad = true;
        }).catch(error=>{
            console.log(error);
        })
    }

}