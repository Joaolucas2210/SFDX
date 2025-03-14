@isTest
private class AccountControllerTest {
    @TestSetup
    static void setup() {
        insert new Account(
            Name = 'Test Account',
            Industry = 'Technology',
            AnnualRevenue = 1000000
        );
    }

    @isTest
    static void testGetAccounts() {
        Test.startTest();
        List<Account> accounts = AccountController.getAccounts();
        System.assert(!accounts.isEmpty(), 'Deveria retornar contas');
        Test.stopTest();
    }


    @isTest
    static void testCreateAccount() {
        Test.startTest();
        Account acc = AccountController.createAccount('Test', 'Tech', 100000);
        System.assert(acc.Id != null, 'Deveria criar conta');
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccount() {
        Account acc = new Account(Name = 'Test Delete');
        insert acc;

        Test.startTest();
        AccountController.deleteAccount(acc.Id);
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :acc.Id];
        System.assert(accounts.isEmpty(), 'Deveria excluir conta');
        Test.stopTest();
    }

}