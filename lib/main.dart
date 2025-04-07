import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jelwery_billingsystem/models/product_model.dart';
import 'package:jelwery_billingsystem/pages/product_page.dart';
import 'package:jelwery_billingsystem/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<ProductModel>('products');
  await Hive.openBox('billing_history');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewellery Billing System',
      theme: AppTheme.lightTheme,
      home: ProductPage(),
    );
  }
}
