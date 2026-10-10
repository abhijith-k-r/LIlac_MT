// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lilac_mt/core/constants/app_spacing.dart';
import 'package:lilac_mt/core/utils/app_date_picker.dart';
import 'package:lilac_mt/core/utils/validators.dart';
import 'package:lilac_mt/core/widgets/app_button.dart';
import 'package:lilac_mt/core/widgets/app_card.dart';
import 'package:lilac_mt/core/widgets/app_snackbar.dart';
import 'package:lilac_mt/core/widgets/app_text_field.dart';
import 'package:lilac_mt/data/models/expense_model.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_event.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_state.dart';


class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key, this.expense});

  final ExpenseModel? expense;

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  late String _category;
  late DateTime _date;
  bool _isSaving = false;

  final _categories = const [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    final expense = widget.expense;
    _titleController = TextEditingController(text: expense?.title ?? '');
    _amountController = TextEditingController(
      text: expense?.amount.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: expense?.description ?? '',
    );

    _category = expense?.category ?? 'Food';
    _date = expense?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await AppDatePicker.pick(context, initialDate: _date);

    if (picked != null && mounted) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || !amount.isFinite || amount <= 0) return;

    final expense = ExpenseModel(
      id: widget.expense?.id,
      title: _titleController.text.trim(),
      amount: amount,
      category: _category,
      date: _date,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    setState(() => _isSaving = true);

    try {
      final bloc = context.read<TransactionBloc>();

      if (widget.expense == null) {
        bloc.add(SaveTransactionRequested(expense));
      } else {
        bloc.add(UpdateTransactionRequested(expense));
      }

      // Wait for this operation's resulting state.
      final result = await bloc.stream.firstWhere(
        (state) => state is TransactionLoaded || state is TransactionError,
      );

      if (!mounted) return;

      if (result is TransactionLoaded) {
        Navigator.of(context).pop(true);
      } else if (result is TransactionError) {
        AppSnackbar.show(context, message: result.message, isError: true);
      }

      // Avoid an unused-variable warning; the operation is handled
      // by the BLoC regardless of the previous state.
    } catch (_) {
      if (mounted) {
        AppSnackbar.show(
          context,
          message: 'Unable to save the expense. Please try again.',
          isError: true,
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.expense == null ? 'Transaction' : 'Edit Transaction',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NAME'),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _titleController,
                      label: 'Expense title',
                      validator: (value) =>
                          Validators.requiredField(value, fieldName: 'Title'),
                    ),
                    const SizedBox(height: 16),
                    const Text('AMOUNT'),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _amountController,
                      label: 'Amount',
                      prefixText: '₹ ',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: Validators.positiveAmount,
                    ),
                    const SizedBox(height: 16),
                    const Text('CATEGORY'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: const InputDecoration(),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _category = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('DATE'),
                    OutlinedButton(
                      onPressed: _pickDate,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat('EEE, dd MMM yyyy').format(_date),
                            ),
                          ),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                 
                  
                  ],
                ),
              ),
              const SizedBox(height: 28),
              AppButton(
                label: widget.expense == null ? 'Save' : 'Update',
                isLoading: _isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}





