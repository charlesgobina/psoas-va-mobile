import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_provider.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_states.dart';
import 'package:pulsator/pulsator.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final apartmentProvider = Provider.of<ApartmentProvider>(context);
    return GestureDetector(
      onTap: () => _showApartmentDetails(context, apartment, apartmentProvider),
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
                          BoxShadow(
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
                    Text(
                      apartment.information.isNotEmpty == true
                          ? apartment.information
                          : 'No additional information',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

Future<void> _launchUrl(Uri url) async {
  try {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}

void _showApartmentDetails(BuildContext context, ApartmentModel apartment,
    ApartmentProvider apartmentProvider) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),

                // Image carousel
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    itemCount: apartment.imageList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap: () => _showFullScreenImage(
                              context, apartment.imageList[index]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              apartment.imageList[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.home,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              apartment.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          apartment.reserveButton != ''
                              ? _featureChip(context, 'Available')
                              : const PulseIcon(
                                  icon: Icons.notifications,
                                  pulseColor: Colors.green,
                                  iconColor: Colors.white,
                                  iconSize: 30,
                                  innerSize: 54,
                                  pulseSize: 96,
                                  pulseCount: 4,
                                  pulseDuration: Duration(seconds: 4),
                                ),
                        ],
                      ),

                      const SizedBox(height: 8.0),

                      // Location with icon
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            apartment.parentLocation,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16.0),

                      // Apartment type and size
                      Row(
                        children: [
                          _detailItem(
                              context,
                              Icons.apartment,
                              'Type',
                              apartment.apartmentType.isNotEmpty == true
                                  ? apartment.apartmentType
                                  : 'N/A'),
                          _detailItem(context, Icons.door_front_door, 'Rooms',
                              apartment.rooms.toStringAsPrecision(1)),
                          _detailItem(context, Icons.square_foot, 'Size',
                              '${apartment.sizeM2} m²'),
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      // Floor, vacant from
                      Row(
                        children: [
                          _detailItem(
                              context,
                              Icons.layers,
                              'Floor',
                              apartment.floor.isNotEmpty == true
                                  ? apartment.floor
                                  : 'N/A'),
                          _detailItem(
                              context,
                              Icons.calendar_today,
                              'Availability',
                              apartment.vacantFrom.isNotEmpty == true
                                  ? apartment.vacantFrom
                                  : 'N/A'),
                          _detailItem(context, Icons.payments_outlined, 'Rent',
                              '${apartment.rent.toStringAsFixed(2)} €/month'),
                        ],
                      ),

                      const SizedBox(height: 24.0),
                      Text(
                        'Apartment Features',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12.0),

                      // Features grid - improved alignment with rows and columns
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Floors',
                                    apartment.floorMaterial.isNotEmpty == true
                                        ? apartment.floorMaterial
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Window facing',
                                    apartment.livingRoomWindow.isNotEmpty ==
                                            true
                                        ? apartment.livingRoomWindow
                                        : 'N/A'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Balcony',
                                    apartment.balcony.isNotEmpty == true
                                        ? apartment.balcony
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Sauna',
                                    apartment.sauna.isNotEmpty == true
                                        ? apartment.sauna
                                        : 'N/A'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Stove',
                                    apartment.stove.isNotEmpty == true
                                        ? apartment.stove
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Washing machine',
                                    apartment.placeForWashingMachine
                                        ? 'Yes'
                                        : 'No'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Dishwasher',
                                    apartment.placeForDishwasher
                                        ? 'Yes'
                                        : 'No'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: _featureRow(
                                    context,
                                    'Gender',
                                    apartment.gender.isNotEmpty
                                        ? apartment.gender
                                        : 'N/A'),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16.0),
                      Divider(color: Colors.grey.withOpacity(0.3)),
                      const SizedBox(height: 8.0),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: apartment.reserveButton != ''
                                  ? () {
                                      final Uri apartmentUrl =
                                          Uri.parse(apartment.reserveButton);
                                      _launchUrl(apartmentUrl);
                                    }
                                  : () async {
                                      await apartmentProvider.notifyMe(apartment);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              icon: const Icon(
                                Icons.bookmark_outline,
                                color: Colors.white,
                              ),
                              label: apartmentProvider.apartmentState is ApartmentNotifyLoading ?
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                  :
                                Text(
                                apartment.reserveButton != ''
                                    ? 'Reserve Now'
                                    : 'Notify me',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void _showFullScreenImage(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 3.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child:
                        Icon(Icons.broken_image, size: 100, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _featureRow(BuildContext context, String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        Icons.check_circle_outline,
        size: 16.0,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 6.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _detailItem(
    BuildContext context, IconData icon, String label, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon,
                size: 16.0, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 2.0),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _featureChip(BuildContext context, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    ),
  );
}
