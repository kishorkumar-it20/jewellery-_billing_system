import 'package:get/get.dart';
import 'package:jelwery_billingsystem/models/product_model.dart';

class BillingItem {
  ProductModel product;
  int quantity;

  BillingItem({required this.product, this.quantity = 1});
}

class BillingController extends GetxController {
  final RxList<BillingItem> cartItems = <BillingItem>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(BillingItem(product: product));
    }
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.product.id == id);
  }

  double get subtotal => cartItems.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));

  double get totalDiscount => cartItems.fold(
      0,
          (sum, item) =>
      sum + ((item.product.price * item.product.discount / 100) * item.quantity));

  double get totalTax => cartItems.fold(
      0,
          (sum, item) =>
      sum + ((item.product.price * item.product.tax / 100) * item.quantity));

  double get total =>
      subtotal - totalDiscount + totalTax;
}
