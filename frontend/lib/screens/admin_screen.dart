import 'package:flutter/material.dart';
import '../services/services_service.dart';
import '../services/appointment_service.dart';
import '../services/auth_service.dart';
import '../models/service_model.dart';
import '../models/appointment_model.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _servicesService = ServicesService();
  final _appointmentService = AppointmentService();
  final _authService = AuthService();

  List<ServiceModel> _services = [];
  List<AdminAppointmentModel> _appointments = [];
  bool _isLoadingServices = false;
  bool _isLoadingAppointments = false;
  String _userName = '';

  // Form controllers for add service
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAll();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _durationCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    final name = await _authService.getUserName();
    setState(() => _userName = name ?? '');
    await Future.wait([_loadServices(), _loadAppointments()]);
  }

  Future<void> _loadServices() async {
    setState(() => _isLoadingServices = true);
    try {
      final services = await _servicesService.getAllServices();
      setState(() => _services = services);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoadingServices = false);
    }
  }

  Future<void> _loadAppointments() async {
    setState(() => _isLoadingAppointments = true);
    try {
      final appointments = await _appointmentService.getAllAppointmentsAdmin();
      setState(() => _appointments = appointments);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoadingAppointments = false);
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

  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length == 3) return '${parts[2]}/${parts[1]}/${parts[0]}';
    return isoDate;
  }

  String _formatTime(String time) {
    return time.length >= 5 ? time.substring(0, 5) : time;
  }

  Map<String, List<AdminAppointmentModel>> _groupByDate() {
    final Map<String, List<AdminAppointmentModel>> grouped = {};
    for (final a in _appointments) {
      grouped.putIfAbsent(a.date, () => []).add(a);
    }
    return grouped;
  }

  void _showAddServiceSheet() {
    _nameCtrl.clear();
    _descCtrl.clear();
    _priceCtrl.clear();
    _durationCtrl.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(ctx).viewInsets.bottom + 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A017).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.content_cut,
                        color: Color(0xFFD4A017), size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Novo serviço',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _sheetField(_nameCtrl, 'Nome do serviço *', Icons.content_cut),
              const SizedBox(height: 12),
              _sheetField(
                  _descCtrl, 'Descrição', Icons.description_outlined),
              const SizedBox(height: 12),
              _sheetField(
                _priceCtrl,
                'Preço (ex: 50.00) *',
                Icons.attach_money,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              _sheetField(
                _durationCtrl,
                'Duração em minutos *',
                Icons.timer_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4A017),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Adicionar serviço',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetField(
    TextEditingController ctrl,
    String hint,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _submitService() async {
    final name = _nameCtrl.text.trim();
    final desc = _descCtrl.text.trim();
    final priceStr = _priceCtrl.text.trim().replaceAll(',', '.');
    final durationStr = _durationCtrl.text.trim();

    if (name.isEmpty || priceStr.isEmpty || durationStr.isEmpty) {
      _showError('Preencha todos os campos obrigatórios.');
      return;
    }

    final price = double.tryParse(priceStr);
    final duration = int.tryParse(durationStr);

    if (price == null || duration == null) {
      _showError('Preço ou duração inválidos.');
      return;
    }

    try {
      await _servicesService.createService(
        ServiceModelDTO(
          name: name,
          description: desc,
          price: price,
          duration: duration,
        ),
      );
      if (mounted) {
        Navigator.pop(context);
        _loadServices();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Serviço adicionado com sucesso!'),
            backgroundColor: Color(0xFF2A7A2A),
          ),
        );
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (_, __) => _tabController.index == 0
            ? FloatingActionButton(
                onPressed: _showAddServiceSheet,
                backgroundColor: const Color(0xFFD4A017),
                child: const Icon(Icons.add, color: Colors.black, size: 26),
              )
            : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildServicesTab(),
                  _buildAppointmentsTab(),
                ],
              ),
            ),
          ],
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
                'Olá, ${_userName.split(' ').first} 👑',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Painel de administração',
                style: TextStyle(fontSize: 13, color: Colors.white54),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/change_password'),
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

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFD4A017),
          unselectedLabelColor: Colors.white38,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: const Color(0xFFD4A017).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(
              icon: Icon(Icons.content_cut, size: 18),
              text: 'Serviços',
            ),
            Tab(
              icon: Icon(Icons.calendar_today, size: 18),
              text: 'Agendamentos',
            ),
          ],
        ),
      ),
    );
  }

  // ─── Services Tab ───────────────────────────────────────────────────────────

  Widget _buildServicesTab() {
    if (_isLoadingServices) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4A017)),
      );
    }

    if (_services.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.content_cut, color: Colors.white24, size: 48),
            SizedBox(height: 16),
            Text(
              'Nenhum serviço cadastrado',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Toque no "+" para adicionar',
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFFD4A017),
      backgroundColor: const Color(0xFF2A2A2A),
      onRefresh: _loadServices,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 88),
        itemCount: _services.length,
        itemBuilder: (_, i) => _buildServiceCard(_services[i]),
      ),
    );
  }

  Widget _buildServiceCard(ServiceModel s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                    s.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (s.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      s.description,
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    '${s.duration} min',
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
            Text(
              'R\$ ${s.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFFD4A017),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Appointments Tab ────────────────────────────────────────────────────────

  Widget _buildAppointmentsTab() {
    if (_isLoadingAppointments) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4A017)),
      );
    }

    if (_appointments.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined,
                color: Colors.white24, size: 48),
            SizedBox(height: 16),
            Text(
              'Nenhum agendamento encontrado',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    final grouped = _groupByDate();
    final sortedDates = grouped.keys.toList()..sort();

    return RefreshIndicator(
      color: const Color(0xFFD4A017),
      backgroundColor: const Color(0xFF2A2A2A),
      onRefresh: _loadAppointments,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        itemCount: sortedDates.length,
        itemBuilder: (_, i) {
          final date = sortedDates[i];
          final dayList = grouped[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: i == 0 ? 0 : 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A017).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFD4A017).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        _formatDate(date),
                        style: const TextStyle(
                          color: Color(0xFFD4A017),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${dayList.length} agendamento${dayList.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              ...dayList.map((a) => _buildAdminAppointmentCard(a)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdminAppointmentCard(AdminAppointmentModel a) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFD4A017).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.person_outline,
                    color: Color(0xFFD4A017), size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    a.serviceName,
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(a.time),
                  style: const TextStyle(
                    color: Color(0xFFD4A017),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'R\$ ${a.servicePrice.toStringAsFixed(2)}',
                  style:
                      const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
