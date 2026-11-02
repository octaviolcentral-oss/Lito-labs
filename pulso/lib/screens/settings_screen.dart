import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dopamineLock = false;
  bool _discreet = false;
  bool _darkMode = false;
  bool _smartCoach = true;
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkMode ? const Color(0xFF1C2331) : const Color(0xFFF9F8F6),
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Privacidad'),
          SwitchListTile(
            title: const Text('Bloqueo de Dopamina'),
            subtitle: const Text('Pide PIN para entrar a Dopamina'),
            value: _dopamineLock,
            onChanged: (v) => setState(() => _dopamineLock = v),
          ),
          SwitchListTile(
            title: const Text('Modo Discreto'),
            subtitle: const Text('Oculta números de agua y cafeína'),
            value: _discreet,
            onChanged: (v) => setState(() => _discreet = v),
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Accesibilidad'),
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Smart Coach'),
          SwitchListTile(
            title: const Text('Consejos Inteligentes'),
            value: _smartCoach,
            onChanged: (v) => setState(() => _smartCoach = v),
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Perfil'),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nombre',
              hintText: '¿Cómo te llamas?',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => _name = v,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w600)),
    );
  }
}
