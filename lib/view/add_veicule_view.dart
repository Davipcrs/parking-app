import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/add_veicule_provider.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/app_bar.dart';

class AddVeiculeWidget extends ConsumerWidget {
  const AddVeiculeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TimeOfDay timeIn = TimeOfDay.now();
    TextEditingController searchSubscribers = TextEditingController();
    TextEditingController licenseController = TextEditingController();
    AsyncValue<dynamic> subscriberList = ref.watch(apiSubscriberProvider);
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
                    // Manter o Provider, pode se tornar necessário.
                    licenseController.text =
                        subscriberList[i].str_license.toString();
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width / 2) - 36,
                          child: Center(
                              child: Text("${timeIn.hour}:${timeIn.minute}")),
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (licenseController.text.length == 7) {
                        ref.read(addVeiculeLicenseValidator.notifier).state =
                            true;
                        // API POST
                      } else {
                        ref.read(addVeiculeLicenseValidator.notifier).state =
                            false;
                      }
                    },
                    child: const Text("Add Veicule"))
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
