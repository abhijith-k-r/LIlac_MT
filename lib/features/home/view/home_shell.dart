import 'package:flutter/material.dart';
import 'package:lilac_mt/features/credits/view/credit_screen.dart';
import 'package:lilac_mt/features/home/view/home_screen.dart';
import 'package:lilac_mt/features/profile/view/profile_screen.dart';
import 'package:lilac_mt/features/transactions/view/screens/transaction_form_screen.dart';
import 'package:lilac_mt/features/transactions/view/screens/transaction_history_screen.dart';
import '../../../../core/widgets/app_bottom_navbar.dart';


class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    TransactionHistoryScreen(),
    CreditScreen(),
    ProfileScreen(),
  ];

  Future<void> _openAddTransaction() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const TransactionFormScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransaction,
        backgroundColor: const Color(0xFF3D8983),
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 5),
        ),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavbar(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        onAddPressed: _openAddTransaction,
      ),
    );
  }
}
