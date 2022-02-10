import 'package:first_app/app/app.dart';
import 'package:first_app/app/dl.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
