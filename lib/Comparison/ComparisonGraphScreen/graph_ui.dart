import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';


class ComparisonGraphScreen extends StatelessWidget {
  const ComparisonGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Compare & save',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),

            // Graph Section
            Container(
              width: double.infinity,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Graph Area
                    Expanded(
                      child: CustomPaint(
                        size: Size(double.infinity, double.infinity),
                        painter: BarChartPainter(),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLegendItem('Original Price', Colors.grey),
                        _buildLegendItem('With Tool', Colors.blue),
                        _buildLegendItem('Saving', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Amazon Deal Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Amazon Logo
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/icons/AmazonLogo.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.store,
                            color: Colors.orange,
                            size: 24,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amazon',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Nike Air Max 270 - Men\'s Running',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Save 23%',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Purchase Now Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(AppRoutes.amazonPurchaseDetails);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  'Purchase Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Recent Purchase Section
            const Text(
              'Recent Purchase',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Recent Purchase Items
            _buildRecentPurchaseItem(
              iconAsset: 'assets/icons/Group 23.png',
              iconColor: Colors.orange,
              title: 'Magic keyboard',
              date: '06/06/25, 05:00 PM',
              price: '\$20.20',
            ),

            SizedBox(height: screenHeight * 0.02),

            _buildRecentPurchaseItem(
              iconAsset: 'assets/icons/Group 12 (1).png',
              iconColor: Colors.blue,
              title: 'Motor parts',
              date: '06/06/25, 05:00 PM',
              price: '\$150.2',
            ),

            SizedBox(height: screenHeight * 0.03),

            // View all Purchase Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.nonProSavings); // Updated navigation
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'View all Purchase',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPurchaseItem({
    required String iconAsset,
    required Color iconColor,
    required String title,
    required String date,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  iconAsset,
                  width: 20,
                  height: 20,
                  color: iconColor,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      title.toLowerCase().contains('keyboard')
                          ? Icons.keyboard
                          : Icons.build,
                      color: iconColor,
                      size: 20,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final double barWidth = size.width * 0.25;
    final double spacing = 2;
    final double maxHeight = size.height * 0.7;

    final double originalPriceHeight = maxHeight * 1.0;
    final double withToolHeight = maxHeight * 0.5;
    final double savingHeight = maxHeight * 0.3;

    final double startX = (size.width - (3 * barWidth + 2 * spacing)) / 2;

    paint.color = Colors.grey[300]!;
    paint.strokeWidth = 1;
    canvas.drawLine(
      Offset(startX - 20, 0),
      Offset(startX - 20, maxHeight),
      paint,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    List<double> yValues = [0.0, 0.5, 1.0];
    List<String> labels = ['0', '50', '100'];

    for (int i = 0; i < yValues.length; i++) {
      double y = maxHeight - (maxHeight * yValues[i]);

      paint.color = Colors.grey[300]!;
      paint.strokeWidth = 0.5;
      canvas.drawLine(
        Offset(startX - 25, y),
        Offset(size.width, y),
        paint,
      );

      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(startX - 35, y - 8));
    }

    _drawBar(
      canvas: canvas,
      x: startX,
      height: originalPriceHeight,
      maxHeight: maxHeight,
      barWidth: barWidth,
      color: Colors.grey,
    );

    _drawBar(
      canvas: canvas,
      x: startX + barWidth + spacing,
      height: withToolHeight,
      maxHeight: maxHeight,
      barWidth: barWidth,
      color: Colors.blue,
    );

    _drawBar(
      canvas: canvas,
      x: startX + 2 * (barWidth + spacing),
      height: savingHeight,
      maxHeight: maxHeight,
      barWidth: barWidth,
      color: Colors.green,
    );

    final List<String> barLabels = ['Original Price', 'With Tool', 'Saving'];
    for (int i = 0; i < 3; i++) {
      textPainter.text = TextSpan(
        text: barLabels[i],
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          startX + i * (barWidth + spacing) + (barWidth - textPainter.width) / 2,
          maxHeight + 5,
        ),
      );
    }
  }

  void _drawBar({
    required Canvas canvas,
    required double x,
    required double height,
    required double maxHeight,
    required double barWidth,
    required Color color,
  }) {
    final paint = Paint()..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          x,
          maxHeight - height,
          barWidth,
          height,
        ),
        const Radius.circular(4),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}