import 'package:flutter/material.dart';
import 'package:pulsator/pulsator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../features/apartments/data/models/apartment_model.dart';
import '../../../features/apartments/domain/providers/apartment_provider.dart';
import '../../../features/apartments/domain/providers/apartment_states.dart';
import 'misc_utils.dart';

void showApartmentDetails(BuildContext context, ApartmentModel apartment,
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
                          onTap: () => showFullScreenImage(
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
                              ? featureChip(context, 'Available')
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
                          detailItem(
                              context,
                              Icons.apartment,
                              'Type',
                              apartment.apartmentType.isNotEmpty == true
                                  ? apartment.apartmentType
                                  : 'N/A'),
                          detailItem(context, Icons.door_front_door, 'Rooms',
                              apartment.rooms.toStringAsPrecision(1)),
                          detailItem(context, Icons.square_foot, 'Size',
                              '${apartment.sizeM2} m²'),
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      // Floor, vacant from
                      Row(
                        children: [
                          detailItem(
                              context,
                              Icons.layers,
                              'Floor',
                              apartment.floor.isNotEmpty == true
                                  ? apartment.floor
                                  : 'N/A'),
                          detailItem(
                              context,
                              Icons.calendar_today,
                              'Availability',
                              apartment.vacantFrom.isNotEmpty == true
                                  ? apartment.vacantFrom
                                  : 'N/A'),
                          detailItem(context, Icons.payments_outlined, 'Rent',
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
                                child: featureRow(
                                    context,
                                    'Floors',
                                    apartment.floorMaterial.isNotEmpty == true
                                        ? apartment.floorMaterial
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: featureRow(
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
                                child: featureRow(
                                    context,
                                    'Balcony',
                                    apartment.balcony.isNotEmpty == true
                                        ? apartment.balcony
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: featureRow(
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
                                child: featureRow(
                                    context,
                                    'Stove',
                                    apartment.stove.isNotEmpty == true
                                        ? apartment.stove
                                        : 'N/A'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: featureRow(
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
                                child: featureRow(
                                    context,
                                    'Dishwasher',
                                    apartment.placeForDishwasher
                                        ? 'Yes'
                                        : 'No'),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: featureRow(
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

                      // Action buttons - IMPROVED SECTION
                      AnimatedBuilder(
                        animation: apartmentProvider,
                        builder: (context, _) {
                          // Check if the user is already notified for this apartment
                          final bool isAlreadyNotified =
                              apartmentProvider.isNotified(apartment.address);
                          final bool isReservable = apartment.reserveButton != '';
                          
                          // Handle button style and text based on apartment state
                          if (isReservable) {
                            // Reserve button for available apartments
                            return _buildReserveButton(context, apartment);
                          } else {
                            // Notification button for unavailable apartments
                            return _buildNotificationButton(
                              context, 
                              apartment, 
                              apartmentProvider, 
                              isAlreadyNotified
                            );
                          }
                        },
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

// Helper method to build the reservation button
Widget _buildReserveButton(BuildContext context, ApartmentModel apartment) {
  return ElevatedButton.icon(
    onPressed: () {
      final Uri apartmentUrl = Uri.parse(apartment.reserveButton);
      launchUrl(apartmentUrl);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    icon: const Icon(
      Icons.open_in_new,
      color: Colors.white,
    ),
    label: const Text(
      'Reserve Now',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Helper method to build the notification button with proper state handling
Widget _buildNotificationButton(
  BuildContext context, 
  ApartmentModel apartment, 
  ApartmentProvider apartmentProvider,
  bool isAlreadyNotified
) {
  // Handle different states for the notification button
  if (apartmentProvider.apartmentState is ApartmentNotifyLoading) {
    // Loading state
    return ElevatedButton(
      onPressed: null, // Disable button while loading
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Setting notification...',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  } else if (apartmentProvider.apartmentState is ApartmentNotifySuccess &&
      (apartmentProvider.apartmentState as ApartmentNotifySuccess)
          .apartments
          .any((apt) => apt.address == apartment.address)) {
    // Success state - just set notification
    return ElevatedButton.icon(
      onPressed: () {
        // Reset to initial state to allow setting notification again if needed
        apartmentProvider.resetApartmentState();
        // Show a confirmation dialog if they want to remove notification
        _showRemoveNotificationDialog(context, apartment, apartmentProvider);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      icon: const Icon(
        Icons.notifications_active,
        color: Colors.white,
      ),
      label: const Text(
        'Notification Set',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else if (apartmentProvider.apartmentState is ApartmentNotifyFailure) {
    // Error state
    return Column(
      children: [
        Text(
          'Failed to set notification',
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {
            // Reset error state and try again
            apartmentProvider.resetApartmentState();
            apartmentProvider.notifyMe(apartment);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          label: const Text(
            'Try Again',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  } else {
    // Default state (including ApartmentInitial)
    return ElevatedButton.icon(
      onPressed: () async {
        try {
          await apartmentProvider.notifyMe(apartment);
          // Show success snackbar
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notification set successfully!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } catch (e) {
          // Error handling is done in the ApartmentNotifyFailure state above
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isAlreadyNotified 
            ? Colors.green 
            : Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      icon: Icon(
        isAlreadyNotified ? Icons.notifications_active : Icons.notifications_outlined,
        color: Colors.white,
      ),
      label: Text(
        isAlreadyNotified ? 'Notification Active' : 'Notify Me',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Helper method to show a dialog when trying to remove a notification
void _showRemoveNotificationDialog(
  BuildContext context,
  ApartmentModel apartment,
  ApartmentProvider apartmentProvider,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Remove Notification'),
        content: Text('Do you want to stop receiving notifications for ${apartment.address}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Keep Notifications'),
          ),
          TextButton(
            onPressed: () async {
              // Here you would add logic to remove the notification
              // This requires adding a new method to your ApartmentProvider
              // await apartmentProvider.removeNotification(apartment);
              
              // For now, just close the dialog
              Navigator.of(context).pop();
              
              // Show confirmation
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification removed'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Remove'),
          ),
        ],
      );
    },
  );
}