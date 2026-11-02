import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';
import '../services/foreground_service.dart';
import '../services/smart_coach.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      body: SafeArea(
        child: summaryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Semantics(label: 'Error al cargar datos', child: Text('Error: $e'))),
          data: (summary) => ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
            children: [
              Semantics(
                header: true,
                child: Row(
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
              ),
              const SizedBox(height: 8),
              Semantics(label: 'Saludo del día', child: Text(_greeting(), style: const TextStyle(color: Color(0xFF6B7A73)))),
              const SizedBox(height: 20),
              Semantics(
                label: 'Agua consumida: ${summary.waterMl} mililitros. Cafeína: ${summary.caffeineCount}. Chatarra: ${summary.junkCount}',
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${summary.waterMl} ml', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('Cafeína ${summary.caffeineCount} · Chatarra ${summary.junkCount}', style: const TextStyle(color: Color(0xFF6B7A73))),
                    ],
                  ),
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
                  Semantics(button: true, label: 'Registrar 250 mililitros de agua', child: _ActionTile(icon: Icons.water_drop_outlined, label: 'Agua +250 ml', onTap: () async {
                    await ref.read(homeRepositoryProvider).addWater(250);
                    ref.invalidate(todaySummaryProvider);
                  })),
                  Semantics(button: true, label: 'Registrar Coca Zero o cafeína', child: _ActionTile(icon: Icons.local_drink_outlined, label: 'Registrar Coca', onTap: () async {
                    await ref.read(homeRepositoryProvider).addCaffeine();
                    ref.invalidate(todaySummaryProvider);
                    if (context.mounted) SmartCoach.onCaffeine(context, DateTime.now().hour);
                  })),
                  Semantics(button: true, label: 'Registrar siesta', child: _ActionTile(icon: Icons.bed_outlined, label: 'Registrar siesta', onTap: () {})),
                  Semantics(button: true, label: 'Registrar comida chatarra', child: _ActionTile(icon: Icons.fastfood_outlined, label: 'Registrar chatarra', onTap: () {})),
                ],
              ),
              const SizedBox(height: 24),
              Semantics(
                button: true,
                label: 'Iniciar modo sueño y servicio en segundo plano',
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ForegroundService.start();
                      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio en segundo plano iniciado')));
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
              ),
            ],
          ),
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
