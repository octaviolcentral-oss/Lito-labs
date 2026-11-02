import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsRepositoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: const Text('Ajustes'), backgroundColor: Colors.transparent, elevation: 0),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Semantics(label: 'Error al cargar ajustes', child: Text('Error: $e'))),
        data: (repo) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Semantics(header: true, child: const Text('Privacidad', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF6B7A73)))),
            const SizedBox(height: 8),
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
            const SizedBox(height: 24),
            Semantics(header: true, child: const Text('Smart Coach', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF6B7A73)))),
            const SizedBox(height: 8),
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
    return SwitchListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7A73))),
      value: _value,
      onChanged: (v) { setState(() => _value = v); widget.onChanged(v); },
      activeColor: const Color(0xFFD27D5E),
    );
  }
}
