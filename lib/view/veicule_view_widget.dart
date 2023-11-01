import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/add_veicule_provider.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/controller/providers/edit_veicule_provider.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';
import 'package:parking_app/view/utils/remove_veicule_dialog.dart';

class VeiculeViewWidget extends ConsumerWidget {
  const VeiculeViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> veiculeList = ref.watch(apiVeiculeByDateProvider);
    final itemWidth = MediaQuery.of(context).size.width / 2;
    final itemHeigth =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 5;

    return veiculeList.when(
      error: (err, stack) => Center(child: Text('Error $err')),
      loading: () => Scaffold(
        body: const Center(child: CircularProgressIndicator()),
        appBar: customAppBar(context, ref, "Veículos"),
        bottomNavigationBar: appBottomBar(context, ref),
      ),
      data: (dataList) {
        // CONDITIONAL FOR NOT BUGGING WHEN THE GRIDVIEW IS NULL
        // "FAKE" SCAFFOLD
        if (dataList.length == 0) {
          return Scaffold(
            // Cores
            //Custom Bottom Nav Bar
            bottomNavigationBar: appBottomBar(context, ref),
            backgroundColor: Theme.of(context).colorScheme.background,
            //App Bar
            appBar: customAppBar(context, ref, "Veículos"),
            // FAB
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // IMPLEMENT THIS IN THE
                // ADD VEICULE VIEW!!
                ref.invalidate(addVeiculeLicenseValidator);
                ref.invalidate(addVeiculeSelectedSubscriber);
                context.push("/add-veicule").then(
                      (value) =>
                          Future.delayed(const Duration(milliseconds: 200))
                              .then(
                        (value) => ref.invalidate(apiVeiculeByDateProvider),
                      ),
                    );
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            body: const Center(
              child: Text("Sem veículos"),
            ),
          );

          // CONDITIONAL FOR NOT BUGGING WHEN THE GRIDVIEW IS NULL
          // REAL SCAFFOLD
        } else {
          return Scaffold(
            // Cores
            backgroundColor: Theme.of(context).colorScheme.background,
            //App Bar
            appBar: customAppBar(context, ref, "Veículos"),
            // FAB
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // IMPLEMENT THIS IN THE
                // ADD VEICULE VIEW!!
                ref.invalidate(addVeiculeLicenseValidator);
                ref.invalidate(addVeiculeSelectedSubscriber);
                context.push("/add-veicule").then(
                      (value) =>
                          Future.delayed(const Duration(milliseconds: 200))
                              .then(
                        (value) => ref.invalidate(apiVeiculeByDateProvider),
                      ),
                    );
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            //Custom Bottom Nav Bar
            bottomNavigationBar: appBottomBar(context, ref),
            // Real Widget
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Quantity of columns
                childAspectRatio: (itemWidth / itemHeigth), //Size of the Cards
              ),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      // InkWell Click Handle
                      onDoubleTap: () async {
                        Veicule selected = dataList[index] as Veicule;

                        return showDialog(
                            context: context,
                            builder: (context) => yesNoRemoveVeiculeDialog(
                                context, selected, ref)).then(
                          (value) => Future.delayed(
                            const Duration(milliseconds: 200),
                          ).then(
                            (value) => ref.invalidate(apiVeiculeByDateProvider),
                          ),
                        );
                      },
                      onTap: () {
                        Veicule aux = dataList[index] as Veicule;
                        ref.read(editVeiculeLicenseText.notifier).state =
                            aux.str_license!;
                        ref.read(editVeiculeHasKey.notifier).state =
                            aux.bool_haskey!;
                        ref.read(editVeiculeHasPaidEarly.notifier).state =
                            aux.bool_haspaidearly!;
                        ref.read(editVeiculeIsMotorBike.notifier).state =
                            aux.bool_ismotorbike!;
                        ref.read(editVeiculeIsSubscriber.notifier).state =
                            aux.bool_issubscriber!;
                        ref.read(editVeiculeTimeInText.notifier).state =
                            aux.str_timein.toString();
                        ref.read(editVeiculeTimeOutText.notifier).state =
                            aux.str_timeout.toString();
                        // Go Route: This go to the Veicule info Widget!
                        context
                            .push(
                          '/veicule-info',
                          extra: aux,
                        )
                            .then(
                          (value) {
                            ref.invalidate(editVeiculeReadOnlyFields);
                            ref.invalidate(editVeiculeHasKey);
                            ref.invalidate(editVeiculeHasPaidEarly);
                            ref.invalidate(editVeiculeIsMotorBike);
                            ref.invalidate(editVeiculeIsSubscriber);
                            ref.invalidate(editVeiculeLicenseText);
                            ref.invalidate(editVeiculeTimeInText);
                            ref.invalidate(editVeiculeTimeOutText);
                            Future.delayed(const Duration(milliseconds: 200))
                                .then((value) =>
                                    ref.invalidate(apiVeiculeByDateProvider));
                          },
                        );
                      },
                      // Data display
                      // Reed carefully.
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 8.0, right: 8.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Placa: ${dataList[index].str_license}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                                Text(
                                  "Entrada: ${dataList[index].str_timein}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                                Text(
                                  "Saída: ${dataList[index].str_timeout}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.monetization_on,
                                    color: dataList[index].bool_haspaidearly
                                        ? Colors.green.shade700
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                    size: 20),
                                Icon(Icons.key,
                                    color: dataList[index].bool_haskey
                                        ? Colors.green.shade700
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                    size: 20),
                                Icon(Icons.card_membership,
                                    color: dataList[index].bool_issubscriber
                                        ? Colors.green.shade700
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                    size: 20),
                                Icon(Icons.motorcycle,
                                    color: dataList[index].bool_ismotorbike
                                        ? Colors.green.shade700
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                    size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }, /*
              children: [
                dataList
                 
                ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 65,
                      color: Colors.blueAccent.shade700,
                      child: Column(
                        children: [
                          Text(dataList[index].str_license),
                          Text(dataList[index].str_timein),
                          Text(dataList[index].str_timeout)
                        ],
                      ),
                    );
                  },
                )
                
              ],
              */
            ),
          );
        }
      },
    );
  }
}
