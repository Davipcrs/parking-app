import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/subscriber_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';

class AddSubscriberView extends ConsumerWidget {
  const AddSubscriberView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    TextEditingController licenseController = TextEditingController();
    TextEditingController celNumberController = TextEditingController();
    TextEditingController carModelController = TextEditingController();
    TextEditingController weekDaysController = TextEditingController();
    DateTime today = DateTime.now();
    DateTime endDate = today.add(const Duration(days: 30));
    String formatedDateInit = "";
    String formatedDateEnd = "";
    if (today.day < 10) {
      formatedDateInit = "${formatedDateInit}0${today.day}/";
    } else {
      formatedDateInit = "$formatedDateInit${today.day}/";
    }
    if (today.month < 10) {
      formatedDateInit = "${formatedDateInit}0${today.month}/";
    } else {
      formatedDateInit = "$formatedDateInit${today.month}/";
    }
    formatedDateInit = "$formatedDateInit${today.year}";

    if (endDate.day < 10) {
      formatedDateEnd = "${formatedDateEnd}0${endDate.day}/";
    } else {
      formatedDateEnd = "$formatedDateEnd${endDate.day}/";
    }
    if (endDate.month < 10) {
      formatedDateEnd = "${formatedDateEnd}0${endDate.month}/";
    } else {
      formatedDateEnd = "$formatedDateEnd${endDate.month}/";
    }
    formatedDateEnd = "$formatedDateEnd${endDate.year}";

    return Scaffold(
      appBar: customAppBar(context, ref, "Adicionar Mensalista"),
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
                    labelText: "Nome",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 0.5),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: licenseController,
                      decoration: InputDecoration(
                        labelText: "Placa do Carro",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: celNumberController,
                      decoration: InputDecoration(
                        labelText: "Contato",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: carModelController,
                      decoration: InputDecoration(
                        labelText: "Modelo do Carro",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: TextField(
                      controller: weekDaysController,
                      decoration: InputDecoration(
                        labelText: "Dias",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                      onPressed: () {},
                      // Colocar os 01/02/2023 (Problema na formatação)
                      child: Text("Início: $formatedDateInit"),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Vencimento: $formatedDateEnd"),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Cancelar"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8.0, bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Subscriber sub = Subscriber();
                        sub.id_mensalista = 0;
                        sub.bool_ismotorbike = false;
                        sub.bool_ismensalist = true;
                        sub.str_carmodel = carModelController.text;
                        sub.str_contact = celNumberController.text;
                        sub.str_enddate = formatedDateEnd;
                        sub.str_initdate = formatedDateInit;
                        sub.str_license = licenseController.text;
                        sub.str_name = nameController.text;
                        sub.str_weekdays = weekDaysController.text;

                        ref
                            .read(apiPostSubscriberProvider.notifier)
                            .postSubscriber(sub);

                        context.pop();
                      },
                      child: const Text("Adicionar Mensalista"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
