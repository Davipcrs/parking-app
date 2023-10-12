// https://riverpod.dev/docs/providers/future_provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/api/api_services.dart';

final apiServicesProvider = Provider((ref) => ApiServices());

final apiVeiculeProvider = FutureProvider((ref) async {
  return await ref.watch(apiServicesProvider).getAllVeicules();
});

final apiVeiculeByDateProvider = FutureProvider((ref) async {
  return await ref.watch(apiServicesProvider).getVeiculeByDate();
});

final apiSubscriberProvider = FutureProvider(
  (ref) async {
    return await ref.watch(apiServicesProvider).getAllSubscribers();
  },
);
/*
final apiVeiculePostProvider = FutureProvider((ref) async{
  return await ref.watch(apiServicesProvider).postVeicule(veicule);
});
*/