import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';

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
                        child: Text("Novo Veículo"),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ElevatedButton(
                        child: Text("Remover Veículo"),
                        onPressed: () {},
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
