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
}