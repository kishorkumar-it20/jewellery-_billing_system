import 'package:get/get.dart';
import 'package:jelwery_billingsystem/service/local_db.dart';

class BillingHistoryController extends GetxController {
  var allBills = [].obs;
  var filteredBills = [].obs;
  var searchQuery = ''.obs;

  int itemsPerPage = 10;
  int currentPage = 1;

  @override
  void onInit() {
    fetchBills();
    super.onInit();
  }

  void fetchBills() {
    allBills.value = LocalDB.getBills();
    applyFilters();
  }

  void applyFilters() {
    var query = searchQuery.value.toLowerCase();
    var filtered = allBills.where((bill) {
      final date = bill['date']?.toString() ?? '';
      final items = bill['items'] ?? [];
      final matchesProduct = items.any((item) => item['name'].toLowerCase().contains(query));
      final matchesDate = date.toLowerCase().contains(query);
      return matchesProduct || matchesDate;
    }).toList();

    filteredBills.value = filtered.take(currentPage * itemsPerPage).toList();
  }

  void search(String query) {
    searchQuery.value = query;
    currentPage = 1;
    applyFilters();
  }

  void loadMore() {
    currentPage++;
    applyFilters();
  }

  void reset() {
    searchQuery.value = '';
    currentPage = 1;
    applyFilters();
  }
}
