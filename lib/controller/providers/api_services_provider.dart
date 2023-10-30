// https://riverpod.dev/docs/providers/future_provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/api/api_services.dart';
import 'package:parking_app/model/veicule_model.dart';

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

final apiVeiculeAnalyticsProvider = FutureProvider((ref) async {
  return await ref.watch(apiServicesProvider).analyticsWeekEndpoint();
});

final apiPostVeiculeProvider =
    AsyncNotifierProvider.autoDispose<VeiculeListNotifier, List<Veicule>>(
  VeiculeListNotifier.new,
);

class VeiculeListNotifier extends AutoDisposeAsyncNotifier<List<Veicule>> {
  @override
  Future<List<Veicule>> build() async => [];

  Future<void> postVeicule(Veicule veicule) async {
    await ref.watch(apiServicesProvider).postVeicule(veicule);
  }
}

final apiPatchVeiculeProvider =
    AsyncNotifierProvider.autoDispose<VeiculePatchListNotifier, List<Veicule>>(
  VeiculePatchListNotifier.new,
);

class VeiculePatchListNotifier extends AutoDisposeAsyncNotifier<List<Veicule>> {
  @override
  Future<List<Veicule>> build() async => [];

  Future<void> patchVeicule(Veicule veicule) async {
    await ref.watch(apiServicesProvider).patchVeicule(veicule);
  }
}
/*
final apiVeiculePostProvider = FutureProvider((ref) async{
  return await ref.watch(apiServicesProvider).postVeicule(veicule);
});
*/