public with sharing class AccountController {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return AccountService.getAccounts();
    }

    @AuraEnabled
    public static Account createAccount(String name, String industry, Decimal annualRevenue) {
        return AccountService.createAccount(name, industry, annualRevenue);
    }

    @AuraEnabled
    public static Boolean deleteAccount(Id accountId) {
        return AccountService.deleteAccount(accountId);
    }
}