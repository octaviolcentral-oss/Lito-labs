import 'package:flutter/material.dart';
import '../features/home/data/home_repository_impl.dart';
import '../features/home/domain/entities/daily_summary.dart';
import '../services/database_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late final HomeRepositoryImpl _repo;
  DailySummary _summary = DailySummary.empty;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _repo = HomeRepositoryImpl(DatabaseService.instance);
    _load();
  }

  Future<void> _load() async {
    final s = await _repo.getTodaySummary();
    if (mounted) setState(() { _summary = s; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: const Text('Reportes'), backgroundColor: Colors.transparent, elevation: 0),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Resumen de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                _Stat(label: 'Agua', value: '${_summary.waterMl} ml'),
                _Stat(label: 'Cafeína', value: '${_summary.caffeineCount}'),
                _Stat(label: 'Chatarra', value: '${_summary.junkCount}'),
                _Stat(label: 'Dopamina', value: '${_summary.dopamineCount}'),
                _Stat(label: 'Siestas', value: '${_summary.napCount}'),
                const SizedBox(height: 24),
                const Text('Los datos se guardan localmente en tu dispositivo.', style: TextStyle(color: Color(0xFF6B7A73), fontSize: 13)),
              ],
            ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(color: const Color(0xFFF5E6DE), borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
