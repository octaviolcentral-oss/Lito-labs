import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_strings.dart';
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
              Semantics(label: AppStrings.errorLoading, child: Text(AppStrings.errorLoading, style: const TextStyle(color: AppTheme.textSecondary))),
              const SizedBox(height: 12),
              Semantics(button: true, label: AppStrings.retry, child: TextButton(onPressed: () => ref.invalidate(todaySummaryProvider), child: Text(AppStrings.retry))),
            ],
          ),
        ),
        data: (summary) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          children: [
            Semantics(header: true, child: const Text('Resumen de hoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textMain))),
            const SizedBox(height: 20),
            if (summary.waterMl == 0 && summary.caffeineCount == 0 && summary.junkCount == 0 && summary.dopamineCount == 0 && summary.napCount == 0)
              Semantics(label: AppStrings.noRecordsToday, child: const Padding(padding: EdgeInsets.only(bottom: 16), child: Text(AppStrings.noRecordsToday, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)))),
            Semantics(label: '${AppStrings.water}: ${summary.waterMl} mililitros', child: _Stat(label: AppStrings.water, value: '${summary.waterMl} ml')),
            Semantics(label: '${AppStrings.caffeine}: ${summary.caffeineCount}', child: _Stat(label: AppStrings.caffeine, value: '${summary.caffeineCount}')),
            Semantics(label: '${AppStrings.junk}: ${summary.junkCount}', child: _Stat(label: AppStrings.junk, value: '${summary.junkCount}')),
            Semantics(label: '${AppStrings.dopamine}: ${summary.dopamineCount}', child: _Stat(label: AppStrings.dopamine, value: '${summary.dopamineCount}')),
            Semantics(label: '${AppStrings.naps}: ${summary.napCount}', child: _Stat(label: AppStrings.naps, value: '${summary.napCount}')),
            const SizedBox(height: 28),
            Semantics(label: AppStrings.dataSavedLocally, child: const Text(AppStrings.dataSavedLocally, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13))),
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
