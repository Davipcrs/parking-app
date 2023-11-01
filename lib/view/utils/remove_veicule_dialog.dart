import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/veicule_model.dart';

removeVeiculeDialog(BuildContext context, WidgetRef ref) {
  AsyncValue<dynamic> veiculeList = ref.watch(apiVeiculeByDateProvider);

  return veiculeList.when(
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
    error: (error, stackTrace) => Text("$error"),
    data: (data) {
      Veicule selected = data[0];
      final List<DropdownMenuEntry<String>> veiculeEntries =
          <DropdownMenuEntry<String>>[];
      for (var item in data) {
        veiculeEntries.add(DropdownMenuEntry<String>(
            value: item.str_license, label: item.str_license));
      }
      return AlertDialog.adaptive(
        title: const Text("Remover Veículo"),
        content: DropdownMenu(
          initialSelection: data[0].str_license,
          dropdownMenuEntries: veiculeEntries,
          onSelected: (value) {
            int i = 0;
            while (data[i].str_license.toUpperCase() != value) {
              i = i + 1;
            }
            selected = data[i];
            // Manipulação das Datas:
            TimeOfDay timeOut = TimeOfDay.now();
            late String hour;
            late String minute;
            if (timeOut.hour.toInt() < 10) {
              hour = "0${timeOut.hour.toString()}";
            } else {
              hour = timeOut.hour.toString();
            }
            if (timeOut.minute.toInt() < 10) {
              minute = "0${timeOut.minute.toString()}";
            } else {
              minute = timeOut.minute.toString();
            }

            selected.str_timeout = "$hour:$minute";
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(apiPatchVeiculeProvider.notifier).patchVeicule(selected);
              context.pop();
            },
            child: const Text('Remover'),
          ),
        ],
      );
    },
  );
}

yesNoRemoveVeiculeDialog(
    BuildContext context, Veicule selected, WidgetRef ref) {
  return AlertDialog.adaptive(
    title: Text("Remover: ${selected.str_license}?"),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          context.pop();
        },
        child: const Text('Cancelar'),
      ),
      TextButton(
        onPressed: () {
          // Manipulação das Datas:
          TimeOfDay timeOut = TimeOfDay.now();
          late String hour;
          late String minute;
          if (timeOut.hour.toInt() < 10) {
            hour = "0${timeOut.hour.toString()}";
          } else {
            hour = timeOut.hour.toString();
          }
          if (timeOut.minute.toInt() < 10) {
            minute = "0${timeOut.minute.toString()}";
          } else {
            minute = timeOut.minute.toString();
          }

          selected.str_timeout = "$hour:$minute";
          ref.read(apiPatchVeiculeProvider.notifier).patchVeicule(selected);
          context.pop();
        },
        child: const Text('Remover'),
      ),
    ],
  );
}
