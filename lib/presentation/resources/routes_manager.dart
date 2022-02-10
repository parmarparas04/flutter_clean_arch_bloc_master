import 'package:first_app/app/dl.dart';
import 'package:first_app/presentation/login/login.dart';

import 'package:flutter/material.dart';

class Routes {
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text("No Route found"),
            ),
            body: const Center(
              child: Text("No Route found"),
            )));
  }
}
