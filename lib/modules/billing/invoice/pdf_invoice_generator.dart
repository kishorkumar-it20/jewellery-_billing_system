import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../billing_controller.dart';

class PDFInvoiceGenerator {
  static Future<void> generateInvoice(BillingController controller) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Invoice", style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Product', 'Qty', 'Price', 'Discount', 'Tax', 'Total'],
                data: controller.cartItems.map((item) {
                  final product = item.product;
                  final price = product.price * item.quantity;
                  final discount = (product.discount / 100) * price;
                  final tax = (product.tax / 100) * price;
                  final total = price - discount + tax;
                  return [
                    product.name,
                    '${item.quantity}',
                    '₹${product.price.toStringAsFixed(2)}',
                    '₹${discount.toStringAsFixed(2)}',
                    '₹${tax.toStringAsFixed(2)}',
                    '₹${total.toStringAsFixed(2)}',
                  ];
                }).toList(),
              ),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Subtotal: ₹${controller.subtotal.toStringAsFixed(2)}"),
                    pw.Text("Discount: ₹${controller.totalDiscount.toStringAsFixed(2)}"),
                    pw.Text("Tax: ₹${controller.totalTax.toStringAsFixed(2)}"),
                    pw.SizedBox(height: 8),
                    pw.Text("Total: ₹${controller.total.toStringAsFixed(2)}",
                        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}
