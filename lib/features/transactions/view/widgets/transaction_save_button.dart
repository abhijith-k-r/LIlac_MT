// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:lilac_mt/core/widgets/app_button.dart';
// import 'package:lilac_mt/data/models/expense_model.dart';
// import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
// import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_event.dart';
// import 'package:lilac_mt/features/transactions/view_model/cubit/transaction_cubit.dart';
// import 'package:lilac_mt/features/transactions/view_model/cubit/transaction_state.dart';

// class TransactionSaveButton extends StatelessWidget {
//   const TransactionSaveButton({
//     super.key,
//     required this.expense,
//     required this.state,
//     required this.cubit,
//   });

//   final ExpenseModel? expense;
//   final TransactionFormState state;
//   final TransactionFormCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     return AppButton(
//       label: expense == null ? 'Save' : 'Update',
//       isLoading: state.isSaving,
//       onPressed: () {
//         if (state.isSaving || !cubit.validate()) return;

//         final current = cubit.state;
//         final amount = double.tryParse(current.amount.trim());
//         if (amount == null || amount <= 0 || !amount.isFinite) return;

//         final item = ExpenseModel(
//           id: expense?.id,
//           title: current.title.trim(),
//           amount: amount,
//           category: current.category,
//           date: current.date,
//           description: current.description.trim().isEmpty
//               ? null
//               : current.description.trim(),
//         );

//         cubit.saving(true);
//         context.read<TransactionBloc>().add(
//           expense == null
//               ? SaveTransactionRequested(item)
//               : UpdateTransactionRequested(item),
//         );
//       },
//     );
//   }
// }
