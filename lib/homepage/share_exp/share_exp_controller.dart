import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../service/review_service.dart';

// Controller for the Rate and Improve Screen
class RateAndImproveController extends GetxController {
  // Observable variable for the star rating.
  var starRating = 0.obs;
  var isLoading = false.obs;
  final TextEditingController commentController = TextEditingController();

  // Method to update the star rating with "un-rate" functionality.
  void setStarRating(int rating) {
    if (starRating.value == rating) {
      starRating.value = 0; // Un-rate the star if it's already selected.
    } else {
      starRating.value = rating;
    }
  }

  // A method to handle the feedback submission.
  Future<void> submitFeedback() async {
    if (starRating.value == 0) {
      Get.snackbar(
        'Error',
        'Please select a rating',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final ReviewService reviewService = Get.find();
      final response = await reviewService.submitReview(
        starRating.value,
        commentController.text,
      );

      // Show a success message and then navigate back.
      Get.snackbar(
        'Thank You!',
        'Your feedback has been submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );

      // Clear form
      starRating.value = 0;
      commentController.clear();

      // Navigate back after a delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit feedback: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}