import 'package:flutter/material.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';
import 'apartment_cards.dart';

class ApartmentTypes extends StatelessWidget {
  final String categoryName;
  final List<ApartmentModel> apartments;

  const ApartmentTypes({
    super.key,
    required this.categoryName,
    required this.apartments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    categoryName.toLowerCase() == "shared" ? Icons.people :
                    categoryName.toLowerCase() == "family" ? Icons.family_restroom :
                    categoryName.toLowerCase() == "studio" ? Icons.apartment :
                    Icons.home, // default fallback
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categoryName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // show number of apartments available
              Text(
              '${apartments.where((apt) => apt.reserveButton != "").length} available',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260, // Constrained height for horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              return ApartmentCard(apartment: apartments[index]);
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}