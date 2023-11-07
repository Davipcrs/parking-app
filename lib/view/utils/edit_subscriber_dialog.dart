import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/subscriber_model.dart';

editSubscriberDialog(
    BuildContext context, WidgetRef ref, AsyncValue<dynamic> list) {
  AsyncValue<dynamic> subscriberList = list;
  return subscriberList.when(
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
    error: (error, stackTrace) => Text("$error"),
    data: (data) {
      final List<DropdownMenuEntry<String>> subscriberEntries =
          <DropdownMenuEntry<String>>[];
      for (var item in data) {
        subscriberEntries.add(
          DropdownMenuEntry<String>(value: item.str_name, label: item.str_name),
        );
      }
      Subscriber selectedValue = data[0] as Subscriber;
      return AlertDialog.adaptive(
        title: const Text("Editar Mensalista"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 24,
          child: DropdownMenu(
            dropdownMenuEntries: subscriberEntries,
            initialSelection: subscriberEntries[0].value,
            onSelected: (value) {
              int i = 0;
              while (data[i].str_name.toUpperCase() !=
                  value.toString().toUpperCase()) {
                i = i + 1;
              }
              selectedValue = data[i] as Subscriber;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.push("/subscriber-info", extra: selectedValue);
              context.pop();
            },
            child: const Text('Editar'),
          ),
        ],
      );
    },
  );
}
