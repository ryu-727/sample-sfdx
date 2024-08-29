public class UpdateAccountSampleBatch implements Database.Batchable<SObject>, Database.Stateful {
  // クエリメソッド
  public Database.QueryLocator start(Database.BatchableContext bc) {
    // アクティブな取引先レコードを取得するクエリ
    return Database.getQueryLocator(
      [SELECT Id, Name FROM Account WHERE IsActive__c = TRUE]
    );
  }

  // 処理メソッド
  public void execute(Database.BatchableContext bc, List<Account> scope) {
    // 取引先名の末尾に "- Processed" を追加
    for (Account acc : scope) {
      acc.Name += ' - Processed';
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
