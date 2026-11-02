import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_strings.dart';
import '../providers/home_provider.dart';
import '../services/foreground_service.dart';
import '../services/smart_coach.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return AppStrings.goodMorning;
    if (h < 19) return AppStrings.goodAfternoon;
    return AppStrings.goodEvening;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: SafeArea(
        child: summaryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppTheme.textSecondary),
                const SizedBox(height: 16),
                Text(AppStrings.errorLoading, style: const TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 12),
                TextButton(onPressed: () => ref.invalidate(todaySummaryProvider), child: Text(AppStrings.retry)),
              ],
            ),
          ),
          data: (summary) => ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
            children: [
              Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: AppTheme.textMain, borderRadius: BorderRadius.circular(14)),
                    child: const Center(child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                  ),
                  const SizedBox(width: 12),
                  Text(AppStrings.appName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.4, color: AppTheme.textMain)),
                ],
              ),
              const SizedBox(height: 8),
              Text(_greeting(), style: const TextStyle(color: AppTheme.textSecondary, fontSize: 15)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: AppTheme.textMain.withOpacity(0.05), blurRadius: 32, offset: const Offset(0, 8))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${summary.waterMl} ml', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                    const SizedBox(height: 6),
                    Text('${AppStrings.caffeine} ${summary.caffeineCount} · ${AppStrings.junk} ${summary.junkCount}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                    if (summary.waterMl == 0 && summary.caffeineCount == 0 && summary.junkCount == 0)
                      const Padding(padding: EdgeInsets.only(top: 8), child: Text(AppStrings.noRecordsToday, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12))),
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
                  _ActionTile(icon: Icons.water_drop_outlined, label: AppStrings.registerWater, onTap: () async {
                    await ref.read(homeRepositoryProvider).addWater(250);
                    ref.invalidate(todaySummaryProvider);
                  }),
                  _ActionTile(icon: Icons.local_drink_outlined, label: AppStrings.registerCoke, onTap: () async {
                    await ref.read(homeRepositoryProvider).addCaffeine();
                    ref.invalidate(todaySummaryProvider);
                    if (context.mounted) SmartCoach.onCaffeine(context, DateTime.now().hour);
                  }),
                  _ActionTile(icon: Icons.bed_outlined, label: AppStrings.registerNap, onTap: () {}),
                  _ActionTile(icon: Icons.fastfood_outlined, label: AppStrings.registerJunk, onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    await ForegroundService.start();
                    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio en segundo plano iniciado')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5E6DE),
                    foregroundColor: AppTheme.accentText,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(AppStrings.startSleep, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
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
      color: AppTheme.btnBg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppTheme.textMain, size: 26),
              const SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: AppTheme.textMain)),
            ],
          ),
        ),
      ),
    );
  }
}
