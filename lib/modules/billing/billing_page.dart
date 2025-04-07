// modules/billing/billing_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jelwery_billingsystem/controller/product_controller.dart';
import 'billing_controller.dart';
import 'widgets/billing_summary.dart';

class BillingPage extends StatelessWidget {
  final productController = Get.find<ProductController>();
  final billingController = Get.put(BillingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Billing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text('₹${product.price}'),
                      trailing: ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () => billingController.addToCart(product),
                      ),
                    ),
                  );
                },
              )),
            ),
            const SizedBox(height: 16),
            BillingSummary(controller: billingController),
          ],
        ),
      ),
    );
  }
}
