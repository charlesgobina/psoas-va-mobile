import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/common/widgets/apartment_types_section.dart';
import 'package:psoas_va_mobile/src/features/apartments/ui/screens/widgets/custom_search.dart';
import 'package:psoas_va_mobile/src/features/authentication/services/auth_service.dart';
import '../../data/models/apartment_model.dart';
import '../../domain/providers/apartment_provider.dart';
import '../../domain/providers/apartment_states.dart';
import 'widgets/dream_apartment.dart';

class Apartments extends StatefulWidget {
  Apartments({super.key});
  final AuthService authService = AuthService();
  @override
  _ApartmentsState createState() => _ApartmentsState();
}

class _ApartmentsState extends State<Apartments> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApartmentProvider>(context, listen: false)
          .loadHiveApartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apartmentProvider = Provider.of<ApartmentProvider>(context);
    final apartmentState = apartmentProvider.apartmentState;
    final apartments = apartmentProvider.categorizedApartments;

    // Only filter when we have apartments to display
    final filteredEmptyApartments =
        apartments.entries.where((entry) => entry.value.isNotEmpty).toList();

    print("Filtered Empty Apartments: $filteredEmptyApartments");

    // Check if we have apartments to show regardless of the state
    final hasApartments =
        apartments.isNotEmpty && filteredEmptyApartments.isNotEmpty;

    return Scaffold(
      body: _buildBody(
        context,
        apartmentProvider,
        apartmentState,
        filteredEmptyApartments,
        hasApartments,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ApartmentProvider apartmentProvider,
    ApartmentStates apartmentState,
    List<MapEntry<String, List<dynamic>>> filteredEmptyApartments,
    bool hasApartments,
  ) {
    // Show loading indicator only when we're initially loading apartments
    if (apartmentState is ApartmentLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error only if we have an apartment loading failure
    if (apartmentState is ApartmentFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((apartmentState).message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                apartmentProvider.loadHiveApartments();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    // If we have no apartments to show but we're not in a loading or error state
    if (!hasApartments &&
        apartmentState is! ApartmentLoading &&
        apartmentState is! ApartmentFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No apartments found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                apartmentProvider.loadApartments();
              },
              child: const Text('Refresh Apartment'),
            ),
          ],
        ),
      );
    }

    // If we have apartments, show them regardless of whether we're in notify success/failure state
    return LiquidPullToRefresh(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      animSpeedFactor: 2.0,
      height: MediaQuery.of(context).size.height * 0.3,
      showChildOpacityTransition: true,
      onRefresh: () async {
        await apartmentProvider.loadApartments();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomSearchBar(
                  onTap: () {
                    GoRouter.of(context).go('/apartments/search');
                  },
                  onFilterTap: () {
                    showDreamApartmentBottomSheet(context);
                  },
                ),

                // Show notification status if applicable
                if (apartmentState is ApartmentNotifySuccess ||
                    apartmentState is ApartmentNotifyFailure)
                  _buildNotificationStatusBar(context, apartmentState),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                filteredEmptyApartments.map((entry) {
                  return ApartmentTypes(
                    categoryName: entry.key,
                    apartments: List<ApartmentModel>.from(entry.value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to display notification status
  Widget _buildNotificationStatusBar(
      BuildContext context, ApartmentStates state) {
    if (state is ApartmentNotifySuccess) {
      // Auto-dismiss after a few seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Provider.of<ApartmentProvider>(context, listen: false)
              .resetApartmentState();
        }
      });

      return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Notification set successfully for ${state.apartments.first.address}',
                style: const TextStyle(color: Colors.green),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.green),
              onPressed: () {
                Provider.of<ApartmentProvider>(context, listen: false)
                    .resetApartmentState();
              },
            ),
          ],
        ),
      );
    } else if (state is ApartmentNotifyFailure) {
      return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Failed to set notification: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                Provider.of<ApartmentProvider>(context, listen: false)
                    .resetApartmentState();
              },
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
