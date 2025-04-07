import 'package:hive/hive.dart';
import '../models/product_model.dart';

class LocalDB {
  static final productBox = Hive.box<ProductModel>('products');
  static final billingBox = Hive.box('billing_history');

  // Products
  static Future<void> addProduct(ProductModel product) async {
    await productBox.put(product.id, product);
  }

  static List<ProductModel> getProducts() {
    return productBox.values.toList();
  }

  static Future<void> deleteProduct(String id) async {
    await productBox.delete(id);
  }

  // Billing History
  static Future<void> saveBill(Map<String, dynamic> billData) async {
    await billingBox.add(billData);
  }

  static List<Map> getBills() {
    return billingBox.values.cast<Map>().toList();
  }
}
