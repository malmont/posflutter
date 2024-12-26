import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/domain/entities/order_item.dart';

import '../../../../design/design.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderDetails orderDetails;
  final VoidCallback onBack;

  const OrderDetailsPage({
    super.key,
    required this.orderDetails,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${orderDetails.id}'),
        backgroundColor: Colours.primary100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Container(
        color: Colours.primary100,
        padding: const EdgeInsets.all(Units.edgeInsetsXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfoCard(),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.4,
                ),
                itemCount: orderDetails.orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderDetails.orderItems[index];
                  return _buildItemCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Card(
      color: Colours.primaryPalette,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Units.radiusXXXXLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Units.edgeInsetsXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Order Reference', orderDetails.reference),
            const SizedBox(height: Units.sizedbox_10),
            _buildInfoRow('Total Amount',
                '\$${orderDetails.totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: Units.sizedbox_10),
            _buildInfoRow('Order Date', orderDetails.orderDate),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.interBoldBody1.copyWith(color: Colors.white70),
        ),
        Text(
          value,
          style: TextStyles.interBoldBody1.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildItemCard(OrderItem item) {
    return Card(
      color: Colours.primaryPalette,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Units.radiusXXXXLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Units.radiusXXXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Units.radiusXXLarge),
                child: CachedNetworkImage(
                  imageUrl: item.productImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: Units.sizedbox_8),
            Text(
              item.productVariantName,
              style: TextStyles.interBoldBody1.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Units.sizedbox_8),
            Text(
              'Quantity: ${item.quantity}',
              style:
                  TextStyles.interRegularBody1.copyWith(color: Colors.white70),
            ),
            Text(
              'Color: ${item.productVariantColor}',
              style:
                  TextStyles.interRegularBody1.copyWith(color: Colors.white70),
            ),
            Text(
              'Size: ${item.productVariantSize}',
              style:
                  TextStyles.interRegularBody1.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: Units.sizedbox_8),
            Text(
              'Price: \$${(item.totalPrice / 100).toStringAsFixed(2)}',
              style: TextStyles.interRegularBody1
                  .copyWith(color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
