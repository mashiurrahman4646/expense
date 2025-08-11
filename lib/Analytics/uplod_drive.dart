import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Analytics/uplode_drive_controller.dart';


class UploadToDriveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadToDriveController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(screenWidth),
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildConnectedAccount(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                  _buildExportDataSection(controller, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                  _buildFileFormatSection(controller, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                  _buildLastUploadedInfo(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildAutoUploadToggle(controller, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildActionButtons(controller, screenWidth, screenHeight),
                ],
              ),
            ),
          ),
          // Success Dialog Overlay
          if (controller.showSuccessDialog.value)
            _buildSuccessDialog(controller, screenWidth, screenHeight),
        ],
      )),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: screenWidth * 0.05,
        ),
      ),
      title: Text(
        'Upload to drive',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildConnectedAccount(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connected Account',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/icons_google.png',
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(screenWidth * 0.01),
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'youremail@gmail.com',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Connected',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExportDataSection(UploadToDriveController controller, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Export Data',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        _buildCheckboxItem('All files', controller.allFiles, controller.toggleAllFiles, screenWidth),
        _buildCheckboxItem('Monthly reports', controller.monthlyReports, controller.toggleMonthlyReports, screenWidth),
        _buildCheckboxItem('Income reports', controller.incomeReports, controller.toggleIncomeReports, screenWidth),
        _buildCheckboxItem('Expense reports', controller.expenseReports, controller.toggleExpenseReports, screenWidth),
        _buildCheckboxItem('Savings reports', controller.savingsReports, controller.toggleSavingsReports, screenWidth),
      ],
    );
  }

  Widget _buildCheckboxItem(String title, RxBool value, VoidCallback onTap, double screenWidth) {
    return Obx(() => GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
              decoration: BoxDecoration(
                color: value.value ? const Color(0xFF2196F3) : Colors.transparent,
                border: Border.all(
                  color: value.value ? const Color(0xFF2196F3) : Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.01),
              ),
              child: value.value
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: screenWidth * 0.035,
              )
                  : null,
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildFileFormatSection(UploadToDriveController controller, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose file format',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        _buildRadioItem('PDF (Recommended)', 'PDF', controller.selectedFormat, controller.selectFormat, screenWidth),
        _buildRadioItem('Excel.xlsx', 'Excel', controller.selectedFormat, controller.selectFormat, screenWidth),
        _buildRadioItem('CSV', 'CSV', controller.selectedFormat, controller.selectFormat, screenWidth),
      ],
    );
  }

  Widget _buildRadioItem(String title, String value, RxString selectedValue, Function(String) onSelect, double screenWidth) {
    return Obx(() => GestureDetector(
      onTap: () => onSelect(value),
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedValue.value == value ? const Color(0xFF2196F3) : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selectedValue.value == value
                  ? Center(
                child: Container(
                  width: screenWidth * 0.025,
                  height: screenWidth * 0.025,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildLastUploadedInfo(double screenWidth) {
    return Text(
      'Last uploaded: July 20, 2025, at 11:30 PM',
      style: TextStyle(
        fontSize: screenWidth * 0.03,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildAutoUploadToggle(UploadToDriveController controller, double screenWidth, double screenHeight) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Automatically upload reports monthly',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.black,
          ),
        ),
        Switch(
          value: controller.autoUpload.value,
          onChanged: controller.toggleAutoUpload,
          activeColor: const Color(0xFF2196F3),
        ),
      ],
    ));
  }

  Widget _buildActionButtons(UploadToDriveController controller, double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Download Button
        GestureDetector(
          onTap: controller.onDownloadClick,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Text(
              'Download',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        // Upload to Drive Button
        GestureDetector(
          onTap: controller.onUploadToDriveClick,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/uplode.png',
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  color: Colors.white,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                      size: screenWidth * 0.05,
                    );
                  },
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Upload to drive',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessDialog(UploadToDriveController controller, double screenWidth, double screenHeight) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          padding: EdgeInsets.all(screenWidth * 0.06),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Upload Successful',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Your selected data has been\nUploaded to Google Drive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              GestureDetector(
                onTap: controller.closeDialogAndNavigateToAnalytics,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}