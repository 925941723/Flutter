// import 'dart:ui';

import 'package:flutter/material.dart';
import 'theme_source.dart';
import 'theme_source_dark.dart';

import 'themes_service.dart';
import 'theme_source_light.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class ThemesController with ChangeNotifier {
  ThemesController(this._themesService);

  // Make SettingsService a private variable so it is not used directly.
  final ThemesService _themesService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;
  late ThemeSource _themeSource;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;
  ThemeSource get themeSource => _themeSource;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _themesService.themeMode();
    setThemeSource();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;
    setThemeSource();

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _themesService.updateThemeMode(newThemeMode);
  }

  /// 设置主题资源
  void setThemeSource(){
    switch(_themeMode.name){
      case 'light':
        _themeSource = ThemeColorLight().themeSource;
        break;
      case 'dark':
        _themeSource = ThemeColorDark().themeSource;
        break;
      case 'system':
      // 为兼容多window，默认取第一个window: WidgetsBinding.instance.platformDispatcher.views.first
        if(Brightness.light == WidgetsBinding.instance.platformDispatcher.views.first.platformDispatcher.platformBrightness) {
          _themeSource = ThemeColorLight().themeSource;
        }else{
          _themeSource = ThemeColorDark().themeSource;
        }
        break;
      default:
        _themeSource = ThemeColorLight().themeSource;
        break;
    }
  }
}
