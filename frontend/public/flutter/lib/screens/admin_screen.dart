import 'package:flutter/material.dart';
import '../theme.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _tabIndex = 0;

  final List<Map<String, dynamic>> appointments = [
    {'time': '09:00', 'client': 'Ana Paula',  'service': 'Corte Feminino',  'value': 'R\$ 60', 'status': 'done'},
    {'time': '10:30', 'client': 'Marcos T.',  'service': 'Barba + Corte',   'value': 'R\$ 85', 'status': 'done'},
    {'time': '14:00', 'client': 'Ricardo A.', 'service': 'Corte Masculino', 'value': 'R\$ 45', 'status': 'current'},
    {'time': '15:30', 'client': 'Felipe N.',  'service': 'Barba',           'value': 'R\$ 40', 'status': 'next'},
    {'time': '17:00', 'client': 'Bruno C.',   'service': 'Corte + Hidrat.', 'value': 'R\$ 95', 'status': 'next'},
  ];

  final List<Map<String, dynamic>> tabs = [
    {'icon': Icons.calendar_today_outlined, 'label': 'Agenda'},
    {'icon': Icons.group_outlined,          'label': 'Clientes'},
    {'icon': Icons.bar_chart_outlined,      'label': 'Relatório'},
    {'icon': Icons.settings_outlined,       'label': 'Config.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [

            // ── Header com stats ───────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF111111), kBg], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A))),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('PAINEL DO BARBEIRO', style: TextStyle(color: kDim, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                            SizedBox(height: 2),
                            Text('Olá, Rafael! 👋', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(
                        width: 42, height: 42,
                        decoration: const BoxDecoration(shape: BoxShape.circle, gradient: kGoldGrad),
                        child: const Center(child: Text('💈', style: TextStyle(fontSize: 18))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Stats
                  Row(
                    children: [
                      _statCard('📅', '12',    'Hoje',         kGold),
                      const SizedBox(width: 7),
                      _statCard('💰', 'R\$840', 'Faturamento',  kGreen),
                      const SizedBox(width: 7),
                      _statCard('⭐', '4.9★',  'Avaliação',    kOrange),
                    ],
                  ),
                ],
              ),
            ),

            // ── Corpo ─────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Ações rápidas ──────────────
                    Row(
                      children: [
                        _quickAction('🔒', 'Bloquear\nHorário', false),
                        const SizedBox(width: 8),
                        _quickAction('+',  'Novo\nServiço',     true),
                        const SizedBox(width: 8),
                        _quickAction('📊', 'Relatório',         false),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Agenda ─────────────────────
                    Row(
                      children: [
                        Expanded(child: sectionTitle('AGENDA DE HOJE')),
                        const Text('Ver tudo', style: TextStyle(color: kGold, fontSize: 10, fontWeight: FontWeight.w600)),
                      ],
                    ),

                    ...appointments.map((a) => _appointmentCard(a)),
                  ],
                ),
              ),
            ),

            // ── Bottom Nav ─────────────────────────
            Container(
              decoration: const BoxDecoration(
                color: kBg,
                border: Border(top: BorderSide(color: Color(0xFF1A1A1A))),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Row(
                children: tabs.asMap().entries.map((e) {
                  final i      = e.key;
                  final t      = e.value;
                  final active = i == _tabIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tabIndex = i),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(t['icon'] as IconData, color: active ? kGold : const Color(0xFF444444), size: 20),
                          const SizedBox(height: 3),
                          Text(t['label'] as String, style: TextStyle(color: active ? kGold : const Color(0xFF444444), fontSize: 9, fontWeight: FontWeight.w600)),
                          if (active) ...[
                            const SizedBox(height: 3),
                            Container(width: 16, height: 2, decoration: BoxDecoration(gradient: kGoldGrad, borderRadius: BorderRadius.circular(2))),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: kCard3, border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 2),
            Text(value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
            Text(label, style: const TextStyle(color: Color(0xFF555555), fontSize: 9, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(String icon, String label, bool main) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          gradient: main ? kGoldGrad : null,
          color: main ? null : kCard2,
          border: main ? null : Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            Text(icon, style: TextStyle(fontSize: main ? 18 : 14)),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(color: main ? const Color(0xFF0A0A0A) : const Color(0xFF666666), fontSize: 8, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _appointmentCard(Map<String, dynamic> a) {
    final status  = a['status'] as String;
    final isDone  = status == 'done';
    final isCur   = status == 'current';

    Color timeColor  = isDone ? kDim : isCur ? kGold : const Color(0xFF888888);
    Color valColor   = isDone ? kGreen : isCur ? kGold : const Color(0xFF777777);
    String statusTxt = isDone ? '✓ Concluído' : isCur ? '● Em andamento' : 'Aguardando';
    Color statusC    = isDone ? kGreen.withOpacity(0.5) : isCur ? kGold : const Color(0xFF444444);

    return Opacity(
      opacity: isDone ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isCur ? kGold.withOpacity(0.08) : kCard,
          border: Border.all(color: isCur ? kGold.withOpacity(0.27) : isDone ? const Color(0xFF1A1A1A) : kBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 36, child: Text(a['time'] as String, style: TextStyle(color: timeColor, fontSize: 10, fontWeight: FontWeight.w700))),
            Container(width: 1, height: 32, color: isCur ? kGold.withOpacity(0.27) : kBorder, margin: const EdgeInsets.symmetric(horizontal: 10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a['client'] as String,  style: TextStyle(color: isDone ? const Color(0xFF666666) : kText, fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(a['service'] as String, style: const TextStyle(color: Color(0xFF555555), fontSize: 10)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(a['value'] as String, style: TextStyle(color: valColor, fontSize: 10, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(statusTxt, style: TextStyle(color: statusC, fontSize: 8, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
