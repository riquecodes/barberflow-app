import 'package:flutter/material.dart';
import '../theme.dart';
import 'register_screen.dart';
import 'calendar_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF141008)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // ── Logo ──────────────────────────────
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: kGoldGrad,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: kGold.withOpacity(0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('✂', style: TextStyle(fontSize: 32)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Barber Flow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Seu estilo, nossa arte',
                  style: TextStyle(color: kDim, fontSize: 12),
                ),
                const SizedBox(height: 32),

                // ── Title ─────────────────────────────
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bem-vindo de volta 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Faça login para continuar',
                        style: TextStyle(color: kMuted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Campo E-mail ───────────────────────
                _inputField(
                  label: 'E-MAIL',
                  placeholder: 'seuemail@gmail.com',
                  icon: Icons.email_outlined,
                  iconColor: kDim,
                  isActive: false,
                ),
                const SizedBox(height: 12),

                // ── Campo Senha ────────────────────────
                _inputField(
                  label: 'SENHA',
                  placeholder: '••••••••',
                  icon: Icons.lock_outline,
                  iconColor: kGold,
                  isActive: true,
                  suffix: const Icon(Icons.visibility_outlined, color: Color(0xFF555555), size: 18),
                ),
                const SizedBox(height: 8),

                // ── Esqueci senha ──────────────────────
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Botão Entrar ───────────────────────
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalendarScreen()),
                  ),
                  child: goldButton('Entrar'),
                ),
                const SizedBox(height: 20),

                // ── Divisor ───────────────────────────
                const Row(children: [
                  Expanded(child: Divider(color: Color(0xFF222222))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('ou continue com', style: TextStyle(color: Color(0xFF555555), fontSize: 11)),
                  ),
                  Expanded(child: Divider(color: Color(0xFF222222))),
                ]),
                const SizedBox(height: 16),

                // ── Google ────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: kCard2,
                    border: Border.all(color: kBorder2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFea4335), Color(0xFFfbbc04), Color(0xFF34a853), Color(0xFF4285f4)],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Google', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── Rodapé ────────────────────────────
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Não tem uma conta? ',
                      style: TextStyle(color: kMuted, fontSize: 13),
                      children: [
                        TextSpan(
                          text: 'Cadastre-se',
                          style: TextStyle(color: kGold, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required String placeholder,
    required IconData icon,
    required Color iconColor,
    required bool isActive,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: kDim, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: kCard2,
            border: Border.all(color: isActive ? kGold.withOpacity(0.33) : kBorder2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(placeholder, style: const TextStyle(color: kDeep, fontSize: 13)),
              ),
              if (suffix != null) suffix,
            ],
          ),
        ),
      ],
    );
  }
}
