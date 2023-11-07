import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/add_veicule_provider.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';
import 'package:parking_app/view/utils/edit_subscriber_dialog.dart';
import 'package:parking_app/view/utils/remove_veicule_dialog.dart';
import 'package:parking_app/view/utils/week_results_chart.dart';

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: customAppBar(context, ref, "2D Estacionamento"),
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
                      child: ElevatedButton(
                        child: const Text("Novo Veículo"),
                        onPressed: () {
                          ref.invalidate(addVeiculeLicenseValidator);
                          ref.invalidate(addVeiculeSelectedSubscriber);
                          context.push("/add-veicule").then(
                                (value) => Future.delayed(
                                        const Duration(milliseconds: 200))
                                    .then(
                                  (value) =>
                                      ref.invalidate(apiVeiculeByDateProvider),
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ElevatedButton(
                        child: const Text("Remover Veículo"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                removeVeiculeDialog(context, ref),
                          ).then(
                            (value) => Future.delayed(
                              const Duration(milliseconds: 200),
                            ).then(
                              (value) =>
                                  ref.invalidate(apiVeiculeByDateProvider),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 12,
                  height: MediaQuery.of(context).size.height / 4,
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 12,
                          child: const WeekResultChart(),
                        ),
                        SizedBox(child: Placeholder())
                      ],
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
                      child: ElevatedButton(
                        child: const Text("Novo Mensalista"),
                        onPressed: () {
                          context.push("/add-subscriber").then(
                                (value) => Future.delayed(
                                  const Duration(milliseconds: 200),
                                ).then(
                                  (value) =>
                                      ref.invalidate(apiSubscriberProvider),
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ElevatedButton(
                        child: const Text("Editar Mensalista"),
                        onPressed: () {
                          AsyncValue<dynamic> subscriberList =
                              ref.watch(apiSubscriberProvider);
                          showDialog(
                            context: context,
                            builder: (context) => editSubscriberDialog(
                                context, ref, subscriberList),
                          ).then(
                            (value) => Future.delayed(
                              const Duration(milliseconds: 200),
                            ).then(
                              (value) => ref.invalidate(apiSubscriberProvider),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        /*
        Column(
          children: [
            BarChart(
              BarChartData(),
              swapAnimationDuration: Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            )
          ],
        )
        */
        );
  }
}
