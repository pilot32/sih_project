import 'package:flutter/material.dart';
import 'package:digital_learning_application/core/constants/app_colors.dart';

class TeacherDashboardScreen extends StatelessWidget {
  final String teacherId;
  final VoidCallback? onLogout;

  const TeacherDashboardScreen({
    super.key,
    this.teacherId = 'Teacher',
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Teacher Dashboard — $teacherId'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people, size: 80, color: AppColors.primary),
              SizedBox(height: 24),
              Text(
                'Teacher Dashboard',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.foreground),
              ),
              SizedBox(height: 12),
              Text(
                'This section is under development.\nStudent management and content upload features coming soon.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.mutedForeground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
