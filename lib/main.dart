import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'screens/loading_Screen.dart';
import 'models/settings.dart';
import 'package:flutter/services.dart';
import 'models/localVibration.dart';

LocalVibration localVibration = LocalVibration();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localVibration.checkSupport();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Settings();
        }),
        ChangeNotifierProvider(create: (context) {
          return TaskData();
        })
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (context, settings, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: settings.isDarkTheme
            ? ThemeData.dark().copyWith(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: settings.fontFamily,
                      bodyColor: Colors.white,
                      displayColor: Colors.white,
                    ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  foregroundColor: Colors.grey[900],
                ),
              )
            : ThemeData.light().copyWith(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: settings.fontFamily,
                      bodyColor: Colors.grey[850],
                      displayColor: Colors.grey[850],
                    ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  foregroundColor: Colors.lightBlueAccent,
                ),
              ),
        home: LoadingScreen(),
      );
    });
  }
}
