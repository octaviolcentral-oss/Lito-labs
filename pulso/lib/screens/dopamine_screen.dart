import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class DopamineScreen extends ConsumerStatefulWidget {
  const DopamineScreen({super.key});

  @override
  ConsumerState<DopamineScreen> createState() => _DopamineScreenState();
}

class _DopamineScreenState extends ConsumerState<DopamineScreen> {
  String? _time;
  String? _feeling;
  final _other = TextEditingController();
  bool _saving = false;

  Future<void> _save() async {
    if (_time == null || _feeling == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona hora y cómo te sentías')));
      return;
    }
    setState(() => _saving = true);
    final feeling = _feeling == 'Otro' ? _other.text : _feeling!;
    await ref.read(dopamineRepositoryProvider).save(_time!, feeling);
    if (mounted) {
      setState(() { _saving = false; _time = null; _feeling = null; _other.clear(); });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro guardado')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('Dopamina'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: AppTheme.textMain),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
        children: [
          Semantics(label: 'Registro privado para medir picos de dopamina y regulación sensorial', child: Text('Registro privado para medir picos de dopamina y regulación sensorial', style: AppTheme.scaled(context, const TextStyle(color: AppTheme.textSecondary, fontSize: 13)))),
          const SizedBox(height: 28),
          Text('¿A qué hora fue?', style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 15))),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: ['Mañana', 'Tarde', 'Noche'].map((t) => Semantics(button: true, label: 'Hora: $t', child: ChoiceChip(
            label: Text(t), selected: _time == t,
            onSelected: (_) => setState(() => _time = t),
            selectedColor: const Color(0xFFF4E3DC),
            backgroundColor: AppTheme.btnBg,
            labelStyle: TextStyle(color: _time == t ? AppTheme.accentText : AppTheme.textMain, fontSize: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ))).toList()),
          const SizedBox(height: 28),
          Text('¿Cómo te sentías antes?', style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 15))),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: ['Aburrido', 'Ansioso', 'Estresado', 'Otro'].map((f) => Semantics(button: true, label: 'Estado: $f', child: ChoiceChip(
            label: Text(f), selected: _feeling == f,
            onSelected: (_) => setState(() => _feeling = f),
            selectedColor: const Color(0xFFF4E3DC),
            backgroundColor: AppTheme.btnBg,
            labelStyle: TextStyle(color: _feeling == f ? AppTheme.accentText : AppTheme.textMain, fontSize: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ))).toList()),
          if (_feeling == 'Otro') ...[
            const SizedBox(height: 16),
            Semantics(label: 'Campo para describir cómo te sentías', child: TextField(controller: _other, decoration: InputDecoration(hintText: 'Escribe cómo te sentías...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: Colors.white))),
          ],
          const SizedBox(height: 36),
          Semantics(button: true, label: 'Guardar registro de dopamina', child: ElevatedButton(
            onPressed: _saving ? null : _save,
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
            child: _saving ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text('Registrar', style: AppTheme.scaled(context, const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
          )),
        ],
      ),
    );
  }
}
