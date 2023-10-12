import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/view/veicule_view_widget.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red, accentColor: Colors.redAccent)
            .copyWith(brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepOrange,
                accentColor: Colors.deepOrangeAccent)
            .copyWith(brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const VeiculeViewWidget(),
    );
  }
}
