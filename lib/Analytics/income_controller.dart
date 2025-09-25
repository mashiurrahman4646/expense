import 'package:get/get.dart';
import 'income_model.dart';
import 'income_service.dart';

class IncomeController extends GetxController {
  final IncomeService _incomeService = Get.find();

  final RxList<Income> incomes = <Income>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIncomes();
  }

  Future<void> fetchIncomes({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        currentPage.value = 1;
      } else {
        currentPage.value++;
      }

      errorMessage.value = '';

      final response = await _incomeService.getIncomes(
        page: currentPage.value,
        limit: 10,
      );

      if (loadMore) {
        incomes.addAll(response.data);
      } else {
        incomes.assignAll(response.data);
      }

      hasMore.value = currentPage.value < response.pagination.totalPages;
    } catch (e) {
      errorMessage.value = 'Failed to load incomes: ${e.toString()}';
      if (!loadMore) {
        incomes.clear();
      }
      currentPage.value = loadMore ? currentPage.value - 1 : 1;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshIncomes() async {
    await fetchIncomes(loadMore: false);
  }

  Future<void> loadMoreIncomes() async {
    if (!isLoading.value && hasMore.value) {
      await fetchIncomes(loadMore: true);
    }
  }

  Future<void> addIncome({
    required String source,
    required double amount,
    required DateTime date,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final newIncome = await _incomeService.createIncome(
        source: source,
        amount: amount,
        date: date,
      );

      incomes.insert(0, newIncome);
    } catch (e) {
      errorMessage.value = 'Failed to add income: ${e.toString()}';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editIncome({
    required String id,
    String? source,
    double? amount,
    DateTime? date,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final updatedIncome = await _incomeService.updateIncome(
        id: id,
        source: source,
        amount: amount,
        date: date,
      );

      final index = incomes.indexWhere((income) => income.id == id);
      if (index != -1) {
        incomes[index] = updatedIncome;
      }
    } catch (e) {
      errorMessage.value = 'Failed to edit income: ${e.toString()}';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeIncome(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _incomeService.deleteIncome(id);
      incomes.removeWhere((income) => income.id == id);
    } catch (e) {
      errorMessage.value = 'Failed to delete income: ${e.toString()}';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  double get totalIncome {
    return incomes.fold(0.0, (sum, income) => sum + income.amount);
  }

  List<Income> getIncomesByMonth(String month) {
    return incomes.where((income) => income.month == month).toList();
  }
}