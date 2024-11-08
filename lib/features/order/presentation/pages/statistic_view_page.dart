import 'package:flutter/material.dart';
import 'package:pos_flutter/design/colours.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';
import 'package:pos_flutter/features/order/presentation/widgets/order_analytics_Line_widget.dart';
import 'package:pos_flutter/features/order/presentation/widgets/order_analytics_pie_widget.dart';

import '../../../../design/design.dart';

class StatistiquePageView extends StatelessWidget {
  final StatistiqueOrderModel? statistiqueOrderModel;
  final RevenueStatisticsModel? revenueStatisticsModel;
  const StatistiquePageView(
      {super.key,
      required this.statistiqueOrderModel,
      required this.revenueStatisticsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.primary100,
      padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Card(
              color: Colours.primaryPalette,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Statistiques',
                      style: TextStyles.interBoldH5
                          .copyWith(color: Colours.colorsButtonMenu),
                    ),
                    const SizedBox(height: Units.sizedbox_80),
                    Expanded(
                      child: OrderAnalyticsPieWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Units.sizedbox_20),
          Expanded(
            flex: 4,
            child: Card(
              color: Colours.primaryPalette,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Statistiques',
                      style: TextStyles.interBoldH5
                          .copyWith(color: Colours.colorsButtonMenu),
                    ),
                    Expanded(
                      child: OrderAnalyticsLineChart(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
