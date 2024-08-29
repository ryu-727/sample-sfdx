public class UpdateAccountSampleBatch implements Database.Batchable<SObject>, Database.Stateful {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [SELECT Id, Name FROM Account WHERE Rating = 'Hot']
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> scope) {
    // 取引先名の末尾に "- Hot" を追加
    for (Account acc : scope) {
      acc.Name += ' - Hot';
    }
    // 取引先レコードを更新
    update scope;
  }

  // 完了メソッド
  public void finish(Database.BatchableContext bc) {
    // バッチ処理完了後の後処理、例えばログの記録や通知など
    System.debug('バッチ処理が完了しました。');
  }
}
