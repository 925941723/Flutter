import 'package:flutter/material.dart';
import 'package:flutter_application/page/test/restore/restore_page.dart';
import 'package:flutter_application/routes/navigator_util.dart';
import 'package:flutter_application/theme/theme_settings.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the RestorePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('测试页面', style: TextStyle(color: Color(0xFF333333))),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
