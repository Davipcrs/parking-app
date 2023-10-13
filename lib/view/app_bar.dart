import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

customAppBar(BuildContext context, WidgetRef ref, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.refresh,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    ],
  );
}
