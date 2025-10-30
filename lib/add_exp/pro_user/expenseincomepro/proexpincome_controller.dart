import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:your_expense/Analytics/expense_controller.dart';
import 'package:your_expense/models/category_model.dart';
import 'package:your_expense/Analytics/income_service.dart';
import 'package:intl/intl.dart';
import 'package:your_expense/services/ocr_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// google_mlkit_text_recognition does not support web; guarded usage
import 'package:your_expense/services/api_base_service.dart'; // Add this import
import 'package:your_expense/services/config_service.dart'; // Add this import
import 'package:your_expense/Analytics/expense_model.dart';
import 'package:your_expense/home/home_controller.dart';
import 'package:your_expense/add_exp/common/barcode_scanner_screen.dart';


class ProExpensesIncomeController extends GetxController {
  // Form Controllers
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;

  // Observable variables
  var currentTab = 0.obs;
  var initialTab = 0;
  var selectedExpenseCategory = ''.obs;
  var selectedIncomeCategory = ''.obs;
  var selectedPaymentMethod = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var isLoading = false.obs;
  var uploadedReceiptPath = ''.obs;
  var isProcessingOCR = false.obs;

  // Pro feature unlocks
  var isExpenseProUnlocked = false.obs;
  var isIncomeProUnlocked = false.obs;

  // Categories loaded from API for expenses
  final expenseCategories = <Map<String, dynamic>>[].obs;

  final incomeCategories = <Map<String, dynamic>>[].obs;

  final paymentMethods = <Map<String, dynamic>>[
    {'name': 'cash', 'icon': Icons.money},
    {'name': 'mobile', 'icon': Icons.phone_android},
    {'name': 'bank', 'icon': Icons.account_balance},
    {'name': 'card', 'icon': Icons.credit_card},
  ].obs;

  // Resolve dependency lazily to avoid startup ordering issues
  late final ExpenseController _expenseController;
  late final OcrService _ocrService;
  late final ApiBaseService _apiService;
  late final ConfigService _configService;

