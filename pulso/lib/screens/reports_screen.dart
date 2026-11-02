import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: const Text('Reportes'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: const Color(0xFF2C3E35)),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Semantics(label: 'Error al cargar reportes', child: Text('Error: $e'))),
        data: (summary) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Semantics(header: true, child: const Text('Resumen de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2C3E35)))),
            const SizedBox(height: 16),
            Semantics(label: 'Agua: ${summary.waterMl} mililitros', child: _Stat(label: 'Agua', value: '${summary.waterMl} ml')),
            Semantics(label: 'Cafeína: ${summary.caffeineCount} registros', child: _Stat(label: 'Cafeína', value: '${summary.caffeineCount}')),
            Semantics(label: 'Chatarra: ${summary.junkCount} registros', child: _Stat(label: 'Chatarra', value: '${summary.junkCount}')),
            Semantics(label: 'Dopamina: ${summary.dopamineCount} registros', child: _Stat(label: 'Dopamina', value: '${summary.dopamineCount}')),
            Semantics(label: 'Siestas: ${summary.napCount} registros', child: _Stat(label: 'Siestas', value: '${summary.napCount}')),
            const SizedBox(height: 24),
            Semantics(label: 'Los datos se guardan localmente en tu dispositivo', child: const Text('Los datos se guardan localmente en tu dispositivo.', style: TextStyle(color: Color(0xFF6B7A73), fontSize: 13))),
          ],
        ),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: const Color(0xFF2C3E35).withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4))]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: Color(0xFF2C3E35))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E35))),
      ]),
    );
  }
}
