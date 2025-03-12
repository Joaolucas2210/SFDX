public with sharing class AccountService {
    public static List<Account> getAccounts() {
        try {
            return AccountRepository.getAllAccounts();
        } catch (Exception e) {
            throw new AuraHandledException('Erro de serviço: ' + e.getMessage());
        }
    }
}