import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import createAccount from '@salesforce/apex/AccountController.createAccount';
import deleteAccount from '@salesforce/apex/AccountController.deleteAccount';

const COLUMNS = [
    { label: 'Nome', fieldName: 'Name' },
    { label: 'Indústria', fieldName: 'Industry' },
    { label: 'Receita Anual', fieldName: 'AnnualRevenue', type: 'currency' },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Excluir', name: 'delete' }
            ]
        }
    }
];

export default class AccountList extends LightningElement {
    @track accounts = [];
    @track error;
    @track showModal = false;
    @track newAccount = {};
    columns = COLUMNS;

    connectedCallback() {
        this.refreshData();
    }

    refreshData() {
        getAccounts()
            .then(data => {
                this.accounts = data;
                this.error = undefined;
            })
            .catch(error => {
                this.error = this.formatError(error);
            });
    }

    openNewModal() {
        this.showModal = true;
    }

    closeModal() {
        this.showModal = false;
        this.newAccount = {};
    }

    handleInputChange(event) {
        this.newAccount = {
            ...this.newAccount,
            [event.target.name]: event.target.value
        };
    }

    // Criar conta
    async createAccount() {
        try {
            console.log('Novo Account:', this.newAccount);
            await createAccount({
                name: this.newAccount.name,
                Industry: this.newAccount.industry,
                AnnualRevenue: this.newAccount.annualRevenue ? parseFloat(this.newAccount.annualRevenue) : null
            });
            this.refreshData();
            this.closeModal();
        } catch (error) {
            this.error = this.formatError(error);
        }
    }

    // Excluir conta
    async handleRowAction(event) {
        if (event.detail.action.name === 'delete') {
            try {
                const success = await deleteAccount({ accountId: event.detail.row.Id });
                if (success) {
                    this.refreshData();
                }
            } catch (error) {
                this.error = this.formatError(error);
            }
        }
    }

    formatError(error) {
        return error.body?.message || 'Erro desconhecido';
    }
}