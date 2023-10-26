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
      body: const Placeholder(),
    );
  }
}
