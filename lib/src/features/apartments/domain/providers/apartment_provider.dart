import 'package:flutter/material.dart';
import 'package:psoas_va_mobile/src/common/app_preferences.dart';
import 'dart:developer' as dev;
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/apartment_states.dart';

import '../../data/models/dream_apartment_model.dart';
import '../../data/repo/apartment_repo.dart';

class ApartmentProvider with ChangeNotifier {
  final ApartmentRepo repository;
  ApartmentStates _apartmentState = ApartmentInitial();
  AppPreferences appPreferences = AppPreferences();
  ApartmentStates get apartmentState => _apartmentState;

  ApartmentProvider({required this.repository});

  final Map<String, List<ApartmentModel>> _categorizedApartments = {};
  String? _errorMessage;
  Map<String, List<ApartmentModel>> get categorizedApartments =>
      _categorizedApartments;
  String? get errorMessage => _errorMessage;

  Future<void> loadApartments() async {
    dev.log('LOADING APARTMENTS');
    _apartmentState = ApartmentLoading();
    notifyListeners();

    try {
      // get apartments from hive storage
      final categorizedApts = await repository.getApartments();
      dev.log("Categorized apartments: $categorizedApts");
      _categorizedApartments.clear();
      _categorizedApartments.addAll(categorizedApts);
      _apartmentState = ApartmentSuccess(_categorizedApartments);
    } catch (e) {
      dev.log("Error loading apartments: ${e.toString()}");
      _apartmentState = ApartmentFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  // load apartments from hive storage
  Future<void> loadHiveApartments() async {
    dev.log('LOADING APARTMENTS FROM HIVE');
    _apartmentState = ApartmentLoading();
    notifyListeners();

    try {
      // get apartments from hive storage
      final categorizedApts = await repository.getHiveApartments();
      dev.log("Categorized apartments: $categorizedApts");
      _categorizedApartments.clear();
      _categorizedApartments.addAll(categorizedApts);
      _apartmentState = ApartmentSuccess(_categorizedApartments);
    } catch (e) {
      dev.log("Error loading apartments: ${e.toString()}");
      _apartmentState = ApartmentFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  // notify me function - modified to preserve apartment data
  Future<void> notifyMe(ApartmentModel apartment) async {
    dev.log('Activating notify me for apartment: ${apartment.address}');
    // Store the current state to preserve apartment data
    ApartmentStates previousState = _apartmentState;
    
    _apartmentState = ApartmentNotifyLoading();
    notifyListeners();
    
    try {
      // First save the notification preference to Firestore
      await repository.notifyMe(apartment);
      
      // Then update local preferences to track notification status
      await appPreferences.setNotifyMe(apartment.address, true);
      
      // Update state to success but keep apartment data
      _apartmentState = ApartmentNotifySuccess([apartment]);
      dev.log('Successfully set notification for apartment: ${apartment.address}');
    } catch (e) {
      dev.log("Error setting notification: ${e.toString()}");
      _apartmentState = ApartmentNotifyFailure(e.toString());
      // Re-throw to allow UI to handle the error
      throw Exception("Failed to set notification: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  // Remove notification for an apartment
  Future<void> removeNotification(ApartmentModel apartment) async {
    dev.log('Removing notification for apartment: ${apartment.address}');
    // Store current state
    ApartmentStates previousState = _apartmentState;
    
    _apartmentState = ApartmentNotifyLoading();
    notifyListeners();
    
    try {
      // Implementation would depend on your repository
      // This is placeholder for the actual implementation
      // await repository.removeNotification(apartment);
      
      // Update local preferences
      await appPreferences.setNotifyMe(apartment.address, false);
      
      // Return to success state
      resetApartmentState();
      dev.log('Successfully removed notification for apartment: ${apartment.address}');
    } catch (e) {
      dev.log("Error removing notification: ${e.toString()}");
      _apartmentState = ApartmentNotifyFailure(e.toString());
      throw Exception("Failed to remove notification: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  // Check if user has enabled notifications for a specific apartment
  bool isNotified(String apartmentAddress) {
    return appPreferences.getNotifyMe(apartmentAddress) ?? false;
  }

  void resetApartmentState() {
    // If we're in a notification state, reset to ApartmentSuccess if we have apartments
    if (_apartmentState is ApartmentNotifySuccess || 
        _apartmentState is ApartmentNotifyFailure ||
        _apartmentState is ApartmentNotifyLoading) {
      if (_categorizedApartments.isNotEmpty) {
        _apartmentState = ApartmentSuccess(_categorizedApartments);
      } else {
        _apartmentState = ApartmentInitial();
      }
      notifyListeners();
    }
  }
}