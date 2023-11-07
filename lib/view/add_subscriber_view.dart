import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/subscriber_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/date_formats.dart';
import 'package:parking_app/view/utils/time_picker.dart';

class AddSubscriberView extends ConsumerStatefulWidget {
  const AddSubscriberView({super.key});

  @override
  ConsumerState<AddSubscriberView> createState() => _AddSubscriberViewState();
}

class _AddSubscriberViewState extends ConsumerState<AddSubscriberView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController celNumberController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController weekDaysController = TextEditingController();
  DateTime today = DateTime.now();
  late DateTime endDate;
  late String formatedDateInit;
  late String formatedDateEnd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    endDate = today.add(const Duration(days: 30));
    formatedDateInit = dateFormats(today);
    formatedDateEnd = dateFormats(endDate);
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () async {
                        today = await datePicker(context, today) ?? today;
                        setState(() {
                          formatedDateInit = dateFormats(today);
                        });
                      },
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
                      onPressed: () async {
                        endDate = await datePicker(context, endDate) ?? endDate;

                        setState(() {
                          formatedDateEnd = dateFormats(endDate);
                        });
                      },
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
