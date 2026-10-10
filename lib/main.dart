import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_bloc.dart';
import 'package:lilac_mt/features/transactions/view_model/bloc/transaction_event.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/expense_repository.dart';
import 'features/splash/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RepositoryProvider(
      create: (_) => ExpenseRepository(),
      child: 
      BlocProvider(
        create: (context) =>
            TransactionBloc(repository: context.read<ExpenseRepository>())
              ..add(const LoadTransactionsRequested()
              ),
              
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenzia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
