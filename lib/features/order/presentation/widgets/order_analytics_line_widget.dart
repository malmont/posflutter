import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_flutter/features/order/domain/entities/daily_revenue.dart';
import '../../../../design/design.dart';

class OrderAnalyticsLineChart extends StatelessWidget {
  final List<DailyRevenue> dailyRevenueForCurrentWeek;

  OrderAnalyticsLineChart(
      {super.key, required this.dailyRevenueForCurrentWeek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryPalette,
      body: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Units.edgeInsetsLarge),
              child: SizedBox(
                height: Units.sizedbox_280,
                child: LineChart(
                  LineChartData(
                    backgroundColor: Colours.primary100,
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 &&
                                index < dailyRevenueForCurrentWeek.length) {
                              final date =
                                  dailyRevenueForCurrentWeek[index].date;
                              return Text(
                                '${date.day}/${date.month}',
                                style: TextStyles.interItalicTiny.copyWith(
                                  color: Colours.colorsButtonMenu,
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '\$${value.toStringAsFixed(0)}',
                              style: TextStyles.interItalicTiny.copyWith(
                                color: Colours.colorsButtonMenu,
                              ),
                            );
                          },
                          reservedSize: 42,
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: Colours.colorsButtonMenu,
                        spots: dailyRevenueForCurrentWeek
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key.toDouble();
                          final revenue = entry.value.revenue /
                              100; // Conversion en dollars
                          return FlSpot(index, revenue);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 260,
              left: 0,
              child: RotatedBox(
                quarterTurns: 0,
                child: Text(
                  'Revenue (\$)',
                  style: TextStyles.interSemiBoldTiny
                      .copyWith(color: Colours.colorsButtonMenu),
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              right: 0,
              child: Text(
                'Day',
                style: TextStyles.interSemiBoldTiny
                    .copyWith(color: Colours.colorsButtonMenu),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
