import 'package:flutter/material.dart';
import '../services/database_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int water = 0;
  int caffeine = 0;
  int junk = 0;
  int dopamine = 0;
  int naps = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = DatabaseService.instance;
    final w = await db.getWaterTotal();
    final c = await db.getCount('caffeine');
    final j = await db.getCount('junk');
    final d = await db.getCount('dopamine');
    final n = await db.getCount('nap');
    if (mounted) {
      setState(() {
        water = w; caffeine = c; junk = j; dopamine = d; naps = n;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: const Text('Reportes'), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Resumen de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _StatCard(label: 'Agua', value: '$water ml'),
          _StatCard(label: 'Cafeína', value: '$caffeine'),
          _StatCard(label: 'Chatarra', value: '$junk'),
          _StatCard(label: 'Dopamina', value: '$dopamine'),
          _StatCard(label: 'Siestas', value: '$naps'),
          const SizedBox(height: 24),
          const Text('Los datos se guardan localmente en tu dispositivo.', style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E6DE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
