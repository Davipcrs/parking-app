import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/app_bar.dart';
import 'package:parking_app/view/bottom_app_bar.dart';

class SubscriberViewWidget extends ConsumerWidget {
  const SubscriberViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> subscriberList = ref.watch(apiSubscriberProvider);

    return subscriberList.when(
      error: (err, stack) => Text('Error $err'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (subscriberList) {
        return Scaffold(
          appBar: customAppBar(context, ref, "Mensalistas"),
          bottomNavigationBar: appBottomBar(context, ref),
          body: ListView.builder(
            itemCount: subscriberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Card(
                  color: Theme.of(context).colorScheme.secondary,
                  // Add inkWell
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              subscriberList[index].str_name,
                              softWrap: true,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            Text(
                              "Placa: ${subscriberList[index].str_license.toString()}",
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            Text(
                              "Início: ${subscriberList[index].str_initdate}",
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            Text(
                              "Final: ${subscriberList[index].str_enddate}",
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
