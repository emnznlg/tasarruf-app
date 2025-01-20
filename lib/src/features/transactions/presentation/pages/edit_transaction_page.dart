import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasarruf/src/core/database/database.dart';
import 'package:tasarruf/src/core/database/database_provider.dart';
import 'package:intl/intl.dart';

class EditTransactionPage extends ConsumerStatefulWidget {
  final Transaction transaction;

  const EditTransactionPage({
    super.key,
    required this.transaction,
  });

  @override
  ConsumerState<EditTransactionPage> createState() =>
      _EditTransactionPageState();
}

class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  late bool _isExpense;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.transaction.description);
    _amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    _isExpense = widget.transaction.isExpense;
    _selectedDate = widget.transaction.date;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _updateTransaction() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text.replaceAll(',', '.'));
      final updatedTransaction = widget.transaction.copyWith(
        amount: amount,
        description: _descriptionController.text,
        date: _selectedDate,
        isExpense: _isExpense,
      );

      ref
          .read(transactionNotifierProvider.notifier)
          .updateTransaction(updatedTransaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşlemi Düzenle'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Harcama'),
                  icon: Icon(Icons.remove),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Para Girişi'),
                  icon: Icon(Icons.add),
                ),
              ],
              selected: {_isExpense},
              onSelectionChanged: (Set<bool> newSelection) {
                setState(() {
                  _isExpense = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
                prefixText: '€ ',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d*')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir miktar girin';
                }
                if (double.tryParse(value.replaceAll(',', '.')) == null) {
                  return 'Geçerli bir sayı girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir açıklama girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                DateFormat('d MMMM y', 'tr_TR').format(_selectedDate),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _updateTransaction,
              icon: const Icon(Icons.save),
              label: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
