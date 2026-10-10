import 'package:equatable/equatable.dart';
import 'package:lilac_mt/data/models/expense_model.dart';


abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionLoaded extends TransactionState {
  const TransactionLoaded({
    required this.expenses,
    required this.totalExpenses,
  });

  final List<ExpenseModel> expenses;
  final double totalExpenses;

  @override
  List<Object?> get props => [expenses, totalExpenses];
}

class TransactionError extends TransactionState {
  const TransactionError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
