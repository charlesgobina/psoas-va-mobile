import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoas_va_mobile/src/features/authentication/ui/providers/auth_states.dart';

import '../../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  AuthStates _authState = AuthInitial();
  AuthStates get authState => _authState;


  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _init();
  }

  void _init() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _authState = AuthLoading();
    notifyListeners();
  
    try {
      final User? user = await _authService.signInWithGoogle();
      if (user != null) {
        // write user data to firestore
        await _authService.writeUserDataToFirestore(user);
        _authState = AuthSuccess(user);
      } else {
        _authState = AuthFailure("Sign-In Failed");
      }
    } catch (e) {
      _authState = AuthFailure("Sign-In Failed");
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _authState = AuthLoading();
    notifyListeners();

    try {
      await _authService.signOut();
      _authState = AuthInitial();
    } catch (e) {
      _authState = AuthFailure("Sign-Out Failed");
    } finally {
      notifyListeners();
    }
  }
}