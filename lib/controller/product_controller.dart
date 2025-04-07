import 'package:get/get.dart';
import 'package:jelwery_billingsystem/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;

  void addProduct(ProductModel product) {
    products.add(product);
  }

  void deleteProduct(String id) {
    products.removeWhere((product) => product.id == id);
  }
}
