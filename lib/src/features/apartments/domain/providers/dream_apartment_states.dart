
import '../../data/models/dream_apartment_model.dart';

abstract class DreamApartmentStates {}

class DreamApartmentInitial extends DreamApartmentStates {}

class DreamApartmentLoading extends DreamApartmentStates {}


class DreamApartmentSuccess extends DreamApartmentStates {
  final List<DreamApartmentModel> dreamApartments;

  DreamApartmentSuccess(this.dreamApartments);
}

class DreamApartmentFailure extends DreamApartmentStates {
  final String message;

  DreamApartmentFailure(this.message);
}