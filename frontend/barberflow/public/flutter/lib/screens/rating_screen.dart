import 'package:flutter/material.dart';
import '../theme.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _overallRating = 5;
  final Map<String, int> _aspectRatings = {
    'Atendimento': 5,
    'Qualidade':   5,
    'Ambiente':    4,
    'Pontualidade': 5,
  };
  final Set<int> _selectedTags = {0, 2, 3, 5};

  final List<String> tags = [
    'Ótimo atendimento',
    'Ambiente agradável',
    'Profissional',
    'Pontual',
    'Custo-benefício',
    'Recomendo!',
  ];

  String _overallLabel(int r) {
    switch (r) {
      case 1: return 'Péssimo';
      case 2: return 'Ruim';
      case 3: return 'Regular';
      case 4: return 'Bom';
      default: return 'Excelente!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [

            // ── Header ─────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A)))),
              child: Row(
                children: [
                  backIcon(context),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('SUA OPINIÃO', style: TextStyle(color: kDim, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                      Text('Avalie o Atendimento', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),

            // ── Corpo ─────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Card do Barbeiro ───────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF141414), Color(0xFF1A1408)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        border: Border.all(color: kGold.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: kGoldGrad),
                            child: const Center(child: Text('💈', style: TextStyle(fontSize: 22))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Rafael Silva',           style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                                const Text('Corte + Barba · 14/03/2026', style: TextStyle(color: kDim,   fontSize: 11)),
                                const SizedBox(height: 4),
                                Row(children: [
                                  stars(5, size: 11),
                                  const SizedBox(width: 4),
                                  const Text('4.9', style: TextStyle(color: kGold, fontSize: 10, fontWeight: FontWeight.w600)),
                                ]),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('R\$ 76,50', style: TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w700)),
                              SizedBox(height: 2),
                              Text('✓ Pago', style: TextStyle(color: kGreen, fontSize: 9, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Avaliação Geral ────────────
                    Center(
                      child: Column(
                        children: [
                          sectionTitle('AVALIAÇÃO GERAL'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (i) => GestureDetector(
                              onTap: () => setState(() => _overallRating = i + 1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '★',
                                  style: TextStyle(
                                    color: i < _overallRating ? kGold : const Color(0xFF2A2A2A),
                                    fontSize: 34,
                                    shadows: i < _overallRating ? [Shadow(color: kGold.withOpacity(0.5), blurRadius: 8)] : null,
                                  ),
                                ),
                              ),
                            )),
                          ),
                          const SizedBox(height: 6),
                          Text(_overallLabel(_overallRating), style: const TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // ── Aspectos ───────────────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: kCard, border: Border.all(color: const Color(0xFF1E1E1E)), borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionTitle('AVALIE CADA ASPECTO'),
                          ..._aspectRatings.entries.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(child: Text(e.key, style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 11))),
                                Row(children: List.generate(5, (i) => GestureDetector(
                                  onTap: () => setState(() => _aspectRatings[e.key] = i + 1),
                                  child: Text('★', style: TextStyle(color: i < e.value ? kGold : const Color(0xFF2A2A2A), fontSize: 14)),
                                ))),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ── Tags ───────────────────────
                    sectionTitle('O QUE VOCÊ MAIS GOSTOU?'),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags.asMap().entries.map((e) {
                        final i   = e.key;
                        final tag = e.value;
                        final sel = _selectedTags.contains(i);
                        return GestureDetector(
                          onTap: () => setState(() {
                            if (sel) {
                              _selectedTags.remove(i);
                            } else {
                              _selectedTags.add(i);
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: sel ? kGold.withOpacity(0.08) : kCard,
                              border: Border.all(color: sel ? kGold : kBorder),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              sel ? '✓  $tag' : tag,
                              style: TextStyle(color: sel ? kGold : const Color(0xFF555555), fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // ── Comentário ─────────────────
                    sectionTitle('DEIXE UM COMENTÁRIO'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kCard,
                        border: Border.all(color: kGold.withOpacity(0.27)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Ótimo profissional! Serviço impecável, atendimento rápido e ambiente muito agradável...',
                        style: TextStyle(color: Color(0xFF444444), fontSize: 12, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Botão Enviar ───────────────
                    goldButton('★  Enviar Avaliação', radius: 16),
                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        'Sua avaliação ajuda outros clientes a escolher melhor!',
                        style: const TextStyle(color: Color(0xFF444444), fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
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
