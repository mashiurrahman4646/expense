import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../add_exp/normaluser/normal_income_and_exp_screen.dart';
import '../../add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';


class AdvertisementPage extends StatefulWidget {
  final bool isFromExpense;

  const AdvertisementPage({super.key, required this.isFromExpense});

  @override
  State<AdvertisementPage> createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
  late final ProExpensesIncomeController proController;
  int _remainingSeconds = 30;
  late Timer _timer;
  bool _isVideoPlaying = false;
  bool _isVideoComplete = false;

  @override
  void initState() {
    super.initState();

    // Use global controller or create if not exists
    proController = Get.isRegistered<ProExpensesIncomeController>()
        ? Get.find<ProExpensesIncomeController>()
        : Get.put(ProExpensesIncomeController());

    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (!mounted) return;
    _isVideoPlaying = true;
    _remainingSeconds = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds == 0) {
        setState(() {
          _isVideoComplete = true;
          _isVideoPlaying = false;
        });
        timer.cancel();
        _unlockProFeatures();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _unlockProFeatures() async {
    if (!mounted) return;
    await proController.unlockProFeatures(widget.isFromExpense);
    Get.snackbar(
      'Pro Features Unlocked!',
      'Both Expense and Income Pro features are now unlocked.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.green,
      colorText: AppColors.text50,
      duration: const Duration(seconds: 2),
    );
    Get.back(result: true);
  }

  void _showExitConfirmation() {
    if (!mounted) return;
    Get.dialog(
      AlertDialog(
        title: const Text('Leave Ad?'),
        content:
        const Text('You need to watch the full ad to unlock pro features.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: AppColors.grey500),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(result: false); // Leave ad without unlock
            },
            child: Text(
              'Leave Anyway',
              style: GoogleFonts.inter(color: AppColors.text900),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_isVideoComplete) return true;
        _showExitConfirmation();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watch Ad to Unlock Pro',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.text900,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_isVideoComplete) {
                Get.back(result: true);
              } else {
                _showExitConfirmation();
              }
            },
          ),
          backgroundColor: AppColors.text50,
          elevation: 1,
        ),
        backgroundColor: AppColors.text50,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Text(
                          'Watch Ad to Unlock Pro Features',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.05),
                        GestureDetector(
                          onTap: _isVideoPlaying ? null : _startTimer,
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: AssetImage('assets/images/adv.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(
                                  AppStyles.defaultRadius ?? 12),
                            ),
                            child: Center(
                              child: _isVideoPlaying
                                  ? Text(
                                '$_remainingSeconds seconds remaining',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                                  : const Icon(
                                Icons.play_circle_filled,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Watch Video to Unlock Pro Features (30s)',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.grey500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          'After watching the ad, both Expense and Income Pro features will be unlocked',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.grey500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
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
