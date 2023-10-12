import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/bottom_app_bar.dart';
import 'package:parking_app/view/fab.dart';

class VeiculeInfoView extends ConsumerWidget {
  const VeiculeInfoView({super.key, required this.selectedVeicule});
  final Veicule selectedVeicule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: appBottomBar(context, ref),
      floatingActionButton: fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedVeicule.str_license.toString(),
            ),
            Text(
              selectedVeicule.str_date.toString(),
            ),
            Text(
              selectedVeicule.str_timein.toString(),
            ),
            Text(
              selectedVeicule.str_timeout.toString(),
            ),
            Text(
              selectedVeicule.bool_issubscriber.toString(),
            ),
            Text(
              selectedVeicule.bool_ismotorbike.toString(),
            ),
            Text(
              selectedVeicule.bool_haskey.toString(),
            ),
            Text(
              selectedVeicule.bool_haspaidearly.toString(),
            ),
            Text(
              selectedVeicule.id_veiculo.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Return'),
            )
          ],
        ),
      ),
    );
  }
}
