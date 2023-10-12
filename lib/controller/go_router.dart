import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/veicule_info.dart';
import 'package:parking_app/view/veicule_view_widget.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return VeiculeViewWidget();
      },
    ),
    GoRoute(
      path: '/veicule-info',
      builder: (BuildContext context, GoRouterState state) {
        final selectedVeicule = state.extra as Veicule;
        return VeiculeInfoView(selectedVeicule: selectedVeicule);
      },
    )
  ],
);