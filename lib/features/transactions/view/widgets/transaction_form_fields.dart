// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:lilac_mt/core/constants/app_spacing.dart';
// import 'package:lilac_mt/core/widgets/app_card.dart';
// import 'package:lilac_mt/core/utils/app_date_picker.dart';
// import 'package:lilac_mt/features/transactions/view_model/cubit/transaction_cubit.dart';
// import 'package:lilac_mt/features/transactions/view_model/cubit/transaction_state.dart';

// class TransactionFormFields extends StatelessWidget {
//   const TransactionFormFields({
//     super.key,
//     required this.state,
//     required this.cubit,
//   });

//   final TransactionFormState state;
//   final TransactionFormCubit cubit;

//   static const categories = [
//     'Food',
//     'Transport',
//     'Shopping',
//     'Bills',
//     'Entertainment',
//     'Health',
//     'Other',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return AppCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('NAME'),
//           const SizedBox(height: 8),
//           TextFormField(
//             initialValue: cubit.state.title,
//             decoration: InputDecoration(
//               labelText: 'Expense title',
//               errorText: state.titleError,
//             ),
//             onChanged: cubit.titleChanged,
//           ),
//           const SizedBox(height: AppSpacing.md),
//           const Text('AMOUNT'),
//           const SizedBox(height: 8),
//           TextFormField(
//             initialValue: cubit.state.amount,
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             decoration: InputDecoration(
//               labelText: 'Amount',
//               prefixText: '₹ ',
//               errorText: state.amountError,
//             ),
//             onChanged: cubit.amountChanged,
//           ),
//           const SizedBox(height: AppSpacing.md),
//           const Text('CATEGORY'),
//           DropdownButtonFormField<String>(
//             initialValue: state.category,
//             items: categories
//                 .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) cubit.categoryChanged(value);
//             },
//           ),
//           const SizedBox(height: AppSpacing.md),
//           const Text('DATE'),
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             title: Text(DateFormat('EEE, dd MMM yyyy').format(state.date)),
//             trailing: const Icon(Icons.calendar_month),
//             onTap: () async {
//               final date = await AppDatePicker.pick(
//                 context,
//                 initialDate: state.date,
//               );
//               if (date != null) cubit.dateChanged(date);
//             },
//           ),
//           const SizedBox(height: 8),
//           const Text('DESCRIPTION (OPTIONAL)'),
//           TextFormField(
//             initialValue: cubit.state.description,
//             maxLines: 3,
//             decoration: const InputDecoration(labelText: 'Description'),
//             onChanged: cubit.descriptionChanged,
//           ),
//           if (state.errorMessage != null) ...[
//             const SizedBox(height: 8),
//             Text(
//               state.errorMessage!,
//               style: const TextStyle(color: Colors.red),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
