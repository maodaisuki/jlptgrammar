import 'package:shared_preferences/shared_preferences.dart';
import 'package:jlptgrammar/common/global.dart';

class ConfigTool {

  Future<void> saveTheme(bool isLightTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightTheme', isLightTheme);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isLightTheme = prefs.getBool('isLightTheme') ?? true;
    return isLightTheme;
  }

  Future<void> saveFontSize(String setFontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('setFontSize', setFontSize);
  }

  Future<String> loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final setFontSize = prefs.getString('setFontSize');
    return setFontSize!;
  }
}