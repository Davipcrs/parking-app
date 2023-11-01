import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/controller/providers/api_services_provider.dart';
import 'package:parking_app/view/utils/chart_day_title_widget.dart';

// If need docs, see the fl_charts demo charts.
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BarChart(
            BarChartData(
              titlesData: titlesData,
              barGroups: barGroups(list, context),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: barTouchData(context),
              alignment: BarChartAlignment.spaceAround,
              maxY: 35,
            ),
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

BarTouchData barTouchData(BuildContext context) {
  return BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
}

List<BarChartGroupData> barGroups(list, context) {
  List<BarChartGroupData> data = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          color: Theme.of(context).colorScheme.onPrimary,
          toY: list[0].toDouble(),
        ),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          color: Theme.of(context).colorScheme.onPrimary,
          toY: list[1].toDouble(),
        ),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          color: Theme.of(context).colorScheme.onPrimary,
          toY: list[2].toDouble(),
        ),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          color: Theme.of(context).colorScheme.onPrimary,
          toY: list[3].toDouble(),
        ),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          color: Theme.of(context).colorScheme.onPrimary,
          toY: list[4].toDouble(),
        ),
      ],
      showingTooltipIndicators: [0],
    ),
  ];
  return data;
}
