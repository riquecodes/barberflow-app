import 'package:flutter/material.dart';
import '../theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = [
      {'label': 'NOME COMPLETO', 'placeholder': 'João da Silva', 'icon': Icons.person_outline, 'active': false},
      {'label': 'E-MAIL', 'placeholder': 'joao@gmail.com', 'icon': Icons.email_outlined, 'active': true},
      {'label': 'TELEFONE', 'placeholder': '(11) 99999-9999', 'icon': Icons.phone_outlined, 'active': false},
      {'label': 'SENHA', 'placeholder': '••••••••', 'icon': Icons.lock_outline, 'active': false},
      {'label': 'CONFIRMAR SENHA', 'placeholder': '••••••••', 'icon': Icons.lock_outline, 'active': false},
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Barra superior ─────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    backIcon(context),
                    const SizedBox(width: 10),
                    const Text('Voltar', style: TextStyle(color: kDim, fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Logo Row ───────────────────────
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: kGoldGrad,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: kGold.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                          ),
                          child: const Center(child: Text('✂', style: TextStyle(fontSize: 18))),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Criar conta', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                            Text('Preencha seus dados abaixo', style: TextStyle(color: kMuted, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // ── Barra de progresso ─────────────
                    Row(
                      children: List.generate(3, (i) => Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                          decoration: BoxDecoration(
                            gradient: i == 0 ? kGoldGrad : null,
                            color: i != 0 ? kBorder : null,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(height: 22),

                    // ── Campos ─────────────────────────
                    ...fields.map((f) {
                      final active = f['active'] as bool;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f['label'] as String,
                              style: const TextStyle(color: kDim, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                              decoration: BoxDecoration(
                                color: kCard3,
                                border: Border.all(color: active ? kGold.withOpacity(0.33) : kBorder),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Row(
                                children: [
                                  Icon(f['icon'] as IconData, color: active ? kGold.withOpacity(0.5) : kDeep, size: 16),
                                  const SizedBox(width: 9),
                                  Text(
                                    f['placeholder'] as String,
                                    style: TextStyle(color: active ? kGold.withOpacity(0.5) : const Color(0xFF333333), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 4),

                    // ── Termos ─────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.only(top: 1),
                          decoration: BoxDecoration(
                            gradient: kGoldGrad,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Icon(Icons.check, color: Color(0xFF0A0A0A), size: 12),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Color(0xFF555555), fontSize: 11, height: 1.5),
                              children: [
                                TextSpan(text: 'Concordo com os '),
                                TextSpan(text: 'Termos de Uso', style: TextStyle(color: kGold)),
                                TextSpan(text: ' e '),
                                TextSpan(text: 'Política de Privacidade', style: TextStyle(color: kGold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // ── Botão Criar Conta ──────────────
                    goldButton('Criar Conta'),
                    const SizedBox(height: 16),

                    // ── Rodapé ─────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Já tem conta? ',
                            style: TextStyle(color: Color(0xFF555555), fontSize: 12),
                            children: [
                              TextSpan(text: 'Entrar', style: TextStyle(color: kGold, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
