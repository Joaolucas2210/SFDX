@isTest
private class AccountServiceTest {
    @isTest
    static void testSecurityViolation() {
        User u = [SELECT Id FROM User WHERE Profile.Name = 'Standard User' LIMIT 1];

        System.runAs(u) {
            Test.startTest();
            try {
                AccountService.getAccounts();
                System.assert(false, 'Deveria lançar exceção de segurança');
            } catch (AuraHandledException e) {
                System.assert(e.getMessage().contains('Acesso negado'));
            }
            Test.stopTest();
        }
    }
}