import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../make it pro/AdvertisementPage/add_ui.dart';
import 'proexpincome_controller.dart';

class ProExpensesIncomeScreen extends StatelessWidget {
  const ProExpensesIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProExpensesIncomeController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            color: Colors.grey[50],
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Obx(() => Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.switchToTab(0),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: controller.currentTab.value == 0
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Expense',
                                  style: TextStyle(
                                    color: controller.currentTab.value == 0
                                        ? Colors.white
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.switchToTab(1),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: controller.currentTab.value == 1
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Income',
                                  style: TextStyle(
                                    color: controller.currentTab.value == 1
                                        ? Colors.white
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.currentTab.value == 0) {
                return controller.isExpenseProUnlocked.value
                    ? _buildExpenseTab(controller)
                    : _buildLockedState('Expense Pro', controller, true);
              } else {
                return controller.isIncomeProUnlocked.value
                    ? _buildIncomeTab(controller)
                    : _buildLockedState('Income Pro', controller, false);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedState(String type, ProExpensesIncomeController controller, bool isExpense) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              '$type Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Watch a short video to unlock',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final unlocked = await Get.to<bool>(
                      () => AdvertisementPage(isFromExpense: isExpense),
                  fullscreenDialog: true,
                );

                if (unlocked == true) {
                  controller.isExpenseProUnlocked.value = true;
                  controller.isIncomeProUnlocked.value = true;
                  controller.currentTab.refresh();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Watch Ad to Unlock',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseTab(ProExpensesIncomeController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptSection(Colors.orange, controller),
          const SizedBox(height: 30),
          _buildCategorySection(controller.expenseCategories, true, controller),
          const SizedBox(height: 30),
          _buildAmountSection(controller),
          const SizedBox(height: 20),
          _buildTextBoxSection(controller),
          const SizedBox(height: 20),
          _buildPaymentMethodSection(controller),
          const SizedBox(height: 30),
          _buildDateTimeSection(controller),
          const SizedBox(height: 40),
          _buildAddButton(controller),
        ],
      ),
    );
  }

  Widget _buildIncomeTab(ProExpensesIncomeController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptSection(Colors.green, controller),
          const SizedBox(height: 30),
          _buildCategorySection(controller.incomeCategories, false, controller),
          const SizedBox(height: 30),
          _buildAmountSection(controller),
          const SizedBox(height: 20),
          _buildTextBoxSection(controller),
          const SizedBox(height: 20),
          _buildPaymentMethodSection(controller),
          const SizedBox(height: 30),
          _buildDateTimeSection(controller),
          const SizedBox(height: 40),
          _buildAddButton(controller),
        ],
      ),
    );
  }

  Widget _buildReceiptSection(Color color, ProExpensesIncomeController controller) {
    return Column(
      children: [
        const Text(
          'Scan or upload receipt',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildReceiptOption(
              Icons.camera_alt,
              color,
                  () => controller.handleReceiptAction('camera'),
            ),
            _buildReceiptOption(
              Icons.qr_code_scanner,
              color,
                  () => controller.handleReceiptAction('scanner'),
            ),
            _buildReceiptOption(
              Icons.image,
              color,
                  () => controller.handleReceiptAction('gallery'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReceiptOption(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: Colors.black54,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      RxList<Map<String, dynamic>> categories,
      bool isExpense,
      ProExpensesIncomeController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Obx(() => Wrap(
          spacing: 12,
          runSpacing: 15,
          children: [
            // Display existing categories
            ...categories.map((category) {
              String categoryName = category['name'];
              bool isSelected = isExpense
                  ? controller.selectedExpenseCategory.value == categoryName
                  : controller.selectedIncomeCategory.value == categoryName;

              return GestureDetector(
                onTap: () {
                  if (isExpense) {
                    controller.selectExpenseCategory(categoryName);
                  } else {
                    controller.selectIncomeCategory(categoryName);
                  }
                },
                child: Container(
                  width: 68,
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ] : [],
                        ),
                        child: category['iconPath'] != null
                            ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            category['iconPath'],
                            width: 26,
                            height: 26,
                            color: isSelected ? Colors.white : Colors.black54,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                category['icon'] ?? Icons.category,
                                color: isSelected ? Colors.white : Colors.black54,
                                size: 24,
                              );
                            },
                          ),
                        )
                            : Icon(
                          category['icon'] ?? Icons.category,
                          color: isSelected ? Colors.white : Colors.black54,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.blue : Colors.black54,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            // Add Category Button
            GestureDetector(
              onTap: () => _navigateToAddCategory(controller, isExpense),
              child: Container(
                width: 68,
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildAmountSection(ProExpensesIncomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amount',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller.amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: '\$ Enter amount',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextBoxSection(ProExpensesIncomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text box',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller.descriptionController,
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              hintText: '(Optional)',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection(ProExpensesIncomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: controller.paymentMethods.map((method) {
            String methodName = method['name'];
            bool isSelected = controller.selectedPaymentMethod.value == methodName;

            return GestureDetector(
              onTap: () => controller.selectPaymentMethod(methodName),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Icon(
                      method['icon'],
                      color: isSelected ? Colors.white : Colors.black54,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    methodName,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue : Colors.black54,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildDateTimeSection(ProExpensesIncomeController controller) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Default',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  controller.getFormattedDateTime(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set Date & Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDateTime(controller),
                child: Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    controller.getFormattedDate(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(ProExpensesIncomeController controller) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.addTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: controller.isLoading.value
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Add',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      )),
    );
  }

  void _selectDateTime(ProExpensesIncomeController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: controller.selectedTime.value,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        controller.selectDate(pickedDate);
        controller.selectTime(pickedTime);
      }
    }
  }

  void _navigateToAddCategory(ProExpensesIncomeController controller, bool isExpense) async {
    final result = await Get.toNamed('/addCategory', arguments: {'isExpense': isExpense});

    if (result != null && result is Map<String, dynamic>) {
      // Create the category map with the icon path
      final category = {
        'name': result['name'],
        'icon': Icons.category, // Default fallback icon
        'iconPath': result['iconPath'],
      };

      // Add to the appropriate category list
      if (isExpense) {
        controller.expenseCategories.add(category);
      } else {
        controller.incomeCategories.add(category);
      }

      Get.snackbar(
        'Success',
        'Category added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}