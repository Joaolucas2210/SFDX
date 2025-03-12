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
}