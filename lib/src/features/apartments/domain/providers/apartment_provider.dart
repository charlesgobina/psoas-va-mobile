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

  // test

  ApartmentProvider({required this.repository});

  final Map<String, List<ApartmentModel>> _categorizedApartments = {};
  // bool _isLoading = false;
  String? _errorMessage;
  Map<String, List<ApartmentModel>> get categorizedApartments =>
      _categorizedApartments;
  // bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadApartments() async {
    dev.log('LOADING APARTMENTS');
    _apartmentState = ApartmentLoading();
    // _isLoading = true;
    notifyListeners();

    try {
      // get apartments from hive storage
      final categorizedApts = await repository.getApartments();
      dev.log("Categorized apartments: $categorizedApts");
      _categorizedApartments.clear();
      _categorizedApartments.addAll(categorizedApts);
      // Use logging framework instead of print
      _apartmentState = ApartmentSuccess(_categorizedApartments);
    } catch (e) {
      // Use logging framework instead of print
      dev.log("Error loading apartments: ${e.toString()}");
      _apartmentState = ApartmentFailure(e.toString());
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }

  // load apartments from hive storage
  Future<void> loadHiveApartments() async {
    dev.log('LOADING APARTMENTS FROM HIVE');
    _apartmentState = ApartmentLoading();
    // _isLoading = true;
    notifyListeners();

    try {
      // get apartments from hive storage
      final categorizedApts = await repository.getHiveApartments();
      dev.log("Categorized apartments: $categorizedApts");
      _categorizedApartments.clear();
      _categorizedApartments.addAll(categorizedApts);
      // Use logging framework instead of print
      _apartmentState = ApartmentSuccess(_categorizedApartments);
    } catch (e) {
      // Use logging framework instead of print
      dev.log("Error loading apartments: ${e.toString()}");
      _apartmentState = ApartmentFailure(e.toString());
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }

  // notify me function
  Future<void> notifyMe(ApartmentModel apartment) async {
    // dev.log('NOTIFY ME');
    _apartmentState = ApartmentNotifyLoading();
    notifyListeners();
    try {
      await repository.notifyMe(apartment);
      _apartmentState = ApartmentNotifySuccess([apartment]);
      appPreferences.setNotifyMe(apartment.address, true);
    } catch (e) {
      dev.log("Error notifying me: ${e.toString()}");
      _apartmentState = ApartmentNotifyFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetApartmentState() {
    _apartmentState = ApartmentInitial();
    notifyListeners();
  }
}
