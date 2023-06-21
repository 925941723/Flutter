import 'package:flutter/material.dart';
import 'package:flutter_application/page/restore/restore_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      // restorationScopeId: 'root', // 使用home来加载单页面时才能生效
      // 使用onGenerateRoute后，restorationScopeId不会生效；需要使用RootRestorationScope(restorationId: 'root', child: page)这种方式
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            Widget page = const RestorePage(title: 'Flutter Demo Home Page');
            // switch (routeSettings.name) {
            //   case SettingsView.routeName:
            //     return SettingsView(controller: settingsController);
            //   case SampleItemDetailsView.routeName:
            //     return const SampleItemDetailsView();
            //   case SampleItemListView.routeName:
            //   default:
            //     return const SampleItemListView();
            // }
            return RootRestorationScope(restorationId: 'root', child: page);
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
    );
  }
}
