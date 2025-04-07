import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  String category;

  @HiveField(4)
  double discount;

  @HiveField(5)
  double tax;

  @HiveField(6)
  String? imagePath;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0,
    this.tax = 0,
    this.imagePath,
  });
}
