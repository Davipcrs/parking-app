import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/model/subscriber_model.dart';
import 'package:parking_app/model/veicule_model.dart';
import 'package:parking_app/view/add_subscriber_view.dart';
import 'package:parking_app/view/add_veicule_view.dart';
import 'package:parking_app/view/filtered_view.dart';
import 'package:parking_app/view/filtered_view_all_veicules.dart';
import 'package:parking_app/view/filtered_view_expired_subscribers.dart';
import 'package:parking_app/view/main_view.dart';
import 'package:parking_app/view/subscriber_info.dart';
import 'package:parking_app/view/subscriber_view_widget.dart';
import 'package:parking_app/view/veicule_info.dart';
import 'package:parking_app/view/veicule_view_widget.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const MainWidget();
      },
    ),
    GoRoute(
      path: '/veicule-view',
      builder: (BuildContext context, GoRouterState state) {
        return const VeiculeViewWidget();
      },
    ),
    GoRoute(
      path: '/subscriber-view',
      builder: (BuildContext context, GoRouterState state) {
        return const SubscriberViewWidget();
      },
    ),
    GoRoute(
      path: '/veicule-info',
      builder: (BuildContext context, GoRouterState state) {
        final selectedVeicule = state.extra as Veicule;
        return VeiculeInfoView(selectedVeicule: selectedVeicule);
      },
    ),
    GoRoute(
      path: "/add-veicule",
      builder: (BuildContext context, GoRouterState state) {
        return const AddVeiculeWidget();
      },
    ),
    GoRoute(
      path: "/add-subscriber",
      builder: (BuildContext context, GoRouterState state) {
        return const AddSubscriberView();
      },
    ),
    GoRoute(
      path: '/subscriber-info',
      builder: (BuildContext context, GoRouterState state) {
        final selectedSubscriber = state.extra as Subscriber;
        return EditSubscriberView(subscriber: selectedSubscriber);
      },
    ),
    GoRoute(
      path: '/filtered-view',
      builder: (BuildContext context, GoRouterState state) {
        return const FilteredViewWidget();
      },
    ),
    GoRoute(
      path: '/filtered-view/all-veicules',
      builder: (BuildContext context, GoRouterState state) {
        return const VeiculeAllViewWidget();
      },
    ),
    GoRoute(
      path: '/filtered-view/expired-subscribers',
      builder: (BuildContext context, GoRouterState state) {
        return const ExpiredSubscriberViewWidget();
      },
    ),
  ],
);
