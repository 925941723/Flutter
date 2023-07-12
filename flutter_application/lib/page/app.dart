import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/test/future/future_page.dart';
import 'package:flutter_application/page/test/model2json/model_to_json_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
       if(kIsWeb){ // 专用在web下面，android或ios判断
        String f() => switch(Theme.of(context).platform){
           TargetPlatform.android => 'web android',
           TargetPlatform.iOS => 'web iOS',
           TargetPlatform.windows => 'web windows',
           _ => 'web ${Theme.of(context).platform}',
         };
        print(f());
       }
    // Glue the SettingsController to the MaterialApp.
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    // 使用AnimatedBuilder监听themeController改变来实现动态切换主题的效果
    // 同时使用provider，将themeController设置成全局的state，方便一个地方设置，其他地方共享该状态。其他地方的使用可以参考test_page
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeController),
      ],
      child: AnimatedBuilder(
        animation: themeController,
        builder: (BuildContext context, Widget? child) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  // Providing a restorationScopeId allows the Navigator built by the
                  // MaterialApp to restore the navigation stack when a user leaves and
                  // returns to the app after it has been killed while running in the
                  // background.
                  // 意外关闭缓存
                  restorationScopeId: 'root',
                  // 打开这个可使navigator缓存被关闭前的数据
                  // 页面跳转
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        Widget page;
                        switch (routeSettings.name) {
                          case RestorePage.routeName:
                            page = const RestorePage(
                                title: 'Flutter Demo Home Page');
                          case ThemeSettings.routeName:
                            page = ThemeSettings(controller: themeController);
                          case ModelToJsonPage.routeName:
                            page = const ModelToJsonPage();
                          case FuturePage.routeName:
                            page = const FuturePage();
                          default:
                            page = const TestPage();
                        }
                        // 使用RootRestorationScope(restorationId: 'root', child: page)缓存各个页面被关闭前的数据
                        return RootRestorationScope(
                            restorationId: routeSettings.name, child: page);
                      },
                    );
                  },
                  // 主题
                  theme: ThemeData(
                    colorScheme: const ColorScheme.light(primary: Colors.blue),
                    // primaryColor: Colors.blue,
                    // primarySwatch: Colors.blue,
                    // // useMaterial3: true,
                    // typography: Typography.material2018()
                    textTheme: Typography.englishLike2018.apply(
                        fontSizeFactor: 1.sp,
                        bodyColor: const Color(0xff333333)
                    ) // 必须加这一个，适配改变字体大小才会生效
                  ),
                  darkTheme: ThemeData(
                    colorScheme: const ColorScheme.dark(primary: Colors.blue),
                    // primaryColor: Colors.blue,
                    // primarySwatch: Colors.blue,
                    textTheme: Typography.englishLike2018.apply(
                        fontSizeFactor: 1.sp,
                        bodyColor: const Color(0xffffffff)
                    ),
                  ),
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
              });
        },
      ),
    );
  }
}
