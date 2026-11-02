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
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppTheme.textSecondary),
              const SizedBox(height: 16),
              const Text('No se pudieron cargar los reportes', style: TextStyle(color: AppTheme.textSecondary)),
              const SizedBox(height: 12),
              TextButton(onPressed: () => ref.invalidate(todaySummaryProvider), child: const Text('Reintentar')),
            ],
          ),
        ),
        data: (summary) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          children: [
            const Text('Resumen de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textMain)),
            const SizedBox(height: 20),
            if (summary.waterMl == 0 && summary.caffeineCount == 0 && summary.junkCount == 0 && summary.dopamineCount == 0 && summary.napCount == 0)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text('Aún no hay registros hoy', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              ),
            _Stat(label: 'Agua', value: '${summary.waterMl} ml'),
            _Stat(label: 'Cafeína', value: '${summary.caffeineCount}'),
            _Stat(label: 'Chatarra', value: '${summary.junkCount}'),
            _Stat(label: 'Dopamina', value: '${summary.dopamineCount}'),
            _Stat(label: 'Siestas', value: '${summary.napCount}'),
            const SizedBox(height: 28),
            const Text('Los datos se guardan localmente en tu dispositivo.', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
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
        Text(label, style: const TextStyle(color: AppTheme.textMain, fontSize: 15)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain, fontSize: 15)),
      ]),
    );
  }
}
