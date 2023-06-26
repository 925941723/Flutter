import 'package:flutter/material.dart';
import 'package:flutter_application/page/app.dart';
import 'package:flutter_application/theme/themes_controller.dart';
import 'package:flutter_application/theme/themes_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemesController(ThemesService());
  await themeController.loadSettings();

  runApp(
      MyApp(themeController: themeController)
  );
}