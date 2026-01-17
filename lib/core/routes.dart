import 'package:flutter/material.dart';
import '../screens/auth/login_page2.dart';
import '../screens/student_dashboard_screen.dart';
import '../screens/settings_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      dashboard: (context) => StudentDashboardScreen(
        onLogout: () => Navigator.pushReplacementNamed(context, login),
        onSettings: () => Navigator.pushNamed(context, settings),
      ),
      settings: (context) => const SettingsScreen(),
    };
  }
}
