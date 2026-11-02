import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
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
        error: (e, _) => Center(child: Semantics(label: 'Error al cargar ajustes', child: Text('Error: $e'))),
        data: (repo) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          children: [
            Semantics(header: true, child: Text('Privacidad', style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontSize: 13)))),
            const SizedBox(height: 12),
            Semantics(label: 'Bloqueo de Dopamina. Pide PIN para entrar a Dopamina', child: _ToggleTile(
              title: 'Bloqueo de Dopamina',
              subtitle: 'Pide PIN para entrar a Dopamina',
              initial: false,
              onChanged: (v) => repo.setDopamineLock(v),
            )),
            Semantics(label: 'Modo Discreto. Oculta números de agua y cafeína', child: _ToggleTile(
              title: 'Modo Discreto',
              subtitle: 'Oculta números de agua y cafeína',
              initial: false,
              onChanged: (v) => repo.setDiscreteMode(v),
            )),
            const SizedBox(height: 28),
            Semantics(header: true, child: Text('Smart Coach', style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontSize: 13)))),
            const SizedBox(height: 12),
            Semantics(label: 'Consejos Inteligentes. Muestra toasts de recomendaciones', child: _ToggleTile(
              title: 'Consejos Inteligentes',
              subtitle: 'Muestra toasts de recomendaciones',
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
        title: Text(widget.title, style: AppTheme.scaled(context, const TextStyle(color: AppTheme.textMain, fontSize: 15))),
        subtitle: Text(widget.subtitle, style: AppTheme.scaled(context, const TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
        value: _value,
        onChanged: (v) { setState(() => _value = v); widget.onChanged(v); },
        activeColor: AppTheme.accent,
      ),
    );
  }
}
