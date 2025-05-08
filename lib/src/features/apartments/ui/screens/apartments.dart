import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/common/widgets/apartment_types_section.dart';
import 'package:psoas_va_mobile/src/features/authentication/services/auth_service.dart';
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

    final apartments = apartmentProvider.categorizedApartments;
    print('Apartments available: $apartments');

    final filteredEmptyApartments = apartmentProvider
        .categorizedApartments.entries
        .where((entry) => entry.value.isNotEmpty)
        .toList();

    print('Filtered non-empty apartments: $filteredEmptyApartments');
    // REMOVE THIS LINE: apartmentProvider.categorizedApartments.clear();

    return Scaffold(
      body: apartmentProvider.apartmentState is ApartmentLoading
          ? const Center(child: CircularProgressIndicator())
          : apartmentProvider.apartmentState is ApartmentFailure
              ? Center(
                  child: Text(
                      (apartmentProvider.apartmentState as ApartmentFailure)
                          .message))
              : apartmentProvider.apartmentState is ApartmentSuccess
                  ? LiquidPullToRefresh(
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
                            // user salutation
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 24.0, 16.0, 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hei, ${widget.authService.currentUser!.displayName!.split(' ')[0]} 👋',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Looking for an apartment?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .shadow,
                                              fontSize: 21,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      16.0, 0, 16.0, 0),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      hintText: 'Search apartments...',
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                      prefixIcon: Icon(Icons.search,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.filter_list,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        onPressed: () {
                                          // show a bottom sheet
                                          showDreamApartmentBottomSheet(context,
                                              isFilter: true);
                                        },
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12),
                                    ),
                                    onChanged: (value) {
                                      // TODO: Implement search functionality
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Search bar section
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                filteredEmptyApartments.map((entry) {
                                  return ApartmentTypes(
                                    categoryName: entry.key,
                                    apartments: entry.value,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: const Center(
                        child: Text('No apartments found'),
                      ),
                    ),
    );
  }
}
