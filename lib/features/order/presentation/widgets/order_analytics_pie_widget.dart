import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/order/domain/entities/daily_order_count.dart';

class OrderAnalyticsPieWidget extends StatelessWidget {
  final List<DailyOrderCount> dailyOrderCount;

  OrderAnalyticsPieWidget({super.key, required this.dailyOrderCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryPalette,
      body: SizedBox(
        height: Units.sizedbox_250,
        child: PieChart(
          PieChartData(
            centerSpaceColor: Colours.primary100,
            sections: dailyOrderCount
                .where((data) => data.orderCount > 0)
                .map((data) {
              return PieChartSectionData(
                titleStyle:
                    TextStyles.interRegularBody1.copyWith(color: Colours.white),
                color: Colours.colorsButtonMenu,
                value: data.orderCount.toDouble(),
                title: '${data.date.day}/${data.date.month}',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
