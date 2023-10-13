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
    final itemWidth = MediaQuery.of(context).size.width / 2;
    final itemHeigth =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 5;

    return subscriberList.when(
      error: (err, stack) => Text('Error $err'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (subscriberList) {
        return Scaffold(
          appBar: customAppBar(context, ref, "Mensalistas"),
          bottomNavigationBar: appBottomBar(context, ref),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeigth),
            ),
            itemCount: subscriberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
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
                              subscriberList[index].str_license.toString(),
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            Text(
                              subscriberList[index].str_initdate,
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            Text(
                              subscriberList[index].str_enddate,
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
