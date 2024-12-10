

import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static const String _onboardingKey = 'onboarding_seen';

  // Проверка, был ли онбординг показан
  static Future<bool> isOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Установка флага, что онбординг был просмотрен
  static Future<void> setOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}
