import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/model/subscriber_model.dart';

// Manter o Provider, pode se tornar necessário.
// Provider usado para salvar o "Subscriber" selecionado quando
// Um veículo for adicionado.
final addVeiculeSelectedSubscriber =
    StateProvider<Subscriber>((ref) => Subscriber());

final addVeiculeLicenseValidator = StateProvider((ref) => true);

final addVeiculeHasKey = StateProvider((ref) => false);
final addVeiculeIsSubscriber = StateProvider((ref) => false);
final addVeiculeIsMotorBike = StateProvider((ref) => false);
final addVeiculeHasPaidEarly = StateProvider((ref) => false);

final addVeiculeTimeIn = StateProvider(
  (ref) {
    return TimeOfDay.now();
  },
);
