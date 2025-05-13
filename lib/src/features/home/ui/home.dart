import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/common/app_preferences.dart';
import 'package:psoas_va_mobile/src/features/apartments/ui/screens/widgets/dream_apartment.dart';
import '../../authentication/ui/providers/auth_provider.dart';

class Home extends StatelessWidget {
  // lietally housing the bottom nav bar
  final Widget child;
  const Home({super.key, required this.child});
  static const List<String> _routes = [
    '/apartments',
    '/profile',
    '/sublease',
    '/settings'
  ];

  @override
  Widget build(BuildContext context) {
    var currentIndex =
        _routes.indexOf(GoRouterState.of(context).uri.toString());

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'VAPASUN',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            actions: [
              // notification icon
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      size: 24,
                    ),
                    style: IconButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      // Add notification handling logic here
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final user = authProvider.user;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      backgroundImage:
                          user?.photoURL != null && user!.photoURL!.isNotEmpty
                              ? NetworkImage(user.photoURL!)
                              : null,
                      child: user?.photoURL == null || user!.photoURL!.isEmpty
                          ? Text(
                              user?.displayName != null &&
                                      user!.displayName!.isNotEmpty
                                  ? user.displayName!
                                      .substring(
                                          0, min(2, user.displayName!.length))
                                      .toUpperCase()
                                  : '??',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
          body: child,
          floatingActionButton: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing effect circle
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                onEnd: () {
                  // Force rebuild to restart animation
                  (context as Element).markNeedsBuild();
                },
                builder: (context, value, child) {
                  return Opacity(
                    opacity: 1.0 - value,
                    child: Transform.scale(
                      scale: 1.0 + (value * 0.3),
                      child: Container(
                        width: 56.0,
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Actual FAB
              FloatingActionButton(
                onPressed: () {
                  AppPreferences().clearAll();
                  // show a bottom sheet
                  // showDreamApartmentBottomSheet(context);
                },
                tooltip: 'Dream Apartment',
                child: const Icon(Icons.add_home_rounded),
              ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            height: 60.0,
            selectedIndex: currentIndex == -1 ? 0 : currentIndex,
            onDestinationSelected: (int index) {
              GoRouter.of(context).go(_routes[index]);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.apartment_outlined),
                label: 'Apartments',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
              NavigationDestination(
                icon: Icon(Icons.moving_outlined),
                label: 'Sublease',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_applications_outlined),
                label: 'Settings',
              ),
            ],
          )),
    );
  }
}
