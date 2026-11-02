import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/foreground_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int water = 0;
  int caffeine = 0;
  int junk = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = DatabaseService.instance;
    final w = await db.getWaterTotal();
    final c = await db.getCount('caffeine');
    final j = await db.getCount('junk');
    if (mounted) setState(() { water = w; caffeine = c; junk = j; });
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  Future<void> _add(String type, {String? value}) async {
    await DatabaseService.instance.insertRecord(type, value: value);
    await _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrado'), duration: const Duration(seconds: 2)),
      );
    }
  }

  void _showNapModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Registrar siesta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text('¿Cuánto tiempo dormiste?', style: TextStyle(color: Color(0xFF6B7A73))),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setModalState) {
                double minutes = 20;
                return Column(
                  children: [
                    Slider(
                      value: minutes,
                      min: 5,
                      max: 180,
                      divisions: 35,
                      activeColor: const Color(0xFFD27D5E),
                      onChanged: (v) => setModalState(() => minutes = v),
                    ),
                    Text('${minutes.round()} min', style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (minutes > 30)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Siestas largas a veces reducen la energía posterior. Se registra igual.', style: TextStyle(color: Color(0xFFA14D2F), fontSize: 13)),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar'))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _add('nap', value: minutes.round().toString());
                              if (ctx.mounted) Navigator.pop(ctx);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD27D5E), foregroundColor: Colors.white),
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showJunkModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Registrar chatarra', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text('¿Qué comiste?', style: TextStyle(color: Color(0xFF6B7A73))),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setModalState) {
                String selected = 'Papas';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: ['Papas', 'Donas', 'Mamut', 'Otro'].map((t) => ChoiceChip(
                        label: Text(t),
                        selected: selected == t,
                        onSelected: (_) => setModalState(() => selected = t),
                        selectedColor: const Color(0xFFF4E3DC),
                      )).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text('¿Cuál es tu nivel de energía ahora?'),
                    const SizedBox(height: 8),
                    const Text('1 = Agotado · 10 = Con mucha energía', style: TextStyle(fontSize: 12, color: Color(0xFF6B7A73))),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar'))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _add('junk', value: selected);
                              if (ctx.mounted) Navigator.pop(ctx);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD27D5E), foregroundColor: Colors.white),
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
          children: [
            Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: const Color(0xFF2C3E35), borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                const SizedBox(width: 12),
                const Text('Pulso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF2C3E35))),
              ],
            ),
            const SizedBox(height: 8),
            Text(_greeting, style: const TextStyle(color: Color(0xFF6B7A73), fontSize: 15)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$water ml', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF2C3E35))),
                  const SizedBox(height: 6),
                  Text('Cafeína $caffeine · Chatarra $junk', style: const TextStyle(color: Color(0xFF6B7A73))),
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
                _ActionTile(icon: Icons.water_drop_outlined, label: "Agua +250 ml", onTap: () => _add("water", value: "250")),
                _ActionTile(icon: Icons.local_drink_outlined, label: "Registrar Coca", onTap: () => _add("caffeine")),
                _ActionTile(icon: Icons.bed_outlined, label: "Registrar siesta", onTap: _showNapModal),
                _ActionTile(icon: Icons.fastfood_outlined, label: "Registrar chatarra", onTap: _showJunkModal),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  await ForegroundService.start();
                  if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio en segundo plano iniciado')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5E6DE),
                  foregroundColor: const Color(0xFFA14D2F),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Iniciar modo sueño'),
              ),
            ),
          ],
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
      color: const Color(0xFFF4F2EF),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(child: Padding(padding: const EdgeInsets.all(12), child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Color(0xFF2C3E35))))),
      ),
    );
  }
}
