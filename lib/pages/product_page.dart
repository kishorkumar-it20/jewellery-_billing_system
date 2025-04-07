import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jelwery_billingsystem/controller/product_controller.dart';
import 'package:jelwery_billingsystem/models/product_model.dart';
import 'package:jelwery_billingsystem/shared/custom_button.dart';
import 'package:jelwery_billingsystem/shared/product_tile.dart';
import 'package:uuid/uuid.dart';


class ProductPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final discountCtrl = TextEditingController();
  final taxCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Products')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Product Name')),
            Row(
              children: [
                Expanded(child: TextField(controller: priceCtrl, decoration: InputDecoration(labelText: 'Price'))),
                SizedBox(width: 12),
                Expanded(child: TextField(controller: stockCtrl, decoration: InputDecoration(labelText: 'Stock'))),
              ],
            ),
            Row(
              children: [
                Expanded(child: TextField(controller: discountCtrl, decoration: InputDecoration(labelText: 'Discount %'))),
                SizedBox(width: 12),
                Expanded(child: TextField(controller: taxCtrl, decoration: InputDecoration(labelText: 'Tax %'))),
              ],
            ),
            SizedBox(height: 10),
            CustomButton(
              label: 'Add Product',
              onPressed: () {
                final product = ProductModel(
                  id: const Uuid().v4(),
                  name: nameCtrl.text,
                  price: double.tryParse(priceCtrl.text) ?? 0,
                  discount: double.tryParse(discountCtrl.text) ?? 0,
                  tax: double.tryParse(taxCtrl.text) ?? 0, category: '',
                );
                controller.addProduct(product);
                nameCtrl.clear();
                priceCtrl.clear();
                stockCtrl.clear();
                discountCtrl.clear();
                taxCtrl.clear();
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    product: controller.products[index],
                    onDelete: () => controller.deleteProduct(controller.products[index].id),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
