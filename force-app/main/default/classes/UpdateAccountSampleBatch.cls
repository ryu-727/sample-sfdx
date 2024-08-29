public class UpdateAccountSampleBatch implements Database.Batchable<SObject>, Database.Stateful {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [SELECT Id, Name FROM Account WHERE IsActive__c = TRUE]
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> scope) {
    for (Account acc : scope) {
      acc.Rating = 'Hot';
    }
    update scope;
  }

  // 完了メソッド
  public void finish(Database.BatchableContext bc) {
    System.debug('バッチ処理が完了しました。');
  }
}
