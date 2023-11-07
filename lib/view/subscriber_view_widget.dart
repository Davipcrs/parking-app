import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/model/subscriber_model.dart';
import 'package:parking_app/view/utils/app_bar.dart';
import 'package:parking_app/view/utils/bottom_app_bar.dart';

class SubscriberViewWidget extends ConsumerWidget {
  const SubscriberViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<dynamic> subscriberList = ref.watch(apiSubscriberProvider);

    return subscriberList.when(
      error: (err, stack) => Text('Error $err'),
      loading: () => Scaffold(
        appBar: customAppBar(context, ref, "Mensalistas"),
        bottomNavigationBar: appBottomBar(context, ref),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: const Center(child: CircularProgressIndicator()),
      ),
      data: (subscriberList) {
        return Scaffold(
          appBar: customAppBar(context, ref, "Mensalistas"),
          bottomNavigationBar: appBottomBar(context, ref),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push("/add-subscriber").then(
                    (value) => Future.delayed(
                      const Duration(milliseconds: 200),
                    ).then(
                      (value) => ref.invalidate(apiSubscriberProvider),
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: ListView.builder(
            itemCount: subscriberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
                  ),
                  // Add inkWell
                  child: InkWell(
                    onTap: () {
                      Subscriber value = subscriberList[index] as Subscriber;
                      context.push("/subscriber-info", extra: value).then(
                            (value) => Future.delayed(
                              const Duration(milliseconds: 200),
                            ).then(
                              (value) => ref.invalidate(apiSubscriberProvider),
                            ),
                          );
                    },
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
                              "Vencimento: ${subscriberList[index].str_enddate}",
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
