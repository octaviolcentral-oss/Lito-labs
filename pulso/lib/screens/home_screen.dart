import 'package:flutter/material.dart';
import '../features/home/data/home_repository_impl.dart';
import '../features/home/domain/entities/daily_summary.dart';
import '../services/database_service.dart';
import '../services/foreground_service.dart';
import '../services/smart_coach.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeRepositoryImpl _repo;
  DailySummary _summary = DailySummary.empty;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repo = HomeRepositoryImpl(DatabaseService.instance);
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final s = await _repo.getTodaySummary();
      if (mounted) setState(() { _summary = s; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = 'No se pudo cargar'; _loading = false; });
    }
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  Future<void> _addWater() async {
    await _repo.addWater(250);
    await _load();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agua registrada')));
  }

  Future<void> _addCaffeine() async {
    await _repo.addCaffeine();
    await _load();
    if (mounted) SmartCoach.onCaffeine(context, DateTime.now().hour);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : ListView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: const Color(0xFF2C3E35), borderRadius: BorderRadius.circular(12)),
                            child: const Center(child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(width: 12),
                          const Text('Pulso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_greeting, style: const TextStyle(color: Color(0xFF6B7A73))),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_summary.waterMl} ml', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text('Cafeína ${_summary.caffeineCount} · Chatarra ${_summary.junkCount}', style: const TextStyle(color: Color(0xFF6B7A73))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.15,
                        children: [
                          _ActionTile(icon: Icons.water_drop_outlined, label: 'Agua +250 ml', onTap: _addWater),
                          _ActionTile(icon: Icons.local_drink_outlined, label: 'Registrar Coca', onTap: _addCaffeine),
                          _ActionTile(icon: Icons.bed_outlined, label: 'Registrar siesta', onTap: () {}),
                          _ActionTile(icon: Icons.fastfood_outlined, label: 'Registrar chatarra', onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ForegroundService.start();
                            if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio en segundo plano iniciado')));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5E6DE),
                            foregroundColor: const Color(0xFFA14D2F),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('Iniciar modo sueño'),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F2EF),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF2C3E35)),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
