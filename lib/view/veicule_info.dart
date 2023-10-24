import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/controller/providers/edit_veicule_provider.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';

class VeiculeInfoView extends ConsumerWidget {
  const VeiculeInfoView({super.key, required this.selectedVeicule});
  final Veicule selectedVeicule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Declarations
    TextEditingController veiculeLicense = TextEditingController();
    TextEditingController timeIn = TextEditingController();
    TextEditingController timeOut = TextEditingController();
    // Init State for the notifiers
    //ref.read(editVeiculeLicenseText.notifier).state =
    //    selectedVeicule.str_license.toString();
    // Providers Watches
    //veiculeLicense.text = ref.watch(editVeiculeLicenseText);
    //
    //Provider com erros, quando é usado o provider ele dá um erro devido "Rebuild" toda vez que muda-se algo.
    //Providers ainda vão existir para alguma proxima implementação.
    //
    veiculeLicense.text = selectedVeicule.str_license.toString().toUpperCase();
    timeIn.text = selectedVeicule.str_timein.toString().toUpperCase();
    timeOut.text = selectedVeicule.str_timeout.toString().toUpperCase();
    /*
    ref.read(editVeiculeTimeInText.notifier).state =
        selectedVeicule.str_timein.toString();
    ref.read(editVeiculeTimeOutText.notifier).state =
        selectedVeicule.str_timeout.toString();
    

    timeIn.text = selectedVeicule.str_timein.toString();
    timeOut.text = selectedVeicule.str_timeout.toString();
    */
    bool readOnly = ref.watch(editVeiculeReadOnlyFields);
    bool hasKey = ref.watch(editVeiculeHasKey);
    bool hasPaidEarly = ref.watch(editVeiculeHasPaidEarly);
    bool isMotorBike = ref.watch(editVeiculeIsMotorBike);
    bool isSubscriber = ref.watch(editVeiculeIsSubscriber);

    return Scaffold(
      appBar:
          customAppBar(context, ref, selectedVeicule.str_license.toString()),
      bottomNavigationBar: appBottomBar(context, ref),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: veiculeLicense,
                      readOnly: readOnly,
                      onChanged: (value) {
                        selectedVeicule.str_license = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Placa",
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      child: ElevatedButton(
                        onPressed: () {
                          if (readOnly) {
                            ref.read(editVeiculeReadOnlyFields.notifier).state =
                                false;
                          } else {
                            return;
                          }
                        },
                        child: Text(readOnly ? "Destravar" : "Liberado"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              // Change for the buttons!!
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 8,
                  child: TextField(
                    controller: timeIn,
                    onChanged: (value) {
                      selectedVeicule.str_timein = value;
                    },
                    readOnly: readOnly,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Entrada",
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 8,
                  child: TextField(
                    controller: timeOut,
                    readOnly: readOnly,
                    onChanged: (value) {
                      selectedVeicule.str_timeout = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Saída",
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch.adaptive(
                                activeColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                value: hasKey,
                                onChanged: (value) {
                                  selectedVeicule.str_license =
                                      veiculeLicense.text;
                                  selectedVeicule.str_timein = timeIn.text;
                                  selectedVeicule.str_timeout = timeOut.text;
                                  ref.read(editVeiculeHasKey.notifier).state =
                                      value;
                                },
                              ),
                            ),
                            Text(
                              "Chave",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch.adaptive(
                                activeColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                value: isSubscriber,
                                onChanged: (value) {
                                  ref
                                      .read(editVeiculeIsSubscriber.notifier)
                                      .state = value;

                                  selectedVeicule.str_license =
                                      veiculeLicense.text;
                                  selectedVeicule.str_timein = timeIn.text;
                                  selectedVeicule.str_timeout = timeOut.text;
                                },
                              ),
                            ),
                            Text(
                              "Mensalista",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch.adaptive(
                                activeColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                value: isMotorBike,
                                onChanged: (value) {
                                  selectedVeicule.str_license =
                                      veiculeLicense.text;
                                  selectedVeicule.str_timein = timeIn.text;
                                  selectedVeicule.str_timeout = timeOut.text;
                                  ref
                                      .read(editVeiculeIsMotorBike.notifier)
                                      .state = value;
                                },
                              ),
                            ),
                            Text(
                              "Moto",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch.adaptive(
                                activeColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                value: hasPaidEarly,
                                onChanged: (value) {
                                  selectedVeicule.str_license =
                                      veiculeLicense.text;
                                  selectedVeicule.str_timein = timeIn.text;
                                  selectedVeicule.str_timeout = timeOut.text;
                                  ref
                                      .read(editVeiculeHasPaidEarly.notifier)
                                      .state = value;
                                },
                              ),
                            ),
                            Text(
                              "Pago",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.invalidate(editVeiculeReadOnlyFields);
                      ref.invalidate(editVeiculeHasKey);
                      ref.invalidate(editVeiculeHasPaidEarly);
                      ref.invalidate(editVeiculeIsMotorBike);
                      ref.invalidate(editVeiculeIsSubscriber);
                      ref.invalidate(editVeiculeLicenseText);
                      context.pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Veicule data = selectedVeicule;
                      data.str_timeout =
                          "${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}";
                      ref
                          .read(apiPatchVeiculeProvider.notifier)
                          .patchVeicule(data);
                      ref.invalidate(apiVeiculeByDateProvider);
                      ref.invalidate(editVeiculeReadOnlyFields);
                      ref.invalidate(editVeiculeHasKey);
                      ref.invalidate(editVeiculeHasPaidEarly);
                      ref.invalidate(editVeiculeIsMotorBike);
                      ref.invalidate(editVeiculeIsSubscriber);
                      ref.invalidate(editVeiculeLicenseText);
                      ref.invalidate(editVeiculeTimeInText);
                      ref.invalidate(editVeiculeTimeOutText);

                      context.pop();
                    },
                    child: const Text('Remover'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (readOnly == false) {
                        Veicule data = selectedVeicule;
                        data.str_license = veiculeLicense.text;
                        data.str_timein = timeIn.text;
                        data.str_timeout = timeOut.text;
                        data.bool_haskey = hasKey;
                        data.bool_haspaidearly = hasPaidEarly;
                        data.bool_ismotorbike = isMotorBike;
                        data.bool_issubscriber = isSubscriber;

                        ref
                            .read(apiPatchVeiculeProvider.notifier)
                            .patchVeicule(data);
                        ref.invalidate(apiVeiculeByDateProvider);
                        ref.invalidate(editVeiculeReadOnlyFields);
                        ref.invalidate(editVeiculeHasKey);
                        ref.invalidate(editVeiculeHasPaidEarly);
                        ref.invalidate(editVeiculeIsMotorBike);
                        ref.invalidate(editVeiculeIsSubscriber);
                        ref.invalidate(editVeiculeLicenseText);
                        ref.invalidate(editVeiculeTimeInText);
                        ref.invalidate(editVeiculeTimeOutText);
                        context.pop();
                      } else {
                        return;
                      }
                    },
                    child: const Text('Editar'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
