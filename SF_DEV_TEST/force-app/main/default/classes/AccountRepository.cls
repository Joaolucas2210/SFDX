public with sharing class AccountRepository {
    public static List<Account> getAllAccounts() {
        if (!Schema.sObjectType.Account.isAccessible()) {
            throw new SecurityException('Acesso negado à leitura de Contas');
        }

        return [
            SELECT Id, Name, Industry, AnnualRevenue
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY CreatedDate DESC
            LIMIT 100
        ];
    }

    public static Account insertAccount(Account acc) {
        if (!Schema.sObjectType.Account.isCreateable()) {
            throw new SecurityException('Permissão de criação negada');
        }
        insert acc;
        return acc;
    }

    public static void deleteAccount(Id accountId) {
        if (!Schema.sObjectType.Account.isDeletable()) {
            throw new SecurityException('Permissão de exclusão negada');
        }
        delete [SELECT Id FROM Account WHERE Id = :accountId WITH SECURITY_ENFORCED];
    }
}