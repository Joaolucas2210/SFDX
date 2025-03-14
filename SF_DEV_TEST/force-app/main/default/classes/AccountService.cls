public with sharing class AccountService {

    public static List<Account> getAccounts() {
        try {
            return AccountRepository.getAllAccounts();
        } catch (Exception e) {
            throw new AuraHandledException('Erro ao buscar contas: ' + e.getMessage());
        }
    }

    // Método para criar conta
    public static Account createAccount(String name, String industry, Decimal annualRevenue) {
        if (String.isBlank(name)) {
            throw new AuraHandledException('Erro ao criar conta: Nome da conta é obrigatório.');
        }
        try {
            Account newAccount = new Account(
                Name = name,
                Industry = industry,
                AnnualRevenue = annualRevenue
            );
            return AccountRepository.insertAccount(newAccount);
        } catch (Exception e) {
            throw new AuraHandledException('Erro ao criar conta: ' + e.getMessage());
        }
    }

    // Método para excluir conta
    public static Boolean deleteAccount(Id accountId) {
        try {
            if (accountId == null) {
                throw new AuraHandledException('Erro ao excluir conta: ID da conta é inválido.');
            }
            Account accountToDelete = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
            delete accountToDelete;
            return true; //
        } catch (Exception e) {
            throw new AuraHandledException('Erro ao excluir conta: ' + e.getMessage());
        }
    }
}