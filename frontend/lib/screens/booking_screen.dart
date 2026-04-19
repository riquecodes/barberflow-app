import 'package:flutter/material.dart';
import '../services/appointment_service.dart';
import '../services/services_service.dart';
import '../services/auth_service.dart';
import '../models/service_model.dart';
import '../models/appointment_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _appointmentService = AppointmentService();
  final _servicesService = ServicesService();
  final _authService = AuthService();

  int _step = 0; // 0 = serviço, 1 = data, 2 = horário

  List<ServiceModel> _services = [];
  ServiceModel? _selectedService;

  DateTime _selectedDate = DateTime.now();
  List<String> _availableTimes = [];
  String? _selectedTime;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    setState(() => _isLoading = true);
    try {
      final services = await _servicesService.getAllServices();
      setState(() => _services = services);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadAvailableTimes() async {
    setState(() => _isLoading = true);
    try {
      final times = await _appointmentService.getAvailableTimes(_selectedDate);
      setState(() => _availableTimes = times);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirm() async {
    setState(() => _isLoading = true);
    try {
      final userId = await _authService.getUserId();
      final formatted =
          '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

      await _appointmentService.createAppointment(
        CreateAppointmentDTO(
          userId: userId ?? 0,
          serviceId: _selectedService!.id,
          date: formatted,
          time: _selectedTime!,
        ),
      );

      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: const Text('Agendado!',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            content: Text(
              'Seu horário às $_selectedTime foi confirmado.',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Ok',
                    style: TextStyle(color: Color(0xFFD4A017))),
              ),
            ],
          ),
        );
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: _step > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white54, size: 20),
                onPressed: () => setState(() => _step--),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white54, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
        title: const Text(
          'Agendar horário',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Color(0xFFD4A017)))
                : _buildCurrentStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Serviço', 'Data', 'Horário'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = i == _step;
          final isDone = i < _step;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDone || isActive
                              ? const Color(0xFFD4A017)
                              : const Color(0xFF2A2A2A),
                          border: Border.all(
                            color: isDone || isActive
                                ? const Color(0xFFD4A017)
                                : Colors.white24,
                          ),
                        ),
                        child: Center(
                          child: isDone
                              ? const Icon(Icons.check,
                                  color: Colors.black, size: 14)
                              : Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isActive
                                        ? Colors.black
                                        : Colors.white38,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[i],
                        style: TextStyle(
                          fontSize: 11,
                          color: isActive
                              ? const Color(0xFFD4A017)
                              : Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: i < _step
                          ? const Color(0xFFD4A017)
                          : Colors.white12,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return _buildServiceStep();
      case 1:
        return _buildDateStep();
      case 2:
        return _buildTimeStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildServiceStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Escolha o serviço',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Selecione o que deseja fazer',
              style: TextStyle(fontSize: 13, color: Colors.white54)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, i) {
                final s = _services[i];
                final isSelected = _selectedService?.id == s.id;
                return GestureDetector(
                  onTap: () => setState(() => _selectedService = s),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFD4A017)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(s.description,
                                  style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'R\$ ${s.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Color(0xFFD4A017),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text('${s.duration} min',
                                style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildNextButton(
            label: 'Próximo',
            enabled: _selectedService != null,
            onTap: () => setState(() => _step = 1),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDateStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Escolha a data',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Selecione o dia do agendamento',
              style: TextStyle(fontSize: 13, color: Colors.white54)),
          const SizedBox(height: 20),
          Expanded(
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 60)),
              onDateChanged: (date) => setState(() => _selectedDate = date),
            ),
          ),
          _buildNextButton(
            label: 'Ver horários disponíveis',
            enabled: true,
            onTap: () {
              _loadAvailableTimes();
              setState(() => _step = 2);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTimeStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Escolha o horário',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          Text(
            'Disponíveis para ${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
            style: const TextStyle(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(height: 20),
          _availableTimes.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Nenhum horário disponível para este dia.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: _availableTimes.length,
                    itemBuilder: (context, i) {
                      final time = _availableTimes[i];
                      final isSelected = _selectedTime == time;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedTime = time),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFD4A017)
                                : const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFD4A017)
                                  : Colors.white12,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          _buildNextButton(
            label: 'Confirmar agendamento',
            enabled: _selectedTime != null,
            onTap: _confirm,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNextButton({
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4A017),
          disabledBackgroundColor: const Color(0xFF2A2A2A),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}