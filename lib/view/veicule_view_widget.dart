import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/bottom_app_bar.dart';
import 'package:parking_app/view/fab.dart';

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
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            floatingActionButton: fab(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: appBottomBar(context, ref),
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeigth),
              ),
              itemCount: veiculeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.go('/veicule-info',
                            extra:
                                veiculeList[index]); // Mudar depois, gambiarra!
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            maintainState: true,
                            builder: (context) => VeiculeInfoView(
                              selectedVeicule: veiculeList[index],
                            ),
                          ),
                        );
                        */
                      },
                      child: Column(
                        children: [
                          Text(
                            "Placa: ${veiculeList[index].str_license}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            "Hora de entrada: ${veiculeList[index].str_timein}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            "Hora de saída: ${veiculeList[index].str_timeout}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            veiculeList[index].bool_haskey
                                ? "Chave: Sim"
                                : "Chave: Não",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            veiculeList[index].bool_haspaidearly
                                ? "Pág adiantado: Sim"
                                : "Pág adiantado: Não",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            veiculeList[index].bool_issubscriber
                                ? "Mensalista: Sim"
                                : "Mensalista: Não",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
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
