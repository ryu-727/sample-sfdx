@isTest
private class UpdateAccountSampleBatchTest {
  @isTest
  static void testBatchExecution() {
    // Create test data
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      Account acc = new Account(Name = 'Test Account ' + i, IsActive__c = true);
      accounts.add(acc);
    }
    insert accounts;

    // Start the batch job
    Test.startTest();
    UpdateAccountSampleBatch batch = new UpdateAccountSampleBatch();
    Database.executeBatch(batch);
    Test.stopTest();

    // Verify the results
    List<Account> updatedAccounts = [
      SELECT Name, Rating
      FROM Account
      WHERE IsActive__c = TRUE
    ];
    for (Account acc : updatedAccounts) {
      Assert.areEqual('Hot', acc.Rating, 'rating is true');
    }
  }
}
