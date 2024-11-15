// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final themeModeProvider = StateProvider<ThemeMode>((ref) {
//   return ThemeMode.light;
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);
  final SharedPreferencesAsync prefs =  SharedPreferencesAsync();

  Future setTheme() async {
    state = !state;
    await prefs.setBool('theme', state);
  }

  Future getTheme() async {
   // final SharedPreferencesAsync prefs =  SharedPreferencesAsync();
    final savedTheme = await prefs.getBool('theme');
    state = savedTheme ?? false;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
