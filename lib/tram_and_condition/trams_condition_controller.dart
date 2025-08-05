// lib/tram_and_condition/trams_and_condition_controller.dart
import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {
  var isAccepted = false.obs;

  void toggleAcceptance(bool? value) {
    if (value != null) {
      isAccepted.value = value;
    }
  }
}