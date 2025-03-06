
import 'package:flutter/foundation.dart';
import 'package:psoas_va_mobile/src/features/apartments/domain/providers/dream_apartment_states.dart';
import 'dart:developer' as dev;
import '../../data/models/dream_apartment_model.dart';
import '../../data/repo/apartment_repo.dart';

class DreamApartmentProvider with ChangeNotifier {
  final ApartmentRepo repository;

  DreamApartmentStates _dreamApartmentState = DreamApartmentInitial();
  DreamApartmentStates get dreamApartmentState => _dreamApartmentState;

  DreamApartmentProvider({required this.repository});

  void loadDreamApartments() {
    _dreamApartmentState = DreamApartmentLoading();
    notifyListeners();
  }

  // write dream apartment data to firestore
  Future<void> dreamApartment(DreamApartmentModel dreamApartment) async {
    _dreamApartmentState = DreamApartmentLoading();
    notifyListeners();
    try {
      await repository.dreamApartment(dreamApartment);
      _dreamApartmentState = DreamApartmentSuccess([dreamApartment]);
    } catch (e) {
      dev.log("Error dreaming apartment: ${e.toString()}");
      _dreamApartmentState = DreamApartmentFailure(e.toString());
      throw Exception('Failed to dream apartment');
      // Use logging framework instead of print
    } finally {
      notifyListeners();
    }
  }

  // reset dream apartment state
  void resetDreamApartmentState() {
    _dreamApartmentState = DreamApartmentInitial();
    notifyListeners();
  }


}