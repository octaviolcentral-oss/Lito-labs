import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('Reportes'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: AppTheme.textMain),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Semantics(label: 'Error al cargar reportes', child: Text('Error: $e'))),
        data: (summary) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          children: [
            Semantics(header: true, child: Text('Resumen de hoy', style: AppTheme.scaled(context, const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textMain)))),
            const SizedBox(height: 20),
            Semantics(label: 'Agua: ${summary.waterMl} mililitros', child: _Stat(label: 'Agua', value: '${summary.waterMl} ml')),
            Semantics(label: 'Cafeína: ${summary.caffeineCount} registros', child: _Stat(label: 'Cafeína', value: '${summary.caffeineCount}')),
            Semantics(label: 'Chatarra: ${summary.junkCount} registros', child: _Stat(label: 'Chatarra', value: '${summary.junkCount}')),
            Semantics(label: 'Dopamina: ${summary.dopamineCount} registros', child: _Stat(label: 'Dopamina', value: '${summary.dopamineCount}')),
            Semantics(label: 'Siestas: ${summary.napCount} registros', child: _Stat(label: 'Siestas', value: '${summary.napCount}')),
            const SizedBox(height: 28),
            Semantics(label: 'Los datos se guardan localmente en tu dispositivo', child: Text('Los datos se guardan localmente en tu dispositivo.', style: AppTheme.scaled(context, const TextStyle(color: AppTheme.textSecondary, fontSize: 13)))),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.textMain.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4))]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTheme.scaled(context, const TextStyle(color: AppTheme.textMain, fontSize: 15))),
        Text(value, style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain, fontSize: 15))),
      ]),
    );
  }
}
