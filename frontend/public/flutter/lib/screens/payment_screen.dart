import 'package:flutter/material.dart';
import '../theme.dart';
import 'rating_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0; // 0=PIX, 1=Crédito, 2=Débito

  final methods = [
    {'icon': '⚡', 'title': 'PIX',               'sub': 'Aprovação imediata', 'subColor': kGreen},
    {'icon': '💳', 'title': 'Cartão de Crédito', 'sub': 'Até 12x sem juros',  'subColor': kMuted},
    {'icon': '🏦', 'title': 'Débito',             'sub': 'À vista',            'subColor': kMuted},
  ];

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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PAGAMENTO', style: TextStyle(color: kDim, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                      Text('Finalizar Agendamento', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
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

                    // ── Resumo do Pedido ───────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: kCard, border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionTitle('RESUMO DO PEDIDO'),

                          Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  color: kGold.withOpacity(0.08),
                                  border: Border.all(color: kGold.withOpacity(0.27)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(child: Text('✂', style: TextStyle(fontSize: 20))),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Corte + Barba',          style: TextStyle(color: kText,  fontSize: 13, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 2),
                                    Text('Rafael Silva · 14:00',   style: TextStyle(color: kMuted, fontSize: 11)),
                                    Text('14 Mar, 2026 · Sáb',    style: TextStyle(color: kDim,   fontSize: 10)),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Container(height: 1, color: const Color(0xFF1A1A1A)),
                          const SizedBox(height: 10),

                          _lineItem('Corte Masculino', 'R\$ 45,00', false),
                          _lineItem('Barba',            'R\$ 40,00', false),
                          _lineItem('Desconto (10%)',   '- R\$ 8,50', true),

                          const SizedBox(height: 6),
                          Container(height: 1, color: const Color(0xFF1A1A1A)),
                          const SizedBox(height: 8),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                              Text('R\$ 76,50', style: TextStyle(color: kGold, fontSize: 15, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Métodos de Pagamento ────────
                    sectionTitle('FORMA DE PAGAMENTO'),

                    ...methods.asMap().entries.map((e) {
                      final i   = e.key;
                      final m   = e.value;
                      final sel = i == _selectedMethod;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMethod = i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: sel ? kGold.withOpacity(0.08) : kCard,
                            border: Border.all(
                              color: sel ? kGold : kBorder,
                              width: sel ? 1.5 : 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(
                                  color: sel ? kGreen.withOpacity(0.13) : kCard2,
                                  border: Border.all(color: sel ? kGreen.withOpacity(0.27) : kBorder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text(m['icon'] as String, style: const TextStyle(fontSize: 18))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(m['title'] as String, style: TextStyle(color: sel ? Colors.white : const Color(0xFFAAAAAA), fontSize: 13, fontWeight: FontWeight.w600)),
                                    Text(m['sub'] as String, style: TextStyle(color: m['subColor'] as Color, fontSize: 10, fontWeight: sel ? FontWeight.w600 : FontWeight.w400)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 22, height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: sel ? kGoldGrad : null,
                                  border: sel ? null : Border.all(color: const Color(0xFF333333), width: 2),
                                ),
                                child: sel ? Center(
                                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0A0A0A))),
                                ) : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    // ── Cupom ──────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: kCard,
                        border: Border.all(color: kBorder, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Text('🎟', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Expanded(child: Text('Adicionar cupom de desconto', style: TextStyle(color: Color(0xFF555555), fontSize: 12))),
                          Text('+', style: TextStyle(color: kGold, fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Botão Pagar ────────────────
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingScreen())),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: kGoldGrad,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 6))],
                        ),
                        child: const Center(
                          child: Text(
                            '⚡  Pagar com PIX · R\$ 76,50',
                            style: TextStyle(color: Color(0xFF0A0A0A), fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ),
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

  Widget _lineItem(String label, String value, bool isDiscount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: kMuted, fontSize: 11)),
          Text(value, style: TextStyle(color: isDiscount ? kGreen : const Color(0xFFAAAAAA), fontSize: 11, fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }
}