  @override
  void onInit() {
    super.onInit();
    _expenseController = Get.find<ExpenseController>();
    if (!Get.isRegistered<OcrService>()) {
      Get.put(OcrService()).init();
    }
    _ocrService = Get.find<OcrService>();
    _apiService = Get.find<ApiBaseService>();
    _configService = Get.find<ConfigService>();
    _initializeControllers();
    _loadUnlockStatus();
    _loadExpenseCategories();
    _loadIncomeCategories();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('defaultTab')) {
      initialTab = args['defaultTab'] ?? 0;
      currentTab.value = initialTab;
    }
  }

  // Map category names to appropriate icons
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'food':
      case 'groceries':
      case 'eating out':
      case 'eatingout':
        return Icons.restaurant;
      case 'transport':
      case 'transportation':
        return Icons.directions_car;
      case 'home':
      case 'housing':
      case 'utilities':
        return Icons.home;
      case 'entertainment':
      case 'fun':
        return Icons.movie;
      case 'health':
      case 'medical':
        return Icons.local_hospital;
      case 'shopping':
      case 'clothes':
        return Icons.shopping_bag;
      case 'education':
      case 'learning':
        return Icons.school;
      case 'travel':
      case 'vacation':
        return Icons.flight;
      default:
        return Icons.category;
    }
  }

  void _loadExpenseCategories() {
    // Use only fixed frontend categories for both pro and non-pro users
    _loadStaticExpenseCategories();
  }

  void _loadIncomeCategories() {
    final cats = CategoryModel.getIncomeCategories();
    incomeCategories.assignAll(cats.map((c) => {
      'name': c.name,
      'iconPath': c.icon,
    }).toList());
    if (incomeCategories.isNotEmpty) {
      selectedIncomeCategory.value = incomeCategories.first['name'];
    }
  }

  void _loadStaticExpenseCategories() {
    final cats = CategoryModel.getExpenseCategories();
    expenseCategories.assignAll(cats.map((c) => {
      'name': c.name,
      'iconPath': c.icon,
    }).toList());
    if (expenseCategories.isNotEmpty) {
      selectedExpenseCategory.value = expenseCategories.first['name'];
    }
  }

  void _initializeControllers() {
    amountController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> _loadUnlockStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isExpenseProUnlocked.value = prefs.getBool('isExpenseProUnlocked') ?? false;
    isIncomeProUnlocked.value = prefs.getBool('isIncomeProUnlocked') ?? false;
  }

  Future<void> unlockProFeatures(bool isExpense) async {
    final prefs = await SharedPreferences.getInstance();
    // Unlock both features when watching ad
    isExpenseProUnlocked.value = true;
    isIncomeProUnlocked.value = true;
    await prefs.setBool('isExpenseProUnlocked', true);
    await prefs.setBool('isIncomeProUnlocked', true);
  }

  void switchToTab(int tab) {
    currentTab.value = tab;
    clearSelections();
  }

  void selectExpenseCategory(String category) {
    selectedExpenseCategory.value = category;
  }


  void selectIncomeCategory(String category) {
    selectedIncomeCategory.value = category;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void clearSelections() {
    selectedExpenseCategory.value = '';
    selectedIncomeCategory.value = '';
    selectedPaymentMethod.value = '';
  }

  // New method for processing OCR raw text for expenses
  Future<void> processOcrExpense(String rawText) async {
    if (!isExpenseProUnlocked.value) {
      Get.snackbar('Error', 'Pro feature required. Watch ad to unlock.');
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.request(
        'POST',
        _configService.ocrRawEndpoint,
        body: {'rawText': rawText},
        requiresAuth: true,
      );
      if (response['success'] == true) {
        Get.snackbar('Success', 'Expense created from OCR text');
        amountController.clear();
        descriptionController.clear();
        clearSelections();
        // Optionally navigate back or refresh parent screen
        // Get.back();
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to process OCR');
      }
    } catch (e) {
      Get.snackbar('Error', 'API Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // New method for processing OCR raw text for income
  Future<void> processOcrIncome(String rawText) async {
    if (!isIncomeProUnlocked.value) {
      Get.snackbar('Error', 'Pro feature required. Watch ad to unlock.');
      return;
    }
    // Income OCR not supported yet - use expense endpoint for now
    Get.snackbar('Info', 'Income OCR coming soon. Use expense OCR for now.');
    return;
  }

  // Unified method for OCR processing based on current tab
  Future<void> processOcrRawText(String rawText) async {
    if (currentTab.value == 0) {
      await processOcrExpense(rawText);
    } else {
      await processOcrIncome(rawText);
    }
  }

  // Keep existing addTransaction implementation (calls _expenseController.addExpense for expenses)
  Future<void> addTransaction() async {
    if (currentTab.value == 0) {
      // Expense
      final text = amountController.text.trim();
      if (text.isEmpty) {
        Get.snackbar('Error', 'Please enter an amount');
        return;
      }
      final amount = double.tryParse(text);
      if (amount == null || amount <= 0) {
        Get.snackbar('Error', 'Enter a valid positive amount');
        return;
      }
      if (selectedExpenseCategory.value.isEmpty) {
        Get.snackbar('Error', 'Please select a category');
        return;
      }
      isLoading.value = true;
      // Always use category name and send month like income
      final month = DateFormat('yyyy-MM').format(selectedDate.value);
      final success = await _expenseController.addExpense(
        amount: amount,
        category: selectedExpenseCategory.value,
        note: selectedExpenseCategory.value,
        month: month,
      );
      isLoading.value = false;
      if (success) {
        Get.snackbar('Success', 'Expense added');
        amountController.clear();
        descriptionController.clear();
        clearSelections();
        Get.back();
      } else {
        Get.snackbar('Error', _expenseController.errorMessage.value.isNotEmpty
            ? _expenseController.errorMessage.value
            : 'Failed to add expense');
      }
    } else {
      // Income: Wire to IncomeService
      final text = amountController.text.trim();
      if (text.isEmpty) {
        Get.snackbar('Error', 'Please enter an amount');
        return;
      }
      final amount = double.tryParse(text);
      if (amount == null || amount <= 0) {
        Get.snackbar('Error', 'Enter a valid positive amount');
        return;
      }
      if (selectedIncomeCategory.value.isEmpty) {
        Get.snackbar('Error', 'Please select an income source');
        return;
      }
      isLoading.value = true;
      try {
        final incomeService = Get.find<IncomeService>();
        final month = DateFormat('yyyy-MM').format(selectedDate.value);
        await incomeService.createIncome(
          source: selectedIncomeCategory.value,
          amount: amount,
          month: month,
        );
        try {
          final home = Get.find<HomeController>();
          home.addTransaction(selectedIncomeCategory.value, amount.toStringAsFixed(0), true);
          await home.fetchBudgetData();
          await home.fetchRecentTransactions();
        } catch (_) {}
        Get.snackbar('Success', 'Income added');
        amountController.clear();
        descriptionController.clear();
        clearSelections();
        Get.back();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add income');
      } finally {
        isLoading.value = false;
      }
    }
  }


  // OCR helpers
  Future<void> processOCRFromCamera(bool isExpense) async {
    if (!isExpense) {
      Get.snackbar('Error', 'OCR currently supports expenses only');
      return;
    }
    try {
      isProcessingOCR.value = true;
      // For web, fallback to manual entry dialog
      if (kIsWeb) {
        await _promptAndProcessRawText(isExpense);
        return;
      }
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
      if (image == null) {
        isProcessingOCR.value = false;
        return;
      }
      final rawText = await _extractTextFromImagePath(image.path);
      if ((rawText ?? '').trim().isEmpty) {
        Get.snackbar('Warning', 'No readable text found. Enter manually.');
        await _promptAndProcessRawText(isExpense);
        return;
      }
      await _handleOcrRawText(rawText!.trim(), isExpense);
    } catch (e) {
      Get.snackbar('Error', 'Camera OCR failed: ${e.toString()}');
    } finally {
      isProcessingOCR.value = false;
    }
  }

  Future<void> processOCRFromGallery(bool isExpense) async {
    if (!isExpense) {
      Get.snackbar('Error', 'OCR currently supports expenses only');
      return;
    }
    try {
      isProcessingOCR.value = true;
      if (kIsWeb) {
        await _promptAndProcessRawText(isExpense);
        return;
      }
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (image == null) {
        isProcessingOCR.value = false;
        return;
      }
      final rawText = await _extractTextFromImagePath(image.path);
      if ((rawText ?? '').trim().isEmpty) {
        Get.snackbar('Warning', 'No readable text found. Enter manually.');
        await _promptAndProcessRawText(isExpense);
        return;
      }
      await _handleOcrRawText(rawText!.trim(), isExpense);
    } catch (e) {
      Get.snackbar('Error', 'Gallery OCR failed: ${e.toString()}');
    } finally {
      isProcessingOCR.value = false;
    }
  }

  Future<void> processOCRFromBarcode(bool isExpense) async {
    if (!isExpense) {
      Get.snackbar('Error', 'OCR currently supports expenses only');
      return;
    }
    if (kIsWeb) {
      await _promptAndProcessRawText(isExpense, title: 'Enter Receipt Text (Barcode)');
      return;
    }
    final result = await Get.to(() => const BarcodeScannerScreen());
    final scanned = (result is String) ? result.trim() : '';
    if (scanned.isEmpty) {
      Get.snackbar('Warning', 'No readable code found. Enter manually.');
      await _promptAndProcessRawText(isExpense, title: 'Enter Receipt Text (Barcode)');
      return;
    }
    await _handleOcrRawText(scanned, isExpense);
  }

  Future<void> _promptAndProcessRawText(bool isExpense, {String title = 'Enter Receipt Text'}) async {
    final textController = TextEditingController();
    await Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          Text('Paste the receipt text to process.'),
          const SizedBox(height: 8),
          TextField(
            controller: textController,
            maxLines: 6,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          final text = textController.text.trim();
          if (text.isEmpty) {
            Get.snackbar('Error', 'Text cannot be empty');
            return;
          }
          Get.back();
          await _handleOcrRawText(text, isExpense);
        },
        child: const Text('Post'),
      ),
      cancel: TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
    );
  }

  Future<void> _handleOcrRawText(String rawText, bool isExpense) async {
    try {
      isProcessingOCR.value = true;
      final resp = await _ocrService.processOCR(rawText);
      final success = (resp['success'] == true);
      if (!success) {
        Get.snackbar('Warning', 'Unable to extract data. Please try again or enter manually.');
        return;
      }
      final data = resp['data'] as Map<String, dynamic>?;
      if (data == null) {
        Get.snackbar('Warning', 'No data returned from OCR.');
        return;
      }
      await _addExpenseFromOCRData(data);
      Get.snackbar('Success', 'Expense created successfully from OCR text.');
    } on Exception catch (e) {
      Get.snackbar('Error', 'OCR request failed: ${e.toString()}');
    } finally {
      isProcessingOCR.value = false;
    }
  }

  Future<void> _addExpenseFromOCRData(Map<String, dynamic> data) async {
    try {
      // Create local ExpenseItem and insert into lists via controller
      final item = ExpenseItem.fromJson(data);
      _expenseController.allExpenses.insert(0, item);
      _expenseController.applyMonthFilter();

      // Update Home recent transactions and budget
      if (Get.isRegistered<HomeController>()) {
        final home = Get.find<HomeController>();
        final source = (data['source']?.toString() ?? '').isNotEmpty
            ? data['source'].toString()
            : (data['category']?.toString() ?? 'Expense');
        final amountStr = (data['amount'] ?? 0).toString();
        home.addTransaction(source, amountStr, false);
        Future(() async {
          try {
            await home.fetchBudgetData();
            await home.fetchRecentTransactions();
          } catch (_) {}
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sync OCR expense locally: ${e.toString()}');
    }
  }

  Future<String?> _extractTextFromImagePath(String path) async {
    try {
      // For now, rely on backend rawText flow; MLKit can be integrated later.
      // Return null to prompt manual entry when local OCR is not implemented.
      return await _ocrService.extractTextFromImagePath(path);
    } catch (_) {
      return null;
    }
  }
}