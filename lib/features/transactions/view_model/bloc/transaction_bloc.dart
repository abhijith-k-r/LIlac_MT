import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_mt/data/models/expense_model.dart';
import 'package:lilac_mt/data/repositories/expense_repository.dart';


import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this._repository})
    : super(const TransactionInitial()) {
    on<LoadTransactionsRequested>(_onLoad);
    on<SaveTransactionRequested>(_onSave);
    on<UpdateTransactionRequested>(_onUpdate);
    on<DeleteTransactionRequested>(_onDelete);
  }

  final ExpenseRepository _repository;

  Future<void> _onLoad(
    LoadTransactionsRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    await _refresh(emit);
  }

  Future<void> _onSave(
    SaveTransactionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await _repository.addExpense(event.expense);
      await _refresh(emit);
    } catch (error) {
      emit(TransactionError(_message(error)));
    }
  }

  Future<void> _onUpdate(
    UpdateTransactionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await _repository.updateExpense(event.expense);
      await _refresh(emit);
    } catch (error) {
      emit(TransactionError(_message(error)));
    }
  }

  Future<void> _onDelete(
    DeleteTransactionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await _repository.deleteExpense(event.id);
      await _refresh(emit);
    } catch (error) {
      emit(TransactionError(_message(error)));
    }
  }

  Future<void> _refresh(Emitter<TransactionState> emit) async {
    try {
      final expenses = await _repository.getExpenses();
      final total = await _repository.getTotalExpenses();

      emit(
        TransactionLoaded(
          expenses: List<ExpenseModel>.unmodifiable(expenses),
          totalExpenses: total,
        ),
      );
    } catch (error) {
      emit(TransactionError(_message(error)));
    }
  }

  String _message(Object error) {
    return error is ArgumentError
        ? error.message.toString()
        : 'Something went wrong while accessing your expenses.';
  }
}
