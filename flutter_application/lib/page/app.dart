import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_application/page/test/restore/restore_page.dart';
import 'package:flutter_application/page/test/test_page.dart';
import 'package:flutter_application/page/test/theme/theme_settings.dart';
import 'package:flutter_application/theme/themes_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.themeController,
  });

  final ThemesController themeController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    // 使用AnimatedBuilder监听themeController改变来实现动态切换主题的效果
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context) => themeController),
        ],
        child: AnimatedBuilder(
          animation: themeController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              // 意外关闭缓存
              restorationScopeId: 'root', // 打开这个可使navigator缓存被关闭前的数据
              // 页面跳转
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    Widget page;
                    switch (routeSettings.name) {
                      case RestorePage.routeName:
                        page = const RestorePage(title: 'Flutter Demo Home Page');
                      case ThemeSettings.routeName:
                        page = ThemeSettings(controller: themeController);
                      default:
                        page = const TestPage();
                    }
                    // 使用RootRestorationScope(restorationId: 'root', child: page)缓存各个页面被关闭前的数据
                    return RootRestorationScope(restorationId: routeSettings.name, child: page);
                  },
                );
              },
              //       theme: ThemeData(
              //         // This is the theme of your application.
              //         //
              //         // TRY THIS: Try running your application with "flutter run". You'll see
              //         // the application has a blue toolbar. Then, without quitting the app,
              //         // try changing the seedColor in the colorScheme below to Colors.green
              //         // and then invoke "hot reload" (save your changes or press the "hot
              //         // reload" button in a Flutter-supported IDE, or press "r" if you used
              //         // the command line to start the app).
              //         //
              //         // Notice that the counter didn't reset back to zero; the application
              //         // state is not lost during the reload. To reset the state, use hot
              //         // restart instead.
              //         //
              //         // This works for code too, not just values: Most code changes can be
              //         // tested with just a hot reload.
              //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //         useMaterial3: true,
              //       ),
              // 主题
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: themeController.themeMode,

              // 国际化
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
                Locale("zh", "CN"), // 中文简体
              ],
            );
          },
        ),
    );
  }
}
