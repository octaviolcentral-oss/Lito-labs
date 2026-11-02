import 'package:flutter/material.dart';
import '../services/database_service.dart';

class DopamineScreen extends StatefulWidget {
  const DopamineScreen({super.key});

  @override
  State<DopamineScreen> createState() => _DopamineScreenState();
}

class _DopamineScreenState extends State<DopamineScreen> {
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
    final feeling = _feeling == 'Otro' ? _other.text : _feeling;
    await DatabaseService.instance.insertRecord('dopamine', value: '$_time|$feeling');
    if (mounted) {
      setState(() { _saving = false; _time = null; _feeling = null; _other.clear(); });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro guardado')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: const Text('Dopamina'), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Registro privado para medir picos de dopamina y regulación sensorial', style: TextStyle(color: Color(0xFF6B7A73), fontSize: 13)),
          const SizedBox(height: 24),
          const Text('¿A qué hora fue?', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: ['Mañana', 'Tarde', 'Noche'].map((t) => ChoiceChip(
            label: Text(t), selected: _time == t,
            onSelected: (_) => setState(() => _time = t),
            selectedColor: const Color(0xFFF4E3DC),
            labelStyle: TextStyle(color: _time == t ? const Color(0xFFA14D2F) : null),
          )).toList()),
          const SizedBox(height: 24),
          const Text('¿Cómo te sentías antes?', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: ['Aburrido', 'Ansioso', 'Estresado', 'Otro'].map((f) => ChoiceChip(
            label: Text(f), selected: _feeling == f,
            onSelected: (_) => setState(() => _feeling = f),
            selectedColor: const Color(0xFFF4E3DC),
            labelStyle: TextStyle(color: _feeling == f ? const Color(0xFFA14D2F) : null),
          )).toList()),
          if (_feeling == 'Otro') ...[
            const SizedBox(height: 12),
            TextField(controller: _other, decoration: const InputDecoration(hintText: 'Escribe cómo te sentías...', border: OutlineInputBorder())),
          ],
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _saving ? null : _save,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD27D5E), foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: _saving ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
