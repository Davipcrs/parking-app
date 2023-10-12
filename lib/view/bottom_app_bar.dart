import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

appBottomBar(BuildContext context, WidgetRef ref) {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    notchMargin: 4.0,
    color: Theme.of(context).colorScheme.primary,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            tooltip: "Home",
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.car_rental),
            tooltip: "Veículos",
          ),
          const SizedBox(
            width: 24,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.card_membership),
            tooltip: "Mensalistas",
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
            tooltip: "Listas",
          ),
        ],
      ),
    ),
  );
}
