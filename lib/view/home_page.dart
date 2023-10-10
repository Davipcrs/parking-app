import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> veiculeList = ref.watch(apiVeiculeByDateProvider);
    final itemWidth = MediaQuery.of(context).size.width / 2;
    final itemHeigth =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 5;

    return veiculeList.when(
        error: (err, stack) => Text('Error $err'),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (veiculeList) {
          return Scaffold(
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeigth),
              ),
              itemCount: veiculeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      print("tapped");
                    },
                    child: Column(
                      children: [
                        Text(veiculeList[index].str_license),
                        Text(veiculeList[index].str_timein),
                        Text(veiculeList[index].str_timeout)
                      ],
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
