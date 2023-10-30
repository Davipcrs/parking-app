import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/utils/chart_day_title_widget.dart';

class WeekResultChart extends ConsumerWidget {
  const WeekResultChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(apiVeiculeAnalyticsProvider);
    return data.when(
      error: (error, stackTrace) => Text("error $error"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (list) {
        return BarChart(
          BarChartData(
            titlesData: titlesData,
            barGroups: barGroups(list),
            gridData: const FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: 40,
          ),
        );
      },
    );
  }
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

List<BarChartGroupData> barGroups(data) {
  List<BarChartGroupData> data = [];
  return data;
}
