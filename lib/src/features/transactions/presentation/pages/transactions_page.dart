import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasarruf/src/core/database/database.dart';
import 'package:tasarruf/src/core/database/database_provider.dart';
import 'package:tasarruf/src/features/transactions/presentation/pages/add_transaction_page.dart';
import 'package:tasarruf/src/features/transactions/presentation/pages/edit_transaction_page.dart';
import 'package:tasarruf/src/features/settings/presentation/pages/settings_page.dart';
import 'package:tasarruf/src/features/transactions/presentation/providers/date_range_provider.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionNotifierProvider);
    final dateRange = ref.watch(dateRangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('İşlemler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final now = DateTime.now();
              final firstDayOfMonth = DateTime(now.year, now.month, 1);
              final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDateRange: dateRange ??
                    DateTimeRange(
                      start: firstDayOfMonth,
                      end: lastDayOfMonth,
                    ),
                locale: const Locale('tr', 'TR'),
              );

              if (picked != null) {
                ref
                    .read(dateRangeNotifierProvider.notifier)
                    .setDateRange(picked);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          if (dateRange != null) {
            transactions = transactions.where((t) {
              return t.date.isAfter(
                      dateRange.start.subtract(const Duration(days: 1))) &&
                  t.date.isBefore(dateRange.end.add(const Duration(days: 1)));
            }).toList();
          }
          return TransactionsList(transactions: transactions);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Hata: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransactionsList extends ConsumerWidget {
  final List<Transaction> transactions;

  const TransactionsList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Henüz işlem bulunmamaktadır.'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTransactionPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('İşlem Ekle'),
            ),
          ],
        ),
      );
    }

    // Tarihe göre sıralama
    final sortedTransactions = List<Transaction>.from(transactions)
      ..sort((a, b) => a.date.compareTo(b.date));

    final totalExpenses = sortedTransactions
        .where((t) => t.isExpense)
        .fold(0.0, (sum, t) => sum + t.amount);
    final totalIncome = sortedTransactions
        .where((t) => !t.isExpense)
        .fold(0.0, (sum, t) => sum + t.amount);
    final balance = totalIncome - totalExpenses;

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Toplam Gelir:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '€${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Toplam Gider:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '€${totalExpenses.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Bakiye:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '€${balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: balance >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedTransactions.length,
            itemBuilder: (context, index) {
              final transaction = sortedTransactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Icon(
                    transaction.isExpense ? Icons.remove : Icons.add,
                    color: transaction.isExpense ? Colors.red : Colors.green,
                  ),
                  title: Text(transaction.description),
                  subtitle: Text(
                    DateFormat('d MMMM y', 'tr_TR').format(transaction.date),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '€${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color:
                              transaction.isExpense ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditTransactionPage(
                                  transaction: transaction,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: 18),
                          padding: EdgeInsets.zero,
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('İşlemi Sil'),
                                content: const Text(
                                  'Bu işlemi silmek istediğinize emin misiniz?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('İptal'),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      ref
                                          .read(transactionNotifierProvider
                                              .notifier)
                                          .deleteTransaction(transaction.id);
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('İşlem silindi'),
                                        ),
                                      );
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text('Sil'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
