import 'package:digital_learning_application/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:digital_learning_application/core/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nabha Digital Education',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF0F4C75),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C75),
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}