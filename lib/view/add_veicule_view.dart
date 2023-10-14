import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/app_bar.dart';

class AddVeiculeWidget extends ConsumerWidget {
  const AddVeiculeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TimeOfDay timeIn = TimeOfDay.now();
    TextEditingController searchSubscribers = TextEditingController();
    AsyncValue<dynamic> subscriberList = ref.watch(apiSubscriberProvider);
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
                  onSelected: (value) {},
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 36,
                      height: MediaQuery.of(context).size.height / 8,
                      child: TextField(),
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
