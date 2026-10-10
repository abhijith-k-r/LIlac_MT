import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lilac_mt/core/constants/app_colors.dart';
import 'package:lilac_mt/data/models/expense_model.dart';

class TransactionHistoryTile extends StatelessWidget {
  const TransactionHistoryTile({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  final ExpenseModel expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withAlpha(25),
        child: const Icon(
          Icons.receipt_long_outlined,
          color: AppColors.primary,
        ),
      ),
      title: Text(expense.title),
      subtitle: Text(
        '${expense.category} • '
        '${DateFormat('dd MMM yyyy').format(expense.date)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '- ₹${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.expense,
              fontWeight: FontWeight.w600,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
