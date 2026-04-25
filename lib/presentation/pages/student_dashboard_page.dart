import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../screens/student_dashboard_screen.dart';

class StudentDashboardPage extends StatelessWidget {
  final String studentName;

  const StudentDashboardPage({super.key, this.studentName = 'Student'});

  @override
  Widget build(BuildContext context) {
    return StudentDashboardScreen(
      studentName: studentName,
      onLogout: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
      onSettings: () => Navigator.pushNamed(context, AppRoutes.settings),
    );
  }
}
