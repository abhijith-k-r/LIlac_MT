import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.onAddPressed,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primary,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.home_outlined, 0),
          _item(Icons.history, 1),
          const SizedBox(width: 48),
          _item(Icons.account_balance_wallet_outlined, 2),
          _item(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _item(IconData icon, int index) {
    final selected = currentIndex == index;

    return IconButton(
      tooltip: _label(index),
      onPressed: () => onDestinationSelected(index),
      icon: Icon(
        icon,
        size: 27,
        color: selected ? Colors.white : const Color(0xFF245D59),
      ),
    );
  }

  String _label(int index) => switch (index) {
    0 => 'Home',
    1 => 'History',
    2 => 'Credit',
    _ => 'Profile',
  };
}
