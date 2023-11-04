import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSubscriberView extends ConsumerWidget {
  const AddSubscriberView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    TextEditingController licenseController = TextEditingController();
    TextEditingController celNumberController = TextEditingController();
    // TODO: Implementar a tela.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height / 8,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    enabledBorder: (OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: licenseController,
                      decoration: InputDecoration(
                        enabledBorder: (OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary),
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: celNumberController,
                      decoration: InputDecoration(
                        enabledBorder: (OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Vencimento: "),
                ElevatedButton(
                  onPressed: () {},
                  // Colocar os 01/02/2023 (Problema na formatação)
                  child: Text("${DateTime.now().day}/${DateTime.now().month}"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
