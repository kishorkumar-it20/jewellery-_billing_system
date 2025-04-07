import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'billing_history_controller.dart';
import 'package:intl/intl.dart';

class BillingHistoryPage extends StatelessWidget {
  final controller = Get.put(BillingHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by product or date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: controller.search,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredBills.isEmpty) {
                return Center(child: Text("No bills found."));
              }
              return ListView.builder(
                itemCount: controller.filteredBills.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.filteredBills.length) {
                    final bill = controller.filteredBills[index];
                    final date = DateFormat.yMMMd().format(DateTime.parse(bill['date']));
                    final items = bill['items'] as List;

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text("Invoice - $date"),
                        subtitle: Text("Items: ${items.length}, Total: ₹${bill['total'].toStringAsFixed(2)}"),
                        trailing: Icon(Icons.receipt_long),
                      ),
                    );
                  } else {
                    // Lazy Load Button
                    return TextButton(
                      onPressed: controller.loadMore,
                      child: Text("Load More"),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
