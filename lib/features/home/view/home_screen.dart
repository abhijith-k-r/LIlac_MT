import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lilac_mt/core/widgets/app_emptyspace.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_state.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';

import '../../transactions/view/screens/transaction_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            final loaded = state is TransactionLoaded;
            final expenses = loaded ? state.expenses : [];
            final total = loaded ? state.totalExpenses : 0.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Good afternoon,',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const Text('Sahal Muhammed', style: AppTextStyles.title),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Expenses',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '₹ ${total.toStringAsFixed(2)}',
                          style: AppTextStyles.amount,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${expenses.length} transactions recorded',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _summary('TOTAL RECORDS', '${expenses.length}'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _summary(
                          'AVERAGE',
                          '₹ ${expenses.isEmpty ? '0.00' : (total / expenses.length).toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Recent Expenses', style: AppTextStyles.title),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TransactionHistoryScreen(),
                            ),
                          );
                        },
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  if (state is TransactionInitial ||
                      state is TransactionLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (state is TransactionError)
                    const AppEmptyState(
                      title: 'Unable to load expenses',
                      message: 'Please retry from transaction history.',
                    )
                  else if (expenses.isEmpty)
                    const AppEmptyState(
                      title: 'No expenses yet',
                      message: 'Tap + to add your first expense.',
                    )
                  else
                    ...expenses
                        .take(5)
                        .map(
                          (expense) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.receipt_long_outlined,
                              color: AppColors.primary,
                            ),
                            title: Text(expense.title),
                            subtitle: Text(
                              '${expense.category} • '
                              '${DateFormat('dd MMM').format(expense.date)}',
                            ),
                            trailing: Text(
                              '- ₹${expense.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.expense,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 70),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _summary(String title, String value) {
    return AppCard(
      padding: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.caption),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
