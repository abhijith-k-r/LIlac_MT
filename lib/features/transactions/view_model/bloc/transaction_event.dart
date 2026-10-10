import 'package:equatable/equatable.dart';
import 'package:lilac_mt/data/models/expense_model.dart';


abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactionsRequested extends TransactionEvent {
  const LoadTransactionsRequested();
}

class SaveTransactionRequested extends TransactionEvent {
  const SaveTransactionRequested(this.expense);

  final ExpenseModel expense;

  @override
  List<Object?> get props => [expense];
}

class UpdateTransactionRequested extends TransactionEvent {
  const UpdateTransactionRequested(this.expense);

  final ExpenseModel expense;

  @override
  List<Object?> get props => [expense];
}

class DeleteTransactionRequested extends TransactionEvent {
  const DeleteTransactionRequested(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
