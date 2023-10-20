import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/add_veicule_provider.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/app_bar.dart';
import 'package:parking_app/view/bottom_app_bar.dart';

class VeiculeViewWidget extends ConsumerWidget {
  const VeiculeViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> veiculeList = ref.watch(apiVeiculeProvider);
    final itemWidth = MediaQuery.of(context).size.width / 2;
    final itemHeigth =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 5;

    return veiculeList.when(
        error: (err, stack) => Text('Error $err'),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (veiculeList) {
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
                context.go("/add-veicule");
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
              itemCount: veiculeList.length,
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
                      onTap: () {
                        // Go Route: This go to the Veicule info Widget!
                        context.go(
                          '/veicule-info',
                          extra: veiculeList[index],
                        );
                      },
                      // Data display
                      // Reed carefully.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Placa: ${veiculeList[index].str_license}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Entrada: ${veiculeList[index].str_timein}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Saída: ${veiculeList[index].str_timeout}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Icon(Icons.monetization_on,
                                  color: veiculeList[index].bool_haspaidearly
                                      ? Colors.green.shade700
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                  size: 20),
                              Icon(Icons.key,
                                  color: veiculeList[index].bool_haskey
                                      ? Colors.green.shade700
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                  size: 20),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.card_membership,
                                  color: veiculeList[index].bool_issubscriber
                                      ? Colors.green.shade700
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                  size: 20),
                              Icon(Icons.motorcycle,
                                  color: veiculeList[index].bool_ismotorbike
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
                );
              }, /*
              children: [
                veiculeList
                 
                ListView.builder(
                  itemCount: veiculeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 65,
                      color: Colors.blueAccent.shade700,
                      child: Column(
                        children: [
                          Text(veiculeList[index].str_license),
                          Text(veiculeList[index].str_timein),
                          Text(veiculeList[index].str_timeout)
                        ],
                      ),
                    );
                  },
                )
                
              ],
              */
            ),
          );
        });
  }
}
