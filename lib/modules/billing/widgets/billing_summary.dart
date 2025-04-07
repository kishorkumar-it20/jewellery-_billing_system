import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jelwery_billingsystem/modules/billing/invoice/pdf_invoice_generator.dart';
import '../billing_controller.dart';

class BillingSummary extends StatelessWidget {
  final BillingController controller;

  const BillingSummary({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Subtotal: ₹${controller.subtotal.toStringAsFixed(2)}"),
          Text("Discount: ₹${controller.totalDiscount.toStringAsFixed(2)}"),
          Text("Tax: ₹${controller.totalTax.toStringAsFixed(2)}"),
          Divider(),
          Text(
            "Total: ₹${controller.total.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                await PDFInvoiceGenerator.generateInvoice(controller);
              },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text("Generate Invoice", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    ));
  }
}
