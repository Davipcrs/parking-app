import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/bottom_app_bar.dart';
import 'package:parking_app/view/veicule_info_view.dart';

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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {}),
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
                    color: Theme.of(context).colorScheme.primary,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Mudar depois, gambiarra!
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VeiculeInfoView(
                              selectedVeicule: veiculeList[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            veiculeList[index].str_license,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            veiculeList[index].str_timein,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            veiculeList[index].str_timeout,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
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
