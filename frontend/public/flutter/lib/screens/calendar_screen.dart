import 'package:flutter/material.dart';
import '../theme.dart';
import 'payment_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedDay    = 14;
  int selectedBarber = 0;
  String selectedTime = '14:00';

  final List<String> dayNames   = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  final List<List<int?>> weeks  = [
    [null, null, null, 1, 2, 3, 4],
    [5, 6, 7, 8, 9, 10, 11],
    [12, 13, 14, 15, 16, 17, 18],
    [19, 20, 21, 22, 23, 24, 25],
    [26, 27, 28, null, null, null, null],
  ];

  final List<Map<String, String>> barbers = [
    {'name': 'Rafael S.', 'icon': '💈'},
    {'name': 'Carlos M.', 'icon': '✂'},
    {'name': 'Diego L.', 'icon': '🪒'},
  ];

  final List<String> times       = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00'];
  final Set<String>  unavailable = {'10:00', '15:00'};
  final Set<int>     pastDays    = {5, 6, 7, 8, 9, 10, 11, 12, 13};
  final Set<int>     dotDays     = {17};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [

            // ── Header ─────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A)))),
              child: Row(
                children: [
                  backIcon(context),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AGENDAR HORÁRIO', style: TextStyle(color: kDim, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                        Text('Março 2026', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Row(
                    children: ['←', '→'].map((a) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(color: kCard2, border: Border.all(color: kBorder2), borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text(a, style: const TextStyle(color: kDim, fontWeight: FontWeight.w700))),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // ── Corpo scrollável ───────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Grade dias da semana ──────────
                    Row(
                      children: dayNames.map((d) => Expanded(
                        child: Center(
                          child: Text(d, style: const TextStyle(color: Color(0xFF555555), fontSize: 10, fontWeight: FontWeight.w700)),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 6),

                    // ── Semanas ───────────────────────
                    ...weeks.map((week) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: week.map((day) => Expanded(
                          child: day == null
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () => setState(() => selectedDay = day),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            gradient: day == selectedDay ? kGoldGrad : null,
                                            color: day == selectedDay
                                                ? null
                                                : pastDays.contains(day)
                                                    ? kCard2
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(9),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$day',
                                              style: TextStyle(
                                                color: day == selectedDay
                                                    ? const Color(0xFF0A0A0A)
                                                    : pastDays.contains(day)
                                                        ? const Color(0xFF555555)
                                                        : kText,
                                                fontSize: 11,
                                                fontWeight: day == selectedDay ? FontWeight.w700 : FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (dotDays.contains(day))
                                          Positioned(
                                            bottom: 4,
                                            child: Container(
                                              width: 4, height: 4,
                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: kGold),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                        )).toList(),
                      ),
                    )),

                    divider(),

                    // ── Barbeiros ─────────────────────
                    sectionTitle('ESCOLHA O BARBEIRO'),
                    Row(
                      children: barbers.asMap().entries.map((e) {
                        final i   = e.key;
                        final b   = e.value;
                        final sel = i == selectedBarber;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedBarber = i),
                            child: Container(
                              margin: EdgeInsets.only(right: i < barbers.length - 1 ? 8 : 0),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                              decoration: BoxDecoration(
                                color: sel ? kGold.withOpacity(0.08) : kCard2,
                                border: Border.all(color: sel ? kGold : kBorder),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(b['icon']!, style: const TextStyle(fontSize: 18)),
                                  const SizedBox(height: 4),
                                  Text(b['name']!, style: TextStyle(color: sel ? kGold : const Color(0xFF777777), fontSize: 9, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // ── Horários ──────────────────────
                    sectionTitle('HORÁRIOS DISPONÍVEIS'),
                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      childAspectRatio: 2.4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: times.map((t) {
                        final off = unavailable.contains(t);
                        final sel = t == selectedTime;
                        return GestureDetector(
                          onTap: off ? null : () => setState(() => selectedTime = t),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: sel ? kGoldGrad : null,
                              color: sel ? null : kCard2,
                              border: sel ? null : Border.all(color: kBorder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                t,
                                style: TextStyle(
                                  color: sel ? const Color(0xFF0A0A0A) : off ? const Color(0xFF333333) : kText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  decoration: off ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // ── Botão confirmar ───────────────
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
                      child: goldButton('✓  Confirmar Agendamento'),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
