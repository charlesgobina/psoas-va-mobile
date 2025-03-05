import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/dream_apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_states.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/dream_apartment_provider.dart';
import 'dart:math' as math;

import '../../../domain/providers/apartment_provider.dart';
import '../../../domain/providers/dream_apartment_states.dart';

class DreamApartmentBottomSheet extends StatefulWidget {
  const DreamApartmentBottomSheet({super.key});

  @override
  State<DreamApartmentBottomSheet> createState() =>
      _DreamApartmentBottomSheetState();
}

class _DreamApartmentBottomSheetState extends State<DreamApartmentBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  // apartment provider

  // Sliders
  double _minRent = 300;
  double _maxRent = 1000;
  double _floor = 1;

  // Dropdowns
  String _rooms = '1';
  String _apartmentType = 'Any';
  String _location = 'Tellervo';

  // Checkboxes
  bool _hasSauna = false;

  // Options
  final List<String> _roomOptions = ['1', '2', '3', '4+'];
  final List<String> _apartmentTypeOptions = [
    'Any',
    'Studio',
    'Family Apartment',
    'Shared Apartment',
  ];
  final List<String> _locationOptions = [
    'Aro',
    'Aurora',
    'Domus Botnica',
    'Kumpula',
    'Kalervo',
    'Purseri',
    'Kaski',
    'Puistokatu 6'
        'Routa',
    'Seilori',
    'Tellervo',
    'Timpuri',
    'Yliopistokatu',
  ];

  @override
  void initState() {
    super.initState();
    // Reset apartment state when the bottom sheet is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apartmentProvider =
          Provider.of<DreamApartmentProvider>(context, listen: false);
      apartmentProvider.resetDreamApartmentState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apartmentProvider = Provider.of<DreamApartmentProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (apartmentProvider.dreamApartmentState is DreamApartmentSuccess) {
        showSuccessDialog(context);
      } else if (apartmentProvider.dreamApartmentState
          is DreamApartmentFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                (apartmentProvider.dreamApartmentState as DreamApartmentFailure)
                    .message),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });

    return Container(
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height * 0.9,
      //   maxWidth: MediaQuery.of(context).size.width,
      // ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 26.0, 20.0, 26.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle for dragging the bottom sheet
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Title with arched stars
              _buildTitleWithStars('Define Your Dream Apartment 💫'),
              const SizedBox(height: 26),

              _buildDropdown(
                label: 'Location',
                value: _location,
                items: _locationOptions,
                onChanged: (value) {
                  setState(() {
                    _location = value!;
                  });
                },
                icon: Icons.location_pin,
              ),

              // Number of rooms as radio buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bedroom_parent_outlined,
                            size: 18, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        const Text('Number of rooms',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      children: _roomOptions.map((option) {
                        return InkWell(
                          onTap: () => setState(() => _rooms = option),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<String>(
                                  value: option,
                                  groupValue: _rooms,
                                  onChanged: (value) =>
                                      setState(() => _rooms = value!),
                                ),
                                Text(option,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              _buildDropdown(
                label: 'Apartment type',
                value: _apartmentType,
                items: _apartmentTypeOptions,
                onChanged: (value) {
                  setState(() {
                    _apartmentType = value!;
                    // Auto-set rooms to 1 for Studio or Shared Apartment
                    if (_apartmentType == 'Studio' ||
                        _apartmentType == 'Shared Apartment') {
                      _rooms = '1';
                    }
                  });
                },
                icon: Icons.apartment,
              ),
              _buildRangeSlider(
                label: 'Price range (€)',
                minValue: _minRent,
                maxValue: _maxRent,
                min: 0,
                max: 3000,
                onChanged: (RangeValues values) {
                  setState(() {
                    _minRent = values.start;
                    _maxRent = values.end;
                  });
                },
                icon: Icons.euro,
              ),
              _buildSlider(
                label: 'Floor',
                value: _floor,
                min: 0,
                max: 10,
                divisions: 9,
                onChanged: (value) {
                  setState(() => _floor = value);
                  // show a snackbar saying "0" means any floor
                  if (value == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('0 means you are fine with any floor'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                icon: Icons.layers,
              ),
              _buildSectionTitle('Additional Features'),
              _buildCheckbox(
                label: 'Sauna',
                value: _hasSauna,
                onChanged: (value) {
                  setState(() => _hasSauna = value!);
                },
                icon: Icons.hot_tub,
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: apartmentProvider.dreamApartmentState
                        is DreamApartmentLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () =>
                            _submitForm(context, apartmentProvider),
                        child: const Text(
                          'Notify me',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              // Add extra padding at the bottom for bottom navigation or system UI
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWithStars(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arched stars
          for (int i = 0; i < 8; i++) _buildStarInArc(i, 8),

          // Title text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarInArc(int index, int totalStars) {
    // Calculate position on an arc
    final angle = (math.pi * index) / (totalStars - 1);
    final radius = 80.0; // Radius of the arc

    // Calculate position
    final dx = radius * math.cos(angle);
    final dy = -30 - (radius * math.sin(angle) * 0.5); // Flattened arc

    // Star size varies based on position
    final starSize = 16.0 - (6.0 * math.sin(angle)).abs();

    return Positioned(
      left: MediaQuery.of(context).size.width / 2 + dx - (starSize / 2),
      top: dy,
      child: Icon(
        Icons.star,
        size: starSize,
        color: Color.fromARGB(
          255,
          255,
          (200 + (index * 7)) % 256, // Vary the green component
          100 + (index * 20) % 156, // Vary the blue component
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  hint: const Text('Select'),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeSlider({
    required String label,
    required double minValue,
    required double maxValue,
    required double min,
    required double max,
    required Function(RangeValues) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('€${minValue.toInt()}',
                  style: TextStyle(color: Colors.grey.shade700)),
              Expanded(
                child: RangeSlider(
                  values: RangeValues(minValue, maxValue),
                  min: min,
                  max: max,
                  divisions: 30,
                  labels: RangeLabels(
                      '€${minValue.toInt()}', '€${maxValue.toInt()}'),
                  onChanged: onChanged,
                ),
              ),
              Text('€${maxValue.toInt()}',
                  style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(min.toInt().toString(),
                  style: TextStyle(color: Colors.grey.shade700)),
              Expanded(
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  label: value.toInt().toString(),
                  onChanged: onChanged,
                ),
              ),
              Text(max.toInt().toString(),
                  style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          Icon(icon, size: 18, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _submitForm(
      BuildContext context, DreamApartmentProvider apartmentProvider) {
    if (_formKey.currentState!.validate()) {
      // Create the dream apartment model from form data
      final dreamApartment = DreamApartmentModel(
        location: _location,
        rooms: _rooms,
        apartmentType: _apartmentType,
        minRent: _minRent.toInt(),
        maxRent: _maxRent.toInt(),
        floor: _floor.toInt(),
        hasSauna: _hasSauna,
      );
      apartmentProvider.dreamApartment(dreamApartment);
    }
  }
}

// success dialogBox
void showSuccessDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: 80,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Notification Set!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We'll notify you when your dream apartment becomes available.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    // reset dream apartment state
                    Provider.of<DreamApartmentProvider>(context, listen: false)
                        .resetDreamApartmentState(),
                  },
                  child: const Text('Great!', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Example of how to show this bottom sheet
void showDreamApartmentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const DreamApartmentBottomSheet(),
  );
}
