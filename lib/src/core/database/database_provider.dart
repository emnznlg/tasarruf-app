import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'database.dart';

part 'database_provider.g.dart';

@riverpod
// ignore: deprecated_member_use_from_same_package
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Future<List<Transaction>> build() async {
    final db = ref.watch(databaseProvider);
    return db.getAllTransactions();
  }

  Future<void> addTransaction(TransactionsCompanion transaction) async {
    final db = ref.read(databaseProvider);
    await db.addTransaction(transaction);
    ref.invalidateSelf();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final db = ref.read(databaseProvider);
    await db.updateTransaction(transaction);
    ref.invalidateSelf();
  }

  Future<void> deleteTransaction(int id) async {
    final db = ref.read(databaseProvider);
    await db.deleteTransaction(id);
    ref.invalidateSelf();
  }

  Future<void> deleteAllTransactions() async {
    final db = ref.read(databaseProvider);
    await db.deleteAllTransactions();
    ref.invalidateSelf();
  }

  Future<List<Transaction>> getTransactionsByDateRange(
      DateTime start, DateTime end) async {
    final db = ref.read(databaseProvider);
    return db.getTransactionsByDateRange(start, end);
  }
}
