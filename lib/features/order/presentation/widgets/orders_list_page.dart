import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/presentation/widgets/dashboard_card.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';

class OrdersListPage extends StatefulWidget {
  final List<OrderDetails> orders;
  final Function(OrderDetails) onSelectOrder; // Add the onSelectOrder callback

  const OrdersListPage(
      {super.key, required this.orders, required this.onSelectOrder});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

int selectedDayIndex = 0;

final List<DaySelection> daySelections = [
  DaySelection(name: "10 jours", days: 10),
  DaySelection(name: "20 jours", days: 20),
  DaySelection(name: "30 jours", days: 30),
  DaySelection(name: "2 mois", days: 60),
  DaySelection(name: "6 mois", days: 180),
];

class _OrdersListPageState extends State<OrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyles.interRegularH5
              .copyWith(color: Colours.colorsButtonMenu),
        ),
        backgroundColor: Colours.primary100,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: DashboardCard(
                  icon: Icons.shopping_cart,
                  value: '1000',
                  label: 'Total Orders',
                ),
              ),
              Expanded(
                child: DashboardCard(
                  icon: Icons.monetization_on,
                  value: '500',
                  label: 'Total Taxes',
                ),
              ),
              Expanded(
                child: DashboardCard(
                  icon: Icons.attach_money_rounded,
                  value: '15000',
                  label: 'Total Revenue',
                ),
              ),
            ],
          ),
          GenericList<DaySelection>(
            items: daySelections,
            selectedIndex: selectedDayIndex,
            onItemSelected: (index) {
              setState(() {
                selectedDayIndex = index;
                final selectedDays = daySelections[index].days;
                context.read<OrderBloc>().add(GetOrders(
                      FilterOrderParams(
                        orderSource: 2,
                        days: daySelections[index].days,
                      ),
                    ));
              });
            },
            itemBuilder: (daySelection, isSelected) => Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Units.edgeInsetsXLarge,
                  vertical: Units.edgeInsetsXLarge),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Units.radiusXXLarge),
                color:
                    isSelected ? Colours.colorsButtonMenu : Colours.primary100,
              ),
              padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
              child: Text(
                daySelection.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colours.primary100,
              child: ListView.builder(
                itemCount: widget.orders.length,
                itemBuilder: (context, index) {
                  final order = widget.orders[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onSelectOrder(order);
                    },
                    child: Card(
                      color: Colours.primaryPalette,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: Units.edgeInsetsLarge,
                          horizontal: Units.edgeInsetsXXLarge),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeaderRow(order),
                            const SizedBox(width: Units.sizedbox_80),
                            _buildDetailsRow(
                                'Total Amount',
                                '\$${(order.totalAmount / 100).toStringAsFixed(2)}',
                                Colors.greenAccent),
                            const SizedBox(width: Units.sizedbox_80),
                            _buildDetailsRow(
                                'Order Date', order.orderDate, Colors.grey),
                            const SizedBox(width: Units.sizedbox_80),
                            _buildStatusRow(order),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(OrderDetails order) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order ID: ${order.id}',
          style: TextStyles.interBoldH5.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Text(
          order.reference,
          style: TextStyles.interRegularBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String label, String value, Color valueColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Text(
          value,
          style: TextStyles.interRegularBody1
              .copyWith(color: Colours.colorsButtonMenu),
        ),
      ],
    );
  }

  Widget _buildStatusRow(OrderDetails order) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Status',
          style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: Units.sizedbox_10),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: Units.edgeInsetsMedium,
              horizontal: Units.edgeInsetsXLarge),
          decoration: BoxDecoration(
            color: _getStatusColor('Completed'),
            borderRadius: BorderRadius.circular(Units.radiusXXLarge),
          ),
          child: Text(
            'Completed',
            style: TextStyles.interRegularBody1.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Preparing':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class DaySelection {
  final String name;
  final int days;

  DaySelection({required this.name, required this.days});
}
