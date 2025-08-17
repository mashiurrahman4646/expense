import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  static const String _langKey = "selected_language";

  var selectedLanguage = 'English'.obs;
  final locale = const Locale('en', 'US').obs;

  final List<String> languages = [
    'English',
    'Español',
    'Italiano',
    'Português',
    'Polski',
    'Français',
    'Türkçe',
  ];

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  /// Load language from SharedPreferences
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    selectedLanguage.value = prefs.getString(_langKey) ?? 'English';
    updateLocale();
  }

  /// Change language and save to SharedPreferences
  Future<void> changeLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, language);
    selectedLanguage.value = language;
    updateLocale();
  }

  /// Update GetX locale
  void updateLocale() {
    switch (selectedLanguage.value) {
      case 'Español':
        locale.value = const Locale('es', 'ES');
        break;
      case 'Italiano':
        locale.value = const Locale('it', 'IT');
        break;
      case 'Português':
        locale.value = const Locale('pt', 'PT');
        break;
      case 'Polski':
        locale.value = const Locale('pl', 'PL');
        break;
      case 'Français':
        locale.value = const Locale('fr', 'FR');
        break;
      case 'Türkçe':
        locale.value = const Locale('tr', 'TR');
        break;
      default:
        locale.value = const Locale('en', 'US');
    }
    Get.updateLocale(locale.value);
  }
}