// import 'package:flutter/material.dart';
// import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';

// void showFilterBottomSheet(BuildContext context, {
//   required Function(Map<String, dynamic>) onApplyFilters,
//   Map<String, dynamic>? currentFilters,
// }) {
//   // Initial filter values - use current filters if provided
//   final filters = currentFilters ?? {
//     'priceRange': const RangeValues(0, 2000),
//     'sizeRange': const RangeValues(0, 100),
//     'rooms': <String>[],
//     'availableOnly': false,
//     'features': {
//       'balcony': false,
//       'sauna': false,
//       'dishwasher': false,
//       'washingMachine': false,
//     }
//   };

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Theme.of(context).colorScheme.surface,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//     ),
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return DraggableScrollableSheet(
//             initialChildSize: 0.7,
//             minChildSize: 0.4,
//             maxChildSize: 0.9,
//             expand: false,
//             builder: (context, scrollController) {
//               return SingleChildScrollView(
//                 controller: scrollController,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Drag handle
//                       Center(
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(vertical: 8.0),
//                           width: 40,
//                           height: 4,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(2.0),
//                           ),
//                         ),
//                       ),
                      
//                       // Title
//                       Text(
//                         'Filter Apartments',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 24.0),
                      
//                       // Price Range
//                       Text(
//                         'Price Range',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       RangeSlider(
//                         values: filters['priceRange'],
//                         min: 0,
//                         max: 2000,
//                         divisions: 20,
//                         labels: RangeLabels(
//                           '€${filters['priceRange'].start.round()}',
//                           '€${filters['priceRange'].end.round()}'
//                         ),
//                         onChanged: (RangeValues values) {
//                           setState(() {
//                             filters['priceRange'] = values;
//                           });
//                         },
//                       ),
                      
//                       const SizedBox(height: 16.0),
                      
//                       // Size Range
//                       Text(
//                         'Size Range (m²)',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       RangeSlider(
//                         values: filters['sizeRange'],
//                         min: 0,
//                         max: 100,
//                         divisions: 20,
//                         labels: RangeLabels(
//                           '${filters['sizeRange'].start.round()} m²',
//                           '${filters['sizeRange'].end.round()} m²'
//                         ),
//                         onChanged: (RangeValues values) {
//                           setState(() {
//                             filters['sizeRange'] = values;
//                           });
//                         },
//                       ),
                      
//                       const SizedBox(height: 16.0),
                      
//                       // Room types
//                       Text(
//                         'Room Types',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       const SizedBox(height: 8.0),
//                       Wrap(
//                         spacing: 8.0,
//                         children: ['Studio', '1 Room', '2 Room', '3+ Room'].map((type) {
//                           final isSelected = filters['rooms'].contains(type);
//                           return FilterChip(
//                             label: Text(type),
//                             selected: isSelected,
//                             onSelected: (selected) {
//                               setState(() {
//                                 if (selected) {
//                                   filters['rooms'].add(type);
//                                 } else {
//                                   filters['rooms'].remove(type);
//                                 }
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
                      
//                       const SizedBox(height: 16.0),
                      
//                       // Available only
//                       SwitchListTile(
//                         title: Text(
//                           'Available apartments only',
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                         value: filters['availableOnly'],
//                         onChanged: (value) {
//                           setState(() {
//                             filters['availableOnly'] = value;
//                           });
//                         },
//                         contentPadding: EdgeInsets.zero,
//                       ),
                      
//                       const SizedBox(height: 16.0),
                      
//                       // Features
//                       Text(
//                         'Features',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       const SizedBox(height: 8.0),
                      
//                       CheckboxListTile(
//                         title: Text('Balcony'),
//                         contentPadding: EdgeInsets.zero,
//                         dense: true,
//                         value: filters['features']['balcony'],
//                         onChanged: (value) {
//                           setState(() {
//                             filters['features']['balcony'] = value;
//                           });
//                         },
//                       ),
                      
//                       CheckboxListTile(
//                         title: Text('Sauna'),
//                         contentPadding: EdgeInsets.zero,
//                         dense: true,
//                         value: filters['features']['sauna'],
//                         onChanged: (value) {
//                           setState(() {
//                             filters['features']['sauna'] = value;
//                           });
//                         },
//                       ),
                      
//                       CheckboxListTile(
//                         title: Text('Dishwasher'),
//                         contentPadding: EdgeInsets.zero,
//                         dense: true,
//                         value: filters['features']['dishwasher'],
//                         onChanged: (value) {
//                           setState(() {
//                             filters['features']['dishwasher'] = value;
//                           });
//                         },
//                       ),
                      
//                       CheckboxListTile(
//                         title: const Text('Washing Machine'),
//                         contentPadding: EdgeInsets.zero,
//                         dense: true,
//                         value: filters['features']['washingMachine'],
//                         onChanged: (value) {
//                           setState(() {
//                             filters['features']['washingMachine'] = value;
//                           });
//                         },
//                       ),
                      
//                       const SizedBox(height: 24.0),
                      
//                       // Action buttons
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                               ),
//                               child: Text('Cancel'),
//                             ),
//                           ),
//                           const SizedBox(width: 12.0),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 onApplyFilters(filters);
//                                 Navigator.pop(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Theme.of(context).colorScheme.primary,
//                                 foregroundColor: Theme.of(context).colorScheme.onPrimary,
//                                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                               ),
//                               child: Text('Apply Filters'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }


// void filterApartments(Map<String, dynamic> filters, List<ApartmentModel> apartments) {
//   // Filter apartments based on the provided filters
//   final filteredApartments = apartments.where((apartment) {
//     // Filter by price
//     final price = apartment.rent;
//     if (price < filters['priceRange'].start || price > filters['priceRange'].end) {
//       return false;
//     }

//     // Filter by size
//     final size = apartment.size;
//     if (size < filters['sizeRange'].start || size > filters['sizeRange'].end) {
//       return false;
//     }

//     // Filter by room types
//     if (filters['rooms'].isNotEmpty && !filters['rooms'].contains(apartment.roomType)) {
//       return false;
//     }

//     // Filter by availability
//     if (filters['availableOnly'] && !apartment.available) {
//       return false;
//     }

//     // Filter by features
//     if (filters['features']['balcony'] && !apartment.features.balcony) {
//       return false;
//     }
//     if (filters['features']['sauna'] && !apartment.features.sauna) {
//       return false;
//     }
//     if (filters['features']['dishwasher'] && !apartment.features.dishwasher) {
//       return false;
//     }
//     if (filters['features']['washingMachine'] && !apartment.features.washingMachine) {
//       return false;
//     }

//     return true;
//   }).toList();

//   // Update the UI with the filtered apartments
//   setState(() {
//     _filteredApartments = filteredApartments;
//   });
// }