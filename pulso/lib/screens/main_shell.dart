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
  final _screens = <Widget?>[null, null, null, null];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _getScreen(int index) {
    return _screens[index] ??= switch (index) {
      0 => const HomeScreen(),
      1 => const DopamineScreen(),
      2 => const ReportsScreen(),
      3 => const SettingsScreen(),
      _ => const SizedBox.shrink(),
    };
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
  }

  void _onDestinationSelected(int index) {
    _getScreen(index);
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: List.generate(4, (i) => _getScreen(i)),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFF4F2EF),
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Color(0xFF8A8A8A), size: 22),
            selectedIcon: Icon(Icons.home, color: Color(0xFFD27D5E), size: 22),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined, color: Color(0xFF8A8A8A), size: 22),
            selectedIcon: Icon(Icons.bolt, color: Color(0xFFD27D5E), size: 22),
            label: 'Dopamina',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: Color(0xFF8A8A8A), size: 22),
            selectedIcon: Icon(Icons.bar_chart, color: Color(0xFFD27D5E), size: 22),
            label: 'Reportes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: Color(0xFF8A8A8A), size: 22),
            selectedIcon: Icon(Icons.settings, color: Color(0xFFD27D5E), size: 22),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
