import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dopamine_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    DopamineScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFF4F2EF),
        height: 72,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Color(0xFF8A8A8A)),
            selectedIcon: Icon(Icons.home, color: Color(0xFFD27D5E)),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined, color: Color(0xFF8A8A8A)),
            selectedIcon: Icon(Icons.bolt, color: Color(0xFFD27D5E)),
            label: 'Dopamina',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: Color(0xFF8A8A8A)),
            selectedIcon: Icon(Icons.bar_chart, color: Color(0xFFD27D5E)),
            label: 'Reportes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: Color(0xFF8A8A8A)),
            selectedIcon: Icon(Icons.settings, color: Color(0xFFD27D5E)),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
