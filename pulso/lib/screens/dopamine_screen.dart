import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_strings.dart';
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
    ref.invalidate(todaySummaryProvider);
    if (mounted) {
      setState(() { _saving = false; _time = null; _feeling = null; _other.clear(); });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro guardado')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text(AppStrings.dopamine), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: AppTheme.textMain),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 100),
        children: [
          Semantics(label: AppStrings.dopaminePrivate, child: const Text(AppStrings.dopaminePrivate, style: TextStyle(color: AppTheme.textSecondary, fontSize: 14))),
          const SizedBox(height: 32),
          Semantics(header: true, child: const Text(AppStrings.whatTime, style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 16))),
          const SizedBox(height: 14),
          Wrap(spacing: 10, children: ['Mañana', 'Tarde', 'Noche'].map((t) => Semantics(button: true, label: 'Hora: $t', selected: _time == t, child: ChoiceChip(
            label: Text(t), selected: _time == t,
            onSelected: (_) => setState(() => _time = t),
            selectedColor: const Color(0xFFF4E3DC),
            backgroundColor: AppTheme.btnBg,
            labelStyle: TextStyle(color: _time == t ? AppTheme.accentText : AppTheme.textMain, fontSize: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ))).toList()),
          const SizedBox(height: 32),
          Semantics(header: true, child: const Text(AppStrings.howFelt, style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 16))),
          const SizedBox(height: 14),
          Wrap(spacing: 10, runSpacing: 10, children: ['Aburrido', 'Ansioso', 'Estresado', 'Otro'].map((f) => Semantics(button: true, label: 'Estado: $f', selected: _feeling == f, child: ChoiceChip(
            label: Text(f), selected: _feeling == f,
            onSelected: (_) => setState(() => _feeling = f),
            selectedColor: const Color(0xFFF4E3DC),
            backgroundColor: AppTheme.btnBg,
            labelStyle: TextStyle(color: _feeling == f ? AppTheme.accentText : AppTheme.textMain, fontSize: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ))).toList()),
          if (_feeling == 'Otro') ...[
            const SizedBox(height: 18),
            Semantics(label: 'Campo para describir cómo te sentías', child: TextField(controller: _other, decoration: InputDecoration(hintText: 'Escribe cómo te sentías...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)))),
          ],
          const SizedBox(height: 40),
          Semantics(button: true, label: AppStrings.register, child: ElevatedButton(
            onPressed: _saving ? null : _save,
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), elevation: 0),
            child: _saving ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text(AppStrings.register, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          )),
        ],
      ),
    );
  }
}
