import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class ThemeServices {
  final GetStorage _box=GetStorage();
  final _key='isDarkMode';
  _saveThemeToBox(bool isDarkMode){
    _box.write(_key, isDarkMode);
  }
  bool _loadThemeFromBox()=>_box.read(_key)??false;//return if theme is Dark or not
  ThemeMode get Theme =>_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  void SwitchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

}
