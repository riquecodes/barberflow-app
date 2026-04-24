import 'package:flutter/material.dart';
import '../services/appointment_service.dart';
import '../services/auth_service.dart';
import '../models/appointment_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _appointmentService = AppointmentService();
  final _authService = AuthService();

  List<AppointmentModelDTO> _appointments = [];
  bool _isLoading = false;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String _formatTime(String time) {
    return time.length >= 5 ? time.substring(0, 5) : time;
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final appointments = await _appointmentService.getMyAppointments();
      final name = await _authService.getUserName();
      setState(() {
        _appointments = appointments;
        _userName = name ?? '';
      });
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceAll('Exception: ', '')),
      backgroundColor: Colors.redAccent,
    ));
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFFD4A017),
          backgroundColor: const Color(0xFF2A2A2A),
          onRefresh: _loadData,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildNewAppointmentButton()),
              SliverToBoxAdapter(child: _buildRateButton()),
              SliverToBoxAdapter(child: _buildSectionTitle()),
              _isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(
                              color: Color(0xFFD4A017)),
                        ),
                      ),
                    )
                  : _appointments.isEmpty
                      ? SliverToBoxAdapter(child: _buildEmpty())
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) =>
                                _buildAppointmentCard(_appointments[i]),
                            childCount: _appointments.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, ${_userName.split(' ').first} 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Seus agendamentos',
                style: TextStyle(fontSize: 13, color: Colors.white54),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/change-password'),
                icon: const Icon(Icons.lock_outline,
                    color: Colors.white38, size: 22),
              ),
              IconButton(
                onPressed: _logout,
                icon: const Icon(Icons.logout,
                    color: Colors.white38, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewAppointmentButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, '/booking').then((_) => _loadData()),
          icon: const Icon(Icons.add, color: Colors.black, size: 20),
          label: const Text(
            'Novo agendamento',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4A017),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildRateButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/rating'),
          icon: const Icon(Icons.star_outline,
              color: Color(0xFFD4A017), size: 18),
          label: const Text(
            'Avaliar serviço',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFD4A017),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFD4A017), width: 1.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Text(
        'PRÓXIMOS AGENDAMENTOS',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white38,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.calendar_today_outlined,
                color: Colors.white24, size: 48),
            SizedBox(height: 16),
            Text(
              'Nenhum agendamento ainda',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Clique em "Novo agendamento" para começar',
              style: TextStyle(color: Colors.white24, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentModelDTO a) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFD4A017).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.content_cut,
                    color: Color(0xFFD4A017), size: 22),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.serviceName ?? 'Serviço',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${a.date} às ${_formatTime(a.time)}', // ← corrigido
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              'R\$ ${a.servicePrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Color(0xFFD4A017),
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}