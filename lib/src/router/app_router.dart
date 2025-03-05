import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:psoas_va_mobile/src/features/apartments/ui/screens/apartments.dart';
import 'package:psoas_va_mobile/src/features/authentication/services/auth_service.dart';
import 'package:psoas_va_mobile/src/features/profile/ui/screens/profile.dart';
import 'package:psoas_va_mobile/src/features/settings/ui/screens/settings.dart';
import 'package:psoas_va_mobile/src/features/sublease/ui/screens/sublease.dart';
import '../../main.dart';
import '../features/authentication/ui/screens/signin_screen.dart';
import '../features/home/ui/home.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/wrapper',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Home(
          child: child,
        ); // Persistent bottom nav
      },
      routes: [
        GoRoute(
          // initial route
          path: '/wrapper',
          name: 'wrapper',
          builder: (context, state) => const AuthWrapper(),
        ),
        GoRoute(
          path: '/apartments',
          name: 'apartments',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: Apartments(),  
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
          opacity: animation,
          child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const Profile(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const Settings(),
            transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
              return FadeTransition(
          opacity: animation,
          child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: '/sublease',
          name: 'sublease',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const Sublease(),
            transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
              return FadeTransition(
          opacity: animation,
          child: child,
              );
            },
          ),
        ),
      ],
    ),

    // sign in route
    GoRoute(
      path: '/signin',
      name: 'signin',
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
