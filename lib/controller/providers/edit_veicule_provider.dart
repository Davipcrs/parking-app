import 'package:flutter_riverpod/flutter_riverpod.dart';

final editVeiculeLicenseText = StateProvider((ref) => "");

final editVeiculeReadOnlyFields = StateProvider((ref) => true);

final editVeiculeHasKey = StateProvider((ref) => false);
final editVeiculeIsSubscriber = StateProvider((ref) => false);
final editVeiculeIsMotorBike = StateProvider((ref) => false);
final editVeiculeHasPaidEarly = StateProvider((ref) => false);
