import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lilac_mt/core/widgets/app_emptyspace.dart';
import 'package:lilac_mt/core/widgets/app_snackbar.dart';
import 'package:lilac_mt/data/models/expense_model.dart';
import 'package:lilac_mt/features/transactions/view/screens/transaction_form_screen.dart';
import 'package:lilac_mt/features/transactions/view/widgets/transaction_history_tile.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_event.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_state.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  Future<void> _edit(BuildContext context, ExpenseModel expense) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionFormScreen(expense: expense),
      ),
    );
  }

  Future<void> _delete(BuildContext context, ExpenseModel expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete expense?'),
        content: Text('Delete "${expense.title}" permanently?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted && expense.id != null) {
      context.read<TransactionBloc>().add(
        DeleteTransactionRequested(expense.id!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionError) {
            AppSnackbar.show(context, message: state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is TransactionInitial || state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionError) {
            return Center(
              child: FilledButton(
                onPressed: () => context.read<TransactionBloc>().add(
                  const LoadTransactionsRequested(),
                ),
                child: const Text('Retry'),
              ),
            );
          }

          if (state is! TransactionLoaded) {
            return const SizedBox.shrink();
          }

          if (state.expenses.isEmpty) {
            return const AppEmptyState(
              title: 'No transactions yet',
              message: 'Tap + to add your first expense.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: state.expenses.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) => TransactionHistoryTile(
              expense: state.expenses[index],
              onEdit: () => _edit(context, state.expenses[index]),
              onDelete: () => _delete(context, state.expenses[index]),
            ),
          );
        },
      ),
    );
  }
}


// !========
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:lilac_mt/core/widgets/app_emptyspace.dart';
// import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
// import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_event.dart';
// import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_state.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_spacing.dart';
// import '../../../../core/widgets/app_snackbar.dart';
// import '../../../../data/models/expense_model.dart';

// import 'transaction_form_screen.dart';

// class TransactionHistoryScreen extends StatelessWidget {
//   const TransactionHistoryScreen({super.key});

//   Future<void> _edit(BuildContext context, ExpenseModel expense) async {
//     await Navigator.of(context).push<bool>(
//       MaterialPageRoute(
//         builder: (_) => TransactionFormScreen(expense: expense),
//       ),
//     );
//   }

//   Future<void> _delete(BuildContext context, ExpenseModel expense) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Delete expense?'),
//         content: Text('Delete "${expense.title}" permanently?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, true),
//             child: const Text(
//               'Delete',
//               style: TextStyle(color: AppColors.error),
//             ),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true || !context.mounted) return;

//     context.read<TransactionBloc>().add(
//       DeleteTransactionRequested(expense.id!),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Transaction History')),
//       body: BlocConsumer<TransactionBloc, TransactionState>(
//         listener: (context, state) {
//           if (state is TransactionError) {
//             AppSnackbar.show(context, message: state.message, isError: true);
//           }
//         },
//         builder: (context, state) {
//           if (state is TransactionInitial || state is TransactionLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is TransactionError) {
//             return Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text('Unable to load transactions.'),
//                   const SizedBox(height: 12),
//                   FilledButton(
//                     onPressed: () {
//                       context.read<TransactionBloc>().add(
//                         const LoadTransactionsRequested(),
//                       );
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is! TransactionLoaded) {
//             return const SizedBox.shrink();
//           }

//           final expenses = state.expenses;

//           if (expenses.isEmpty) {
//             return const AppEmptyState(
//               title: 'No transactions yet',
//               message: 'Tap + to add your first expense.',
//             );
//           }

//           return ListView.separated(
//             padding: const EdgeInsets.all(AppSpacing.lg),
//             itemCount: expenses.length,
//             separatorBuilder: (_, _) => const Divider(height: 1),
//             itemBuilder: (context, index) {
//               final expense = expenses[index];

//               return ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: CircleAvatar(
//                   backgroundColor: AppColors.primary.withAlpha(25),
//                   child: const Icon(
//                     Icons.receipt_long_outlined,
//                     color: AppColors.primary,
//                   ),
//                 ),
//                 title: Text(expense.title),
//                 subtitle: Text(
//                   '${expense.category} • '
//                   '${DateFormat('dd MMM yyyy').format(expense.date)}',
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '- ₹${expense.amount.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         color: AppColors.expense,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     PopupMenuButton<String>(
//                       onSelected: (value) {
//                         if (value == 'edit') {
//                           _edit(context, expense);
//                         } else if (value == 'delete') {
//                           _delete(context, expense);
//                         }
//                       },
//                       itemBuilder: (_) => const [
//                         PopupMenuItem(value: 'edit', child: Text('Edit')),
//                         PopupMenuItem(value: 'delete', child: Text('Delete')),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
