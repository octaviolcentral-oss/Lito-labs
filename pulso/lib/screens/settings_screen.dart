import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_strings.dart';
import '../providers/home_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsRepositoryProvider);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('Ajustes'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: AppTheme.textMain),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppTheme.textSecondary),
              const SizedBox(height: 16),
              Semantics(label: AppStrings.errorLoading, child: Text(AppStrings.errorLoading, style: const TextStyle(color: AppTheme.textSecondary))),
              const SizedBox(height: 12),
              Semantics(button: true, label: AppStrings.retry, child: TextButton(onPressed: () => ref.invalidate(settingsRepositoryProvider), child: Text(AppStrings.retry))),
            ],
          ),
        ),
        data: (repo) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          children: [
            Semantics(header: true, child: Text(AppStrings.privacy, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontSize: 13))),
            const SizedBox(height: 12),
            Semantics(label: '${AppStrings.dopamineLock}. ${AppStrings.dopamineLockSub}', child: _ToggleTile(
              title: AppStrings.dopamineLock,
              subtitle: AppStrings.dopamineLockSub,
              initial: false,
              onChanged: (v) => repo.setDopamineLock(v),
            )),
            Semantics(label: '${AppStrings.discreteMode}. ${AppStrings.discreteModeSub}', child: _ToggleTile(
              title: AppStrings.discreteMode,
              subtitle: AppStrings.discreteModeSub,
              initial: false,
              onChanged: (v) => repo.setDiscreteMode(v),
            )),
            const SizedBox(height: 28),
            Semantics(header: true, child: Text(AppStrings.smartCoach, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontSize: 13))),
            const SizedBox(height: 12),
            Semantics(label: '${AppStrings.smartCoach}. ${AppStrings.smartCoachSub}', child: _ToggleTile(
              title: AppStrings.smartCoach,
              subtitle: AppStrings.smartCoachSub,
              initial: true,
              onChanged: (v) => repo.setSmartCoach(v),
            )),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initial;
  final ValueChanged<bool> onChanged;
  const _ToggleTile({required this.title, required this.subtitle, required this.initial, required this.onChanged});

  @override
  State<_ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<_ToggleTile> {
  late bool _value;
  @override
  void initState() { super.initState(); _value = widget.initial; }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SwitchListTile(
        title: Text(widget.title, style: const TextStyle(color: AppTheme.textMain, fontSize: 15)),
        subtitle: Text(widget.subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        value: _value,
        onChanged: (v) { setState(() => _value = v); widget.onChanged(v); },
        activeColor: AppTheme.accent,
      ),
    );
  }
}
