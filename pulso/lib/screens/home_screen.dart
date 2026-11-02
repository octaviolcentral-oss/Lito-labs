import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/foreground_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int water = 0;
  int caffeine = 0;
  int junk = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = DatabaseService.instance;
    setState(() {
      water = 0; // will be updated
      caffeine = 0;
      junk = 0;
    });
    final w = await db.getWaterTotal();
    final c = await db.getCount('caffeine');
    final j = await db.getCount('junk');
    if (mounted) {
      setState(() {
        water = w;
        caffeine = c;
        junk = j;
      });
    }
  }

  Future<void> _addWater() async {
    await DatabaseService.instance.insertRecord('water', value: '250');
    await _load();
  }

  Future<void> _addCaffeine() async {
    await DatabaseService.instance.insertRecord('caffeine');
    await _load();
  }

  Future<void> _startSleep() async {
    await ForegroundService.start();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Servicio en segundo plano iniciado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Pulso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$water ml', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Cafeína $caffeine · Chatarra $junk', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _ActionCard(label: 'Agua +250 ml', onTap: _addWater),
                  _ActionCard(label: 'Registrar Coca', onTap: _addCaffeine),
                  _ActionCard(label: 'Registrar siesta', onTap: () {}),
                  _ActionCard(label: 'Registrar chatarra', onTap: () {}),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _startSleep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5E6DE),
                  foregroundColor: const Color(0xFFA14D2F),
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Iniciar modo sueño'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ActionCard({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F2EF),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(child: Text(label, textAlign: TextAlign.center)),
      ),
    );
  }
}
