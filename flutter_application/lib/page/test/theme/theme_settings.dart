import 'package:flutter/material.dart';
import 'package:flutter_application/theme/themes_controller.dart';


/// 主题设置页面
class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key, required this.controller});

  static const routeName = '/settings';

  final ThemesController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Color(controller.themeSource.textBlack))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: DropdownButton<ThemeMode>(
          // Read the selected themeMode from the controller
          value: controller.themeMode,
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: controller.updateThemeMode,
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme', style: TextStyle(color: Color(controller.themeSource.textBlack))),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme', style: TextStyle(color: Color(controller.themeSource.textBlack))),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme', style: TextStyle(color: Color(controller.themeSource.textBlack))),
            )
          ],
        ),
      ),
    );
  }
}
