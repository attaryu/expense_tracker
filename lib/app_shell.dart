import 'package:expense_tracker/screens/add_transaction_screen.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  static const List<Widget> _screens = [
    Center(child: Text('Home Screen')),
    Center(child: Text('History Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      backgroundColor: Colors.black.withValues(alpha: 0.1),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          iconSize: 26,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
