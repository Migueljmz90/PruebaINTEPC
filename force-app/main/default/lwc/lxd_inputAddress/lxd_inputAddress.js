import { api, LightningElement, track } from 'lwc';

export default class Lxd_inputAddress extends LightningElement {

    @track cityName;
    @track streetName;
    @track countryName;
    @track postalName;
    @track stateName;
    

    @api
    get city() {
        return this.cityName;
    }
    set city(value) {
       this.cityName = value;
    }

    @api
    get street() {
        return this.streetName;
    }
    set street(value) {
       this.streetName = value;
    }

    @api
    get country() {
        return this.countryName;
    }
    set country(value) {
       this.countryName = value;
    }

    @api
    get postal() {
        return this.postalName;
    }
    set postal(value) {
       this.postalName = value;
    }

    @api
    get state() {
        return this.stateName;
    }
    set state(value) {
       this.stateName = value;
    }

    handlechangecityName(event){
        this.cityName = event.target.city;
    }
    handlechangestreetName(event){
        this.streetName = event.target.street;
    }
    handlechangepostalName(event){
        this.postalName = event.target.postalCode;
    }
    handlechangestateName(event){
        this.stateName = event.target.province;
    }
    
    genericInputChange(event){
        this.cityName = event.target.city;
        this.streetName = event.target.street;
        this.countryName = this.country;
        this.postalName = event.target.postalCode;
        this.stateName = event.target.province;

        console.log('Street => ' , event.target.street);
        console.log('City => ' , event.target.city);
        console.log('Province => ' , event.target.province);
        console.log('Country => ' , event.target.country);
        console.log('postal Code => ' , event.target.postalCode);    
    }

}