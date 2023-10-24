import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/add_veicule_provider.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/time_picker.dart';

class AddVeiculeWidget extends ConsumerWidget {
  const AddVeiculeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TimeOfDay timeIn = ref.watch(addVeiculeTimeIn);
    late String hour;
    late String minute;
    if (timeIn.hour.toInt() < 10) {
      hour = "0${timeIn.hour.toString()}";
    } else {
      hour = timeIn.hour.toString();
    }
    if (timeIn.minute.toInt() < 10) {
      minute = "0${timeIn.minute.toString()}";
    } else {
      minute = timeIn.minute.toString();
    }
    TextEditingController searchSubscribers = TextEditingController();
    TextEditingController licenseController = TextEditingController();
    licenseController.text = ref.watch(addVeiculeLicenseController);
    AsyncValue<dynamic> subscriberList = ref.watch(apiSubscriberProvider);

    // Need Providers!
    bool hasKey = ref.watch(addVeiculeHasKey);
    bool isSubscriber = ref.watch(addVeiculeIsSubscriber);
    bool isMotorBike = ref.watch(addVeiculeIsMotorBike);
    bool hasPaidEarly = ref.watch(addVeiculeHasPaidEarly);
    bool licenseValidator = ref.watch(addVeiculeLicenseValidator);

    return subscriberList.when(
      error: (err, stack) => Text('Error $err'),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (subscriberList) {
        final List<DropdownMenuEntry<String>> subscribersNamesEntries =
            <DropdownMenuEntry<String>>[];
        for (var item in subscriberList) {
          subscribersNamesEntries.add(DropdownMenuEntry<String>(
              value: item.str_name, label: item.str_name));
        }
        return Scaffold(
          appBar: customAppBar(context, ref, "Adicionar veículo"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DropdownMenu(
                  dropdownMenuEntries: subscribersNamesEntries,
                  initialSelection: subscriberList[0].str_name.toString(),
                  controller: searchSubscribers,
                  label: const Text("Nome:"),
                  leadingIcon: const Icon(Icons.search),
                  menuHeight: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width - 16,
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (value) {
                    int i = 0;
                    while (value != subscriberList[i].str_name.toString()) {
                      i = i + 1;
                    }
                    // Manter o Provider, pode se tornar necessário.
                    ref.read(addVeiculeSelectedSubscriber.notifier).state =
                        subscriberList[i]!;
                    ref.read(addVeiculeLicenseController.notifier).state =
                        ref.watch(addVeiculeSelectedSubscriber).str_license!;
                    // Manter o Provider, pode se tornar necessário.
                    //licenseController.text =
                    //    subscriberList[i].str_license.toString();
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 36,
                      height: MediaQuery.of(context).size.height / 8,
                      child: TextField(
                        controller: licenseController,
                        decoration: InputDecoration(
                            labelText: "Placa do carro",
                            errorText: licenseValidator
                                ? null
                                : "Coloque uma placa válida"),
                        onEditingComplete: () {
                          ref.read(addVeiculeLicenseController.notifier).state =
                              licenseController.text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          ref.read(addVeiculeLicenseController.notifier).state =
                              licenseController.text;
                          ref.read(addVeiculeTimeIn.notifier).state =
                              await timePicker(context, timeIn) ?? timeIn;
                        },
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width / 2) - 36,
                          child: Center(child: Text("$hour:$minute")),
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
                        width: MediaQuery.of(context).size.width / 2 - 24,
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
                                      ref
                                          .read(addVeiculeLicenseController
                                              .notifier)
                                          .state = licenseController.text;
                                      ref
                                          .read(addVeiculeHasKey.notifier)
                                          .state = value;
                                    },
                                  ),
                                ),
                                Text(
                                  "Chave",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
                                          .read(addVeiculeLicenseController
                                              .notifier)
                                          .state = licenseController.text;
                                      ref
                                          .read(addVeiculeIsSubscriber.notifier)
                                          .state = value;
                                    },
                                  ),
                                ),
                                Text(
                                  "Mensalista",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
                        width: MediaQuery.of(context).size.width / 2 - 24,
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
                                      ref
                                          .read(addVeiculeLicenseController
                                              .notifier)
                                          .state = licenseController.text;
                                      ref
                                          .read(addVeiculeIsMotorBike.notifier)
                                          .state = value;
                                    },
                                  ),
                                ),
                                Text(
                                  "Moto",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
                                      ref
                                          .read(addVeiculeLicenseController
                                              .notifier)
                                          .state = licenseController.text;
                                      ref
                                          .read(addVeiculeHasPaidEarly.notifier)
                                          .state = value;
                                    },
                                  ),
                                ),
                                Text(
                                  "Pago",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          ref.invalidate(addVeiculeHasKey);
                          ref.invalidate(addVeiculeIsSubscriber);
                          ref.invalidate(addVeiculeIsMotorBike);
                          ref.invalidate(addVeiculeHasPaidEarly);
                          ref.invalidate(addVeiculeLicenseValidator);
                          ref.invalidate(addVeiculeTimeIn);
                          ref.invalidate(addVeiculeLicenseController);

                          context.pop();
                        },
                        child: const Text("Cancelar"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (licenseController.text.length == 7) {
                            ref
                                .read(addVeiculeLicenseValidator.notifier)
                                .state = true;
                            if (timeIn.hour.toInt() < 10) {
                              hour = "0${timeIn.hour.toString()}";
                            } else {
                              hour = timeIn.hour.toString();
                            }
                            if (timeIn.minute.toInt() < 10) {
                              minute = "0${timeIn.minute.toString()}";
                            } else {
                              minute = timeIn.minute.toString();
                            }
                            Veicule data = Veicule(
                              str_license: licenseController.text.toUpperCase(),
                              str_timein: "$hour:$minute",
                              bool_issubscriber: isSubscriber,
                              bool_haskey: hasKey,
                              bool_haspaidearly: hasPaidEarly,
                              bool_ismotorbike: isMotorBike,
                              str_date:
                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              // Dummy Values:
                              id_veiculo: 0,
                              str_timeout: "",
                            );
                            ref
                                .read(apiPostVeiculeProvider.notifier)
                                .postVeicule(data);

                            // in the JSON pass the licenseController.text in UPPERCASE.
                            // API POST
                            ref.invalidate(apiVeiculeByDateProvider);
                            ref.invalidate(addVeiculeHasKey);
                            ref.invalidate(addVeiculeIsSubscriber);
                            ref.invalidate(addVeiculeIsMotorBike);
                            ref.invalidate(addVeiculeHasPaidEarly);
                            ref.invalidate(addVeiculeLicenseValidator);
                            ref.invalidate(addVeiculeTimeIn);
                            ref.invalidate(addVeiculeLicenseController);

                            context.pop();
                          } else {
                            ref
                                .read(addVeiculeLicenseValidator.notifier)
                                .state = false;
                          }
                        },
                        child: const Text("Adicionar Veículo"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          /*
      Veicule data = Veicule();
                ref.read(apiPostVeiculeProvider.notifier).postVeicule(data);
                ref.invalidate(apiVeiculeProvider);
      */
        );
      },
    );
  }
}


// Padding: The padding is the Default - For support this app remember the "padding over padding"
// See the structure slowly, and search for the Widgets