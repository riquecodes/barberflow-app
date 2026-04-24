import 'package:flutter/material.dart';
import '../services/rating_service.dart';
import '../services/services_service.dart';
import '../models/service_model.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _ratingService = RatingService();
  final _servicesService = ServicesService();
  final _commentCtrl = TextEditingController();

  List<ServiceModel> _services = [];
  ServiceModel? _selectedService;
  int _stars = 0;
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
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

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceAll('Exception: ', '')),
      backgroundColor: Colors.redAccent,
    ));
  }

  Future<void> _submit() async {
    if (_selectedService == null) {
      _showError('Selecione um serviço para avaliar.');
      return;
    }
    if (_stars == 0) {
      _showError('Selecione pelo menos uma estrela.');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await _ratingService.createRating(
        stars: _stars,
        comment: _commentCtrl.text.trim().isEmpty
            ? null
            : _commentCtrl.text.trim(),
        serviceId: _selectedService!.id,
      );
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Avaliação enviada!',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Obrigado pelo seu feedback.',
              style: TextStyle(color: Colors.white70),
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
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white54, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Avaliar serviço',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4A017)),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFD4A017).withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A017).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.star_rounded,
                              color: Color(0xFFD4A017), size: 28),
                        ),
                        const SizedBox(width: 14),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sua opinião importa!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Avalie o serviço que você recebeu',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Service selector
                  _sectionLabel('SERVIÇO'),
                  const SizedBox(height: 10),
                  _buildServiceSelector(),

                  const SizedBox(height: 28),

                  // Star rating
                  _sectionLabel('SUA NOTA'),
                  const SizedBox(height: 16),
                  _buildStarRating(),
                  if (_stars > 0) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        _starLabel(_stars),
                        style: const TextStyle(
                            color: Color(0xFFD4A017), fontSize: 13),
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Comment
                  _sectionLabel('COMENTÁRIO (OPCIONAL)'),
                  const SizedBox(height: 10),
                  _buildCommentField(),

                  const SizedBox(height: 32),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A017),
                        disabledBackgroundColor:
                            const Color(0xFFD4A017).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.black, strokeWidth: 2),
                            )
                          : const Text(
                              'Enviar avaliação',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.white38,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildServiceSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonFormField<ServiceModel>(
        value: _selectedService,
        dropdownColor: const Color(0xFF2A2A2A),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white38),
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
          hintText: 'Selecione um serviço',
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
          prefixIcon:
              Icon(Icons.content_cut, color: Colors.white38, size: 20),
        ),
        items: _services
            .map((s) => DropdownMenuItem<ServiceModel>(
                  value: s,
                  child: Text(s.name),
                ))
            .toList(),
        onChanged: (s) => setState(() => _selectedService = s),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final star = i + 1;
        return GestureDetector(
          onTap: () => setState(() => _stars = star),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Icon(
                star <= _stars
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                key: ValueKey('$star-${star <= _stars}'),
                color: star <= _stars
                    ? const Color(0xFFD4A017)
                    : Colors.white24,
                size: 48,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCommentField() {
    return TextField(
      controller: _commentCtrl,
      maxLines: 4,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Conte como foi sua experiência...',
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFD4A017), width: 1),
        ),
      ),
    );
  }

  String _starLabel(int stars) {
    switch (stars) {
      case 1:
        return 'Muito ruim';
      case 2:
        return 'Ruim';
      case 3:
        return 'Regular';
      case 4:
        return 'Bom';
      case 5:
        return 'Excelente!';
      default:
        return '';
    }
  }
}
