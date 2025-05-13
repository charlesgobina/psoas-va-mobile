import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_states.dart';
import 'package:pulsator/pulsator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/apartment_card_utils/show_apartment_details.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final apartmentProvider = Provider.of<ApartmentProvider>(context);
    return GestureDetector(
      onTap: () => showApartmentDetails(context, apartment, apartmentProvider),
      child: Container(
        width: 240.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Card(
          elevation: 4.0,
          shadowColor: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Apartment Image with overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: Image.network(
                      apartment.imageList.last,
                      height: 150.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 140.0,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: const Center(
                            child:
                                Icon(Icons.home, size: 50, color: Colors.grey)),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 140.0,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  // Gradient overlay for better text contrast
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Apartment price tag
                  Positioned(
                    bottom: 8.0,
                    right: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${apartment.rent.toStringAsFixed(2)} €/month',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                  // Available badge (optional)
                  apartment.reserveButton != ''
                      ? Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Available',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                        )
                      : Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 175, 142, 76)
                                  .withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Unavailable',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                        )
                ],
              ),
              // Apartment Details
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 12.0, right: 12.0, bottom: 4.0),
                child: Text(
                  apartment.address,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14.0, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        apartment.parentLocation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Row(
                    children: [
                    const Icon(Icons.info, size: 14.0, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                      apartment.information.isNotEmpty
                        ? apartment.information.length > 21
                          ? '${apartment.information.substring(0, 21)}...'
                          : apartment.information
                        : 'No additional information',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
