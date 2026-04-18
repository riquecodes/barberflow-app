import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/rating_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D0D),
  ));
  runApp(const BarberFlowApp());
}

class BarberFlowApp extends StatelessWidget {
  const BarberFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.dark(
          primary: kGold,
          secondary: kGoldLt,
          surface: kCard,
        ),
        fontFamily: 'Roboto',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS:     CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const GalleryScreen(),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  TELA GALERIA  –  ponto de entrada com todas as telas listadas
// ════════════════════════════════════════════════════════════════
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = <Map<String, dynamic>>[
      {'label': 'Login',        'icon': '🔐', 'desc': 'Autenticação de usuário',    'screen': const LoginScreen()},
      {'label': 'Cadastro',     'icon': '👤', 'desc': 'Criação de conta',           'screen': const RegisterScreen()},
      {'label': 'Agendamento',  'icon': '📅', 'desc': 'Calendário e horários',      'screen': const CalendarScreen()},
      {'label': 'Painel Admin', 'icon': '📊', 'desc': 'Gestão do barbeiro',         'screen': const AdminScreen()},
      {'label': 'Pagamento',    'icon': '💳', 'desc': 'PIX, cartão e débito',       'screen': const PaymentScreen()},
      {'label': 'Avaliação',    'icon': '⭐', 'desc': 'Nota e comentário',          'screen': const RatingScreen()},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kBgGrad1, kBgGrad2, kBgGrad1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // ── Cabeçalho ──────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
                  child: Column(
                    children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(
                          gradient: kGoldGrad,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: kGold.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 6))],
                        ),
                        child: const Center(child: Text('✂', style: TextStyle(fontSize: 26))),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Barber Flow',
                        style: TextStyle(color: kGold, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 4),
                      const Text('Telas do aplicativo mobile', style: TextStyle(color: kDim, fontSize: 14)),
                      const SizedBox(height: 16),
                      Container(
                        width: 60, height: 2,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.transparent, kGold, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Grid de telas ───────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final s = screens[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => s['screen'] as Widget),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kCard,
                            border: Border.all(color: kBorder),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 56, height: 56,
                                decoration: BoxDecoration(
                                  color: kGold.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: kGold.withOpacity(0.2)),
                                ),
                                child: Center(
                                  child: Text(s['icon'] as String, style: const TextStyle(fontSize: 26)),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                s['label'] as String,
                                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                s['desc'] as String,
                                style: const TextStyle(color: kDim, fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: kGoldGrad,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Ver tela →',
                                  style: TextStyle(color: Color(0xFF0A0A0A), fontSize: 10, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: screens.length,
                  ),
                ),
              ),

              // ── Rodapé ──────────────────────────────
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Divider(color: Color(0xFF1A1A1A)),
                      SizedBox(height: 12),
                      Text('Barber Flow App · Flutter · 2026', style: TextStyle(color: Color(0xFF444444), fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
