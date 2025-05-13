import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_model.dart';

import '../../data/models/dream_apartment_model.dart';

abstract class ApartmentStates {}

class ApartmentInitial extends ApartmentStates {}

class ApartmentLoading extends ApartmentStates {}

class ApartmentSuccess extends ApartmentStates {
  final Map<String, List<ApartmentModel>> apartmentsByType;

  ApartmentSuccess(this.apartmentsByType);
}

class ApartmentFailure extends ApartmentStates {
  final String message;

  ApartmentFailure(this.message);
}

class ApartmentNotifyLoading extends ApartmentStates {}

class ApartmentNotifySuccess extends ApartmentStates {
  final List<ApartmentModel> apartments;

  ApartmentNotifySuccess(this.apartments);
}

class ApartmentNotifyFailure extends ApartmentStates {
  final String message;

  ApartmentNotifyFailure(this.message);
}