import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = "app_theme";
  static const String _systemKey = "system_theme";

  var selectedTheme = 'Light'.obs;
  var useSystemSettings = true.obs;

  /// Expose dark mode status
  RxBool isDarkMode = false.obs;

  ThemeMode get themeMode {
    if (useSystemSettings.value) {
      return ThemeMode.system;
    } else if (selectedTheme.value == 'Dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  /// Load theme from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    selectedTheme.value = prefs.getString(_themeKey) ?? 'Light';
    useSystemSettings.value = prefs.getBool(_systemKey) ?? true;

    // Update dark mode based on loaded theme
    _updateDarkMode();
    Get.changeThemeMode(themeMode);
  }

  /// Save theme to SharedPreferences
  Future<void> saveTheme(String theme, bool system) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
    await prefs.setBool(_systemKey, system);

    selectedTheme.value = theme;
    useSystemSettings.value = system;

    // Update dark mode
    _updateDarkMode();
    Get.changeThemeMode(themeMode);
  }

  /// Private method to update isDarkMode
  void _updateDarkMode() {
    if (useSystemSettings.value) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      isDarkMode.value = brightness == Brightness.dark;
    } else {
      isDarkMode.value = selectedTheme.value == 'Dark';
    }
  }
}
