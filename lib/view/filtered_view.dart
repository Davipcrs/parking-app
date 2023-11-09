import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';

class FilteredViewWidget extends ConsumerWidget {
  const FilteredViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(context, ref, "2D Estacionamento"),
      bottomNavigationBar: appBottomBar(context, ref),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  context.push("/filtered-view/all-veicules");
                },
                child: const Text("Todos os veículos"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: ElevatedButton(
                onPressed: () {
                  context.push("/filtered-view/expired-subscribers");
                },
                child: const Text("Mensalistas expirados"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
