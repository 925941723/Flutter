import 'package:flutter/material.dart';
import 'package:flutter_application/page/test/dio/dio_page.dart';
import 'package:flutter_application/page/test/future/future_page.dart';
import 'package:flutter_application/page/test/model2json/model_to_json_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application/page/test/restore/restore_page.dart';
import 'package:flutter_application/routes/navigator_util.dart';
import 'package:flutter_application/page/test/theme/theme_settings.dart';
import 'package:flutter_application/theme/themes_controller.dart';

// 测试主页
class TestPage extends StatefulWidget {
  const TestPage({super.key});
  static const routeName = '/test_page';
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>  {

  @override
  Widget build(BuildContext context) {
    // 根据主题的provider动态生成对应颜色
    final themeProvider = context.watch<ThemesController>();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle, style: TextStyle(color: Color(themeProvider.themeSource.textBlack))),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const Text(
              //   'You have pushed the button this many times:',
              // ),
              TextButton(
                onPressed: () {
                  NavigatorUtil.pushNamed(context, RestorePage.routeName);
                },
                child: const Text('被杀死后还能恢复数据'),
              ),
              TextButton(
                onPressed: () {
                  NavigatorUtil.pushNamed(context, ThemeSettings.routeName);
                },
                child: const Text('主题设置'),
              ),
              TextButton(
                onPressed: () {
                  NavigatorUtil.pushNamed(context, ModelToJsonPage.routeName);
                },
                child: const Text('模块与json转换'),
              ),
              TextButton(
                onPressed: () {
                  NavigatorUtil.pushNamed(context, FuturePage.routeName);
                },
                child: const Text('future测试'),
              ),
              TextButton(
                onPressed: () {
                  NavigatorUtil.pushNamed(context, DioPage.routeName);
                },
                child: const Text('dio测试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
