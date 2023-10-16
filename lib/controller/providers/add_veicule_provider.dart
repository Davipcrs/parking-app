import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/model/subscriber_model.dart';

// Manter o Provider, pode se tornar necessário.
// Provider usado para salvar o "Subscriber" selecionado quando
// Um veículo for adicionado.
final addVeiculeSelectedSubscriber =
    StateProvider<Subscriber>((ref) => Subscriber());
