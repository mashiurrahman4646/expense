import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../make it pro/AdvertisementPage/add_ui.dart';
import '../../routes/app_routes.dart';

class AppColors {
  static const Color text900 = Color(0xFF1E1E1E);
  static const Color text50 = Color(0xFFFAFAFA);
  static const Color primary = Colors.blueAccent;
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
  static const Color purple = Colors.purple;
  static const Color yellow = Color(0xFFFFD700);
  static const Color expenseButtonIcon = Colors.black;
  static const Color expenseButtonBackground = Colors.yellow;
  static const Color incomeButtonIcon = Colors.black;
  static const Color incomeButtonBackground = Colors.green;
}

class AppStyles {
  static final TextStyle sectionHeader = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.text900,
  );

  static final TextStyle buttonText = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.text900,
  );

  static final TextStyle saveButtonText = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets iconPadding = EdgeInsets.all(12);
  static const double defaultRadius = 12.0;
}

class ReceiptButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;

  const ReceiptButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppStyles.buttonText),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppStyles.iconPadding,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.grey200,
                borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.text50 : AppColors.text900,
              ),
            ),
            const SizedBox(height: 5),
            Text(label, style: AppStyles.buttonText),
          ],
        ),
      ),
    );
  }
}

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(
        backgroundColor: AppColors.text50,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: Get.back,
          ),
          title: Text(
            _selectedIndex == 0 ? 'Add Expense' : 'Add Income',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.text900,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.text50,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.primary,
                  ),
                  labelColor: AppColors.text50,
                  unselectedLabelColor: AppColors.text900,
                  onTap: (index) => setState(() => _selectedIndex = index),
                  tabs: const [
                    Tab(text: 'Expense'),
                    Tab(text: 'Income'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            const ExpensePage(),
            const IncomePage(),
          ],
        ),
      ),
    );
  }
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  int _selectedCategoryIndex = 0;
  int _selectedPaymentIndex = 0;
  final ScrollController _categoryController = ScrollController();
  final ScrollController _paymentController = ScrollController();

  @override
  void dispose() {
    _categoryController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppStyles.defaultPadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scan or upload receipt', style: AppStyles.sectionHeader),
                const SizedBox(height: 10),
                _buildReceiptButtons(isExpense: true),
                const SizedBox(height: 20),
                _buildCategorySection(),
                const SizedBox(height: 20),
                _buildAddCustomCategory(),
                const SizedBox(height: 20),
                _buildAmountSection(),
                const SizedBox(height: 20),
                _buildPaymentSection(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 20),
                _buildUpgradeButtons(),
                const SizedBox(height: 20),
                _buildSaveButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptButtons({bool isExpense = false}) {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: [
          ReceiptButton(
            icon: Icons.camera_alt,
            label: 'Camera',
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
          ReceiptButton(
            icon: Icons.qr_code_scanner,
            label: 'Barcode',
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
          ReceiptButton(
            icon: Icons.photo_library,
            label: 'Gallery',
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Category', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _categoryController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                icon: Icons.fastfood,
                label: 'Food',
                isSelected: _selectedCategoryIndex == 0,
                onTap: () => setState(() => _selectedCategoryIndex = 0),
              ),
              CategoryItem(
                icon: Icons.directions_bus,
                label: 'Transport',
                isSelected: _selectedCategoryIndex == 1,
                onTap: () => setState(() => _selectedCategoryIndex = 1),
              ),
              CategoryItem(
                icon: Icons.local_grocery_store,
                label: 'Groceries',
                isSelected: _selectedCategoryIndex == 2,
                onTap: () => setState(() => _selectedCategoryIndex = 2),
              ),
              CategoryItem(
                icon: Icons.restaurant,
                label: 'Eating Out',
                isSelected: _selectedCategoryIndex == 3,
                onTap: () => setState(() => _selectedCategoryIndex = 3),
              ),
              CategoryItem(
                icon: Icons.home,
                label: 'Home',
                isSelected: _selectedCategoryIndex == 4,
                onTap: () => setState(() => _selectedCategoryIndex = 4),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomCategory() {
    return Container(
      padding: AppStyles.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Add Custom Category',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, color: AppColors.grey500, size: 16),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'This feature is only available for pro user only',
                  style: GoogleFonts.inter(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amount', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: '\$ Enter amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: AppStyles.buttonPadding,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _paymentController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                icon: Icons.money,
                label: 'Cash',
                isSelected: _selectedPaymentIndex == 0,
                onTap: () => setState(() => _selectedPaymentIndex = 0),
              ),
              CategoryItem(
                icon: Icons.phone_android,
                label: 'Mobile',
                isSelected: _selectedPaymentIndex == 1,
                onTap: () => setState(() => _selectedPaymentIndex = 1),
              ),
              CategoryItem(
                icon: Icons.account_balance,
                label: 'Bank',
                isSelected: _selectedPaymentIndex == 2,
                onTap: () => setState(() => _selectedPaymentIndex = 2),
              ),
              CategoryItem(
                icon: Icons.credit_card,
                label: 'Card',
                isSelected: _selectedPaymentIndex == 3,
                onTap: () => setState(() => _selectedPaymentIndex = 3),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: _buildDateTimeContainer(
                  text: 'Feb 15, 2024 - 14:30',
                  color: AppColors.primary,
                  textColor: AppColors.text50,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateTimeContainer(
                  text: 'Feb 15, 2024',
                  color: AppColors.grey200,
                  textColor: AppColors.text900,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              _buildDateTimeContainer(
                text: 'Feb 15, 2024 - 14:30',
                color: AppColors.primary,
                textColor: AppColors.text50,
              ),
              const SizedBox(height: 16),
              _buildDateTimeContainer(
                text: 'Feb 15, 2024',
                color: AppColors.grey200,
                textColor: AppColors.text900,
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildDateTimeContainer({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: AppStyles.buttonPadding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: GoogleFonts.inter(color: textColor)),
          Icon(Icons.arrow_drop_down, color: textColor),
        ],
      ),
    );
  }

  Widget _buildUpgradeButtons() {
    return Column(
      children: [
        _buildUpgradeButton(
          icon: Icons.play_circle_outline,
          text: 'Watch a short video to add for free',
          color: AppColors.primary.withOpacity(0.1),
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 10),
        _buildUpgradeButton(
          icon: Icons.check_circle_outline,
          text: 'Upgrade to Pro to remove ads',
          color: AppColors.grey200,
          borderColor: AppColors.grey500,
        ),
      ],
    );
  }

  Widget _buildUpgradeButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: () async {
        if (text.contains('Watch a short video')) {
          final result = await Get.to<bool>(
                () => AdvertisementPage(isFromExpense: true),
            routeName: AppRoutes.advertisement,
          );

          if (result == true) {
            Get.offNamed(
              AppRoutes.proExpensesIncome,
              arguments: {'defaultTab': 0},
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: borderColor == AppColors.primary
                    ? AppColors.primary
                    : AppColors.text900),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: borderColor == AppColors.primary
                      ? AppColors.primary
                      : AppColors.text900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.text50,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          ),
        ),
        onPressed: () {},
        child: Text('Save', style: AppStyles.saveButtonText),
      ),
    );
  }
}

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  int _selectedCategoryIndex = 0;
  int _selectedPaymentIndex = 0;
  final ScrollController _categoryController = ScrollController();
  final ScrollController _paymentController = ScrollController();

  @override
  void dispose() {
    _categoryController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppStyles.defaultPadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scan or upload receipt', style: AppStyles.sectionHeader),
                const SizedBox(height: 10),
                _buildReceiptButtons(),
                const SizedBox(height: 20),
                _buildCategorySection(),
                const SizedBox(height: 20),
                _buildAddCustomCategory(),
                const SizedBox(height: 20),
                _buildAmountSection(),
                const SizedBox(height: 20),
                _buildPaymentSection(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 20),
                _buildUpgradeButtons(),
                const SizedBox(height: 20),
                _buildSaveButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptButtons() {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: [
          ReceiptButton(
            icon: Icons.camera_alt,
            label: 'Camera',
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
          ReceiptButton(
            icon: Icons.qr_code_scanner,
            label: 'Barcode',
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
          ReceiptButton(
            icon: Icons.photo_library,
            label: 'Gallery',
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Category', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _categoryController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                icon: Icons.fastfood,
                label: 'Food',
                isSelected: _selectedCategoryIndex == 0,
                onTap: () => setState(() => _selectedCategoryIndex = 0),
              ),
              CategoryItem(
                icon: Icons.directions_bus,
                label: 'Transport',
                isSelected: _selectedCategoryIndex == 1,
                onTap: () => setState(() => _selectedCategoryIndex = 1),
              ),
              CategoryItem(
                icon: Icons.local_grocery_store,
                label: 'Groceries',
                isSelected: _selectedCategoryIndex == 2,
                onTap: () => setState(() => _selectedCategoryIndex = 2),
              ),
              CategoryItem(
                icon: Icons.restaurant,
                label: 'Eating Out',
                isSelected: _selectedCategoryIndex == 3,
                onTap: () => setState(() => _selectedCategoryIndex = 3),
              ),
              CategoryItem(
                icon: Icons.home,
                label: 'Home',
                isSelected: _selectedCategoryIndex == 4,
                onTap: () => setState(() => _selectedCategoryIndex = 4),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomCategory() {
    return Container(
      padding: AppStyles.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Add Custom Category',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, color: AppColors.grey500, size: 16),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'This feature is only available for pro user only',
                  style: GoogleFonts.inter(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amount', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: '\$ Enter amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: AppStyles.buttonPadding,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: AppStyles.sectionHeader),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _paymentController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                icon: Icons.money,
                label: 'Cash',
                isSelected: _selectedPaymentIndex == 0,
                onTap: () => setState(() => _selectedPaymentIndex = 0),
              ),
              CategoryItem(
                icon: Icons.phone_android,
                label: 'Mobile',
                isSelected: _selectedPaymentIndex == 1,
                onTap: () => setState(() => _selectedPaymentIndex = 1),
              ),
              CategoryItem(
                icon: Icons.account_balance,
                label: 'Bank',
                isSelected: _selectedPaymentIndex == 2,
                onTap: () => setState(() => _selectedPaymentIndex = 2),
              ),
              CategoryItem(
                icon: Icons.credit_card,
                label: 'Card',
                isSelected: _selectedPaymentIndex == 3,
                onTap: () => setState(() => _selectedPaymentIndex = 3),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: _buildDateTimeContainer(
                  text: 'Feb 15, 2024 - 14:30',
                  color: AppColors.primary,
                  textColor: AppColors.text50,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateTimeContainer(
                  text: 'Feb 15, 2024',
                  color: AppColors.grey200,
                  textColor: AppColors.text900,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              _buildDateTimeContainer(
                text: 'Feb 15, 2024 - 14:30',
                color: AppColors.primary,
                textColor: AppColors.text50,
              ),
              const SizedBox(height: 16),
              _buildDateTimeContainer(
                text: 'Feb 15, 2024',
                color: AppColors.grey200,
                textColor: AppColors.text900,
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildDateTimeContainer({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: AppStyles.buttonPadding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: GoogleFonts.inter(color: textColor)),
          Icon(Icons.arrow_drop_down, color: textColor),
        ],
      ),
    );
  }

  Widget _buildUpgradeButtons() {
    return Column(
      children: [
        _buildUpgradeButton(
          icon: Icons.play_circle_outline,
          text: 'Watch a short video to add for free',
          color: AppColors.primary.withOpacity(0.1),
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 10),
        _buildUpgradeButton(
          icon: Icons.check_circle_outline,
          text: 'Upgrade to Pro to remove ads',
          color: AppColors.grey200,
          borderColor: AppColors.grey500,
        ),
      ],
    );
  }

  Widget _buildUpgradeButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: () async {
        if (text.contains('Watch a short video')) {
          final result = await Get.to<bool>(
                () => AdvertisementPage(isFromExpense: false),
            routeName: AppRoutes.advertisement,
          );

          if (result == true) {
            Get.offNamed(
              AppRoutes.proExpensesIncome,
              arguments: {'defaultTab': 1},
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: borderColor == AppColors.primary
                    ? AppColors.primary
                    : AppColors.text900),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: borderColor == AppColors.primary
                      ? AppColors.primary
                      : AppColors.text900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.text50,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          ),
        ),
        onPressed: () {},
        child: Text('Save', style: AppStyles.saveButtonText),
      ),
    );
  }
}