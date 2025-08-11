import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../homepage/main_home_page_controller.dart';
import 'analytics_controller.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalyticsController());
    final homeCtrl = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeCtrl.selectedNavIndex.value != 1) {
        homeCtrl.selectedNavIndex.value = 1;
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(screenWidth),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              _buildChartTypeButtons(controller, screenWidth),
              SizedBox(height: screenHeight * 0.03),
              _buildMonthSelector(controller, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.04),
              _buildChart(controller, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildLegend(controller, screenWidth),
              SizedBox(height: screenHeight * 0.04),
              _buildSummaryCards(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.04),
              _buildActionsSection(controller, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(controller, homeCtrl, screenWidth, screenHeight),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // This line removes the back button.
      title: Text(
        'Analytics',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildChartTypeButtons(AnalyticsController controller, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => _buildChartTypeButton('Pie Chart', 0, controller, screenWidth)),
          Obx(() => _buildChartTypeButton('Bar Chart', 1, controller, screenWidth)),
          Obx(() => _buildChartTypeButton('Line Chart', 2, controller, screenWidth)),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton(String title, int index, AnalyticsController controller, double screenWidth) {
    bool isSelected = controller.selectedChartType.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectChartType(index),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade600,
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.012,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.getCurrentMonthAndYear(),
            style: TextStyle(
              color: const Color(0xFF2196F3),
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF2196F3),
            size: screenWidth * 0.045,
          ),
        ],
      ),
    );
  }

  Widget _buildChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Obx(() => Container(
      height: screenHeight * 0.35,
      child: controller.selectedChartType.value == 0
          ? _buildPieChart(controller, screenWidth, screenHeight)
          : controller.selectedChartType.value == 1
          ? _buildBarChart(controller, screenWidth, screenHeight)
          : _buildLineChart(controller, screenWidth, screenHeight),
    ));
  }

  Widget _buildPieChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    final pieData = controller.getCombinedChartData();
    return Center(
      child: CustomPaint(
        size: Size(screenWidth * 0.6, screenWidth * 0.6),
        painter: PieChartPainter(pieData),
      ),
    );
  }

  Widget _buildBarChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth * 0.85,
        child: CustomPaint(
          painter: BarChartPainter(controller.getCombinedChartData()),
        ),
      ),
    );
  }

  Widget _buildLineChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth * 0.85,
        child: CustomPaint(
          painter: LineChartPainter(controller.getLineChartData()),
        ),
      ),
    );
  }

  Widget _buildLegend(AnalyticsController controller, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expenses',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              ...controller.expenseData.map((data) {
                return _buildLegendItem(data.label, '${data.value.toStringAsFixed(0)}%', data.color, screenWidth);
              }).toList(),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Income',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              ...controller.incomeData.map((data) {
                return _buildLegendItem(data.label, '${data.value.toStringAsFixed(0)}%', data.color, screenWidth);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String amount, Color color, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.025,
            height: screenWidth * 0.025,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              '$label: $amount',
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                color: Colors.grey.shade700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(double screenWidth, double screenHeight) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Expenses',
            '\$2012',
            Icons.arrow_downward,
            Colors.orange,
            screenWidth,
            screenHeight,
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: _buildSummaryCard(
            'Total Income',
            '\$3124',
            Icons.arrow_upward,
            Colors.green,
            screenWidth,
            screenHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color iconColor,
      double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: screenWidth * 0.05),
              SizedBox(width: screenWidth * 0.02),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            amount,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        GestureDetector(
          onTap: controller.onExpensesClick,
          child: _buildActionItem('Expenses', screenWidth),
        ),
        GestureDetector(
          onTap: controller.onIncomeClick,
          child: _buildActionItem('Income', screenWidth),
        ),
        GestureDetector(
          onTap: controller.onExportReportClick,
          child: _buildActionItem('Export Report', screenWidth),
        ),
      ],
    );
  }

  Widget _buildActionItem(String title, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade600,
            size: screenWidth * 0.04,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(AnalyticsController controller, HomeController homeCtrl, double screenWidth, double screenHeight) {
    return Obx(() => Container(
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildImageNavItem(homeCtrl, 0, 'assets/icons/home (2).png', 'Home', screenWidth),
          _buildImageNavItem(homeCtrl, 1, 'assets/icons/analysis.png', 'Analytics', screenWidth),
          GestureDetector(
            onTap: controller.navigateToAddTransaction,
            child: Container(
              width: screenWidth * 0.14,
              height: screenWidth * 0.14,
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/plus.png',
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildImageNavItem(homeCtrl, 2, 'assets/icons/compare.png', 'Comparison', screenWidth),
          _buildImageNavItem(homeCtrl, 3, 'assets/icons/setting.png', 'Settings', screenWidth),
        ],
      ),
    ));
  }

  Widget _buildImageNavItem(HomeController homeCtrl, int index, String iconPath, String label, double screenWidth) {
    bool isActive = homeCtrl.selectedNavIndex.value == index;
    return GestureDetector(
      onTap: () => homeCtrl.changeNavIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
            color: isActive ? const Color(0xFF2196F3) : Colors.grey.shade600,
          ),
          SizedBox(height: screenWidth * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: isActive ? const Color(0xFF2196F3) : Colors.grey.shade600,
            ),
          ),
          if (isActive) ...[
            SizedBox(height: screenWidth * 0.005),
            Container(width: screenWidth * 0.05, height: 2, color: const Color(0xFF2196F3)),
          ]
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<ChartData> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final innerRadius = 0.0;

    double total = data.fold(0.0, (sum, item) => sum + item.value);
    if (total == 0) return;

    double startAngle = -math.pi / 2;
    const gapAngle = 0.0;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / total) * 2 * math.pi;

      final paint = Paint()
        ..color = data[i].color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => true;
}

class BarChartPainter extends CustomPainter {
  final List<ChartData> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height * 0.7;
    final chartTop = size.height * 0.1;
    final chartBottom = chartTop + chartHeight;
    final chartLeft = size.width * 0.1;
    final chartRight = size.width * 0.95;
    final chartWidth = chartRight - chartLeft;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    final maxVal = 100.0;
    final textStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );

    for (int i = 0; i <= 10; i++) {
      final y = chartBottom - (chartHeight * i / 10);
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: '${i * 10}%', style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    final totalBars = data.length;
    final barWidth = chartWidth / (totalBars * 1.5) * 0.8;
    final barGap = (chartWidth - (barWidth * totalBars)) / (totalBars + 1);
    double currentX = chartLeft + barGap;

    final categoryTextStyle = TextStyle(
      color: Colors.grey.shade700,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );

    for (int i = 0; i < totalBars; i++) {
      final barHeight = (data[i].value / maxVal) * chartHeight;
      final y = chartBottom - barHeight;

      final barPaint = Paint()
        ..color = data[i].color
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(currentX, y, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, barPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: data[i].label, style: categoryTextStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final labelX = currentX + (barWidth - textPainter.width) / 2;
      final labelY = chartBottom + 8;
      textPainter.paint(canvas, Offset(labelX, labelY));

      currentX += barWidth + barGap;
    }

    final expenseLinePaint = Paint()
      ..color = const Color(0xFFFFA000)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final incomeLinePaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final lineY = chartBottom + 30;

    final expenseStart = chartLeft + barGap + (barWidth + barGap) * 0;
    final expenseEnd = chartLeft + barGap + (barWidth + barGap) * (4 - 1) + barWidth;

    final incomeStart = chartLeft + barGap + (barWidth + barGap) * 4;
    final incomeEnd = chartRight;

    canvas.drawLine(Offset(expenseStart, lineY), Offset(expenseEnd, lineY), expenseLinePaint);
    canvas.drawLine(Offset(incomeStart, lineY), Offset(incomeEnd, lineY), incomeLinePaint);

    final paintCircle = Paint()..color = const Color(0xFFFFA000)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(expenseStart, lineY), 4, paintCircle);
    canvas.drawCircle(Offset(expenseEnd, lineY), 4, paintCircle);

    paintCircle.color = const Color(0xFF4CAF50);
    canvas.drawCircle(Offset(incomeStart, lineY), 4, paintCircle);
    canvas.drawCircle(Offset(incomeEnd, lineY), 4, paintCircle);

    final labelTextStyle = TextStyle(
      color: Colors.grey.shade700,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );

    final expenseLabelPainter = TextPainter(
      text: TextSpan(text: 'Expense', style: labelTextStyle),
      textDirection: TextDirection.ltr,
    );
    expenseLabelPainter.layout();
    expenseLabelPainter.paint(canvas, Offset(expenseStart + (expenseEnd - expenseStart) / 2 - expenseLabelPainter.width / 2, lineY + 10));

    final incomeLabelPainter = TextPainter(
      text: TextSpan(text: 'Income', style: labelTextStyle),
      textDirection: TextDirection.ltr,
    );
    incomeLabelPainter.layout();
    incomeLabelPainter.paint(canvas, Offset(incomeStart + (incomeEnd - incomeStart) / 2 - incomeLabelPainter.width / 2, lineY + 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LineChartPainter extends CustomPainter {
  final List<ChartData> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height * 0.7;
    final chartTop = size.height * 0.1;
    final chartBottom = chartTop + chartHeight;
    final chartLeft = size.width * 0.1;
    final chartRight = size.width * 0.95;
    final chartWidth = chartRight - chartLeft;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    final maxVal = 100.0;
    final textStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );

    for (int i = 0; i <= 10; i++) {
      final y = chartBottom - (chartHeight * i / 10);
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: '${i * 10}%', style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    final xLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    final totalPoints = xLabels.length;

    final labelPaint = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    for (int i = 0; i < totalPoints; i++) {
      final x = chartLeft + (i / (totalPoints - 1)) * chartWidth;
      labelPaint.text = TextSpan(text: xLabels[i]);
      labelPaint.layout();
      final labelX = x - labelPaint.width / 2;
      final labelY = chartBottom + 8;
      labelPaint.paint(canvas, Offset(labelX, labelY));
    }

    final linePoints = [
      [60, 50, 70, 65, 75, 70, 80],
      [50, 60, 55, 65, 55, 60, 70],
      [30, 45, 40, 50, 45, 40, 50],
      [20, 25, 30, 20, 35, 30, 40],
      [25, 30, 25, 35, 30, 35, 40],
      [10, 20, 15, 25, 30, 20, 35],
    ];
    final colors = [
      const Color(0xFFFFC107),
      const Color(0xFF4CAF50),
      const Color(0xFFFF5252),
      const Color(0xFF2196F3),
      const Color(0xFF9C27B0),
      const Color(0xFF00BCD4),
    ];

    for (int i = 0; i < linePoints.length; i++) {
      final linePaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      final path = Path();
      for (int j = 0; j < linePoints[i].length; j++) {
        final x = chartLeft + (j / (linePoints[i].length - 1)) * chartWidth;
        final y = chartBottom - (linePoints[i][j] / maxVal) * chartHeight;

        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
        canvas.drawCircle(Offset(x, y), 3, linePaint..style = PaintingStyle.fill);
      }
      canvas.drawPath(path, linePaint..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}