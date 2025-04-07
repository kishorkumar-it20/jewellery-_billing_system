import 'package:flutter/material.dart';
import 'package:jelwery_billingsystem/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDelete;

  const ProductTile({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(
          '₹${product.price.toStringAsFixed(2)} | Disc: ${product.discount}% | Tax: ${product.tax}%',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
