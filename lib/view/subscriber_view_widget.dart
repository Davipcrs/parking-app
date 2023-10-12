import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
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
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: appBottomBar(context, ref),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeigth),
            ),
            itemCount: subscriberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  // Add inkWell
                ),
              );
            },
          ),
        );
      },
    );
  }
}
