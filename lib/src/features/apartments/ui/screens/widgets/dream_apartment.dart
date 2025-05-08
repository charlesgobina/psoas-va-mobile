import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/dream_apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/dream_apartment_provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/dream_apartment_states.dart';

class DreamApartmentBottomSheet extends StatefulWidget {
  final bool isFilter;
  const DreamApartmentBottomSheet({super.key, this.isFilter = false});

  @override
  State<DreamApartmentBottomSheet> createState() =>
      _DreamApartmentBottomSheetState();
}

class _DreamApartmentBottomSheetState extends State<DreamApartmentBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  // Selected filters
  String _houseType = 'All of them';
  String _rooms = '4 Room';
  String _size = 'Up to 100';
  double _minRent = 300;
  double _maxRent = 1000;
  String _location = 'Tellervo';

  // Filter options
  final List<String> _houseTypeOptions = [
    'All of them',
    'Studio',
    'Family',
    'Shared'
  ];

  final List<String> _roomOptions = [
    'Studio',
    '3 and less',
    '4 Rooms',
    '6 Rooms',
  ];

  final List<String> _sizeOptions = [
    'Up to 30',
    'Up to 50',
    '51+',
  ];

  final List<String> _locationOptions = [
    'Aro',
    'Aurora',
    'Domus Botnica',
    'Kumpula',
    'Kalervo',
    'Purseri',
    'Kaski',
    'Puistokatu 6',
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

              // Filter Title
              Center(
                child: Text(
                  widget.isFilter ? 'Filter' : 'Dream Apartment',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // House Type
              _buildFilterHeader('House Type'),
              const SizedBox(height: 12),
              _buildToggleButtonsRow(_houseTypeOptions, _houseType, (value) {
                setState(() => _houseType = value);
              }),
              const SizedBox(height: 24),

              // Rooms
              _buildFilterHeader('Rooms'),
              const SizedBox(height: 12),
              _buildToggleButtonsRow(_roomOptions, _rooms, (value) {
                setState(() => _rooms = value);
              }),
              const SizedBox(height: 24),

              // Size
              _buildFilterHeader('Size (M²)'),
              const SizedBox(height: 12),
              _buildToggleButtonsRow(_sizeOptions, _size, (value) {
                setState(() => _size = value);
              }),
              const SizedBox(height: 24),

              // Price Range
              _buildFilterHeader('Price'),
              const SizedBox(height: 12),
              _buildPriceRangeSlider(),
              const SizedBox(height: 24),

              // Location
              _buildFilterHeader('Location'),
              const SizedBox(height: 12),
              _buildLocationSearchField(),
              const SizedBox(height: 32),

              // Action buttons
              _buildActionButtons(context, apartmentProvider),

              // Add extra padding at the bottom
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildToggleButtonsRow(
      List<String> options, String selectedValue, Function(String) onSelected) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          final isSelected = selectedValue == option;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => onSelected(option),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF33383F) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        isSelected ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbColor: Colors.black,
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.grey.shade300,
            overlayColor: Colors.black.withOpacity(0.1),
          ),
          child: RangeSlider(
            values: RangeValues(_minRent, _maxRent),
            min: 0,
            max: 3000,
            divisions: 30,
            onChanged: (RangeValues values) {
              setState(() {
                _minRent = values.start;
                _maxRent = values.end;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '€${_minRent.toInt()}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              '€${_maxRent.toInt()}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSearchField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isExpanded: true,
            value: _location,
            icon: const Icon(Icons.keyboard_arrow_down),
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            items: _locationOptions.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _location = newValue;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, DreamApartmentProvider apartmentProvider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onPressed: () {
              // Reset all filters
              setState(() {
                _houseType = 'All of them';
                _rooms = '4 Room';
                _size = 'Up to 50';
                _minRent = 300;
                _maxRent = 1000;
                _location = 'Tellervo';
              });
            },
            child: const Text('Reset'),
          ),
        ),
        const SizedBox(width: 12),
        widget.isFilter
            ? Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33383F),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => _applyFilter(context, apartmentProvider),
                  child: apartmentProvider.dreamApartmentState
                          is DreamApartmentLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Apply Filter'),
                ),
              )
            : Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33383F),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => _submitForm(context, apartmentProvider),
                  child: apartmentProvider.dreamApartmentState
                          is DreamApartmentLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Notify Me'),
                ),
              ),
      ],
    );
  }

  void _applyFilter(
      BuildContext context, DreamApartmentProvider apartmentProvider) {
    if (_formKey.currentState!.validate()) {
      // Convert room string to appropriate format
      String rooms = _rooms;
      if (_rooms == '3 and less')
        rooms = '3';
      else if (_rooms == '4 Room')
        rooms = '4';
      else if (_rooms == '6 Room')
        rooms = '4+';
      else if (_rooms == 'Studio') rooms = '1';

      // Convert size to appropriate format
      int? floor = 0; // Default to any floor

      // Parse apartment type from house type
      String apartmentType = 'Any';
      if (_houseType == 'All of them') {
        apartmentType = 'Any';
      } else if (_houseType == 'Studio') {
        apartmentType = 'Studio Apartment';
      } else if (_houseType == 'Family') {
        apartmentType = 'Family Apartment';
      } else if (_houseType == 'Shared') {
        apartmentType = 'Shared Apartment';
      }

      // Apartment size
      String dreamApartmentSize = '0';
      if (_size == 'Up to 30') {
        dreamApartmentSize = '30';
      } else if (_size == 'Up to 50') {
        dreamApartmentSize = '50';
      } else if (_size == '51+') {
        dreamApartmentSize = '51';
      }

      // Create the dream apartment model from form data
      final dreamApartment = DreamApartmentModel(
        location: _location,
        rooms: rooms,
        apartmentType: apartmentType,
        minRent: _minRent.toInt(),
        maxRent: _maxRent.toInt(),
        size: int.parse(dreamApartmentSize),
        hasSauna: false, // Removed from UI as per design
      );

      print('filter applied: $dreamApartment'); 
    }
  }

  void _submitForm(
      BuildContext context, DreamApartmentProvider apartmentProvider) {
    if (_formKey.currentState!.validate()) {
      // Convert room string to appropriate format
      String rooms = _rooms;
      if (_rooms == '3 and less')
        rooms = '3';
      else if (_rooms == '4 Room')
        rooms = '4';
      else if (_rooms == '6 Room')
        rooms = '4+';
      else if (_rooms == 'Studio') rooms = '1';

      // Convert size to appropriate format
      int? floor = 0; // Default to any floor

      // Parse apartment type from house type
      String apartmentType = 'Any';
      if (_houseType == 'All of them') {
        apartmentType = 'Any';
      } else if (_houseType == 'Studio') {
        apartmentType = 'Studio Apartment';
      } else if (_houseType == 'Family') {
        apartmentType = 'Family Apartment';
      } else if (_houseType == 'Shared') {
        apartmentType = 'Shared Apartment';
      }

      // Apartment size
      String dreamApartmentSize = '0';
      if (_size == 'Up to 30') {
        dreamApartmentSize = '30';
      } else if (_size == 'Up to 50') {
        dreamApartmentSize = '50';
      } else if (_size == '51+') {
        dreamApartmentSize = '51';
      }

      // Create the dream apartment model from form data
      final dreamApartment = DreamApartmentModel(
        location: _location,
        rooms: rooms,
        apartmentType: apartmentType,
        minRent: _minRent.toInt(),
        maxRent: _maxRent.toInt(),
        size: int.parse(dreamApartmentSize),
        hasSauna: false, // Removed from UI as per design
      );
      apartmentProvider.dreamApartment(dreamApartment);
    }
  }
}

// Success dialog box
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
                "Filter Applied!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We'll show you apartments that match your criteria.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33383F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<DreamApartmentProvider>(context, listen: false)
                        .resetDreamApartmentState();
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

// Function to show the bottom sheet (dream apartment mode)
void showDreamApartmentBottomSheet(BuildContext context, {bool isFilter = false}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DreamApartmentBottomSheet(
      isFilter: isFilter,
    ),
  );
}
