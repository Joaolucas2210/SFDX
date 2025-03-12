import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const COLUMNS = [
    { label: 'Nome', fieldName: 'Name', type: 'text' },
    { label: 'Indústria', fieldName: 'Industry', type: 'text' },
    { label: 'Receita Anual', fieldName: 'AnnualRevenue', type: 'currency' }
];

export default class AccountList extends LightningElement {
    accounts;
    error;
    columns = COLUMNS;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
            console.error('Erro:', error);
        }
    }
}