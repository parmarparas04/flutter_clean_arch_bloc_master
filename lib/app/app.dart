import 'package:first_app/presentation/resources/routes_manager.dart';
import 'package:first_app/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); //private name  contrutor

  static final MyApp instance = MyApp._internal(); // Single instance

  factory MyApp() => instance; //factory
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.loginRoute,
      theme: getApplicationTheme(),
    );
  }
}
