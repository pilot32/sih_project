// lib/presentation/screens/student_dashboard_screen.dart
import 'package:digital_learning_application/widgets/quick_action_button.dart';
import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_stats_card.dart';
import '../widgets/subjects_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/ui/custom_badge.dart';
import '../../data/models/subject_model.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';

class StudentDashboardScreen extends StatefulWidget {
  final String studentName;
  final VoidCallback? onLogout;
  final VoidCallback? onSettings;

  const StudentDashboardScreen({
    super.key,
    this.studentName = 'Student',
    this.onLogout,
    this.onSettings,
  });

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  late  List<SubjectModel> coreSubjects = [];
  late  List<SubjectModel> higherSubjects = [];
  late final int totalProgress;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    coreSubjects = [
      SubjectModel(
        subject: 'Hindi',
        progress: 75,
        totalLessons: 20,
        completedLessons: 15,
        streak: 7,
        colors: const LinearGradient(
          colors: [AppColors.hindiColor, Color(0xFFFFB74D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.book_outlined,
      ),
      SubjectModel(
        subject: 'English',
        progress: 60,
        totalLessons: 18,
        completedLessons: 11,
        streak: 3,
        colors: const LinearGradient(
          colors: [AppColors.englishColor, Color(0xFF90E0EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.language,
      ),
      SubjectModel(
        subject: 'Math',
        progress: 45,
        totalLessons: 25,
        completedLessons: 11,
        streak: 5,
        colors: const LinearGradient(
          colors: [AppColors.mathColor, Color(0xFFFF70A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.calculate,
      ),
    ];

    higherSubjects = [
      SubjectModel(
        subject: 'Science',
        progress: 0,
        totalLessons: 30,
        completedLessons: 0,
        streak: 0,
        colors: const LinearGradient(
          colors: [AppColors.scienceColor, Color(0xFFB5179E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.science,
        isLocked: true,
      ),
      SubjectModel(
        subject: 'Social Science',
        progress: 0,
        totalLessons: 22,
        completedLessons: 0,
        streak: 0,
        colors: const LinearGradient(
          colors: [AppColors.socialColor, Color(0xFF4895EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.public,
        isLocked: true,
      ),
      SubjectModel(
        subject: 'Commerce',
        progress: 0,
        totalLessons: 18,
        completedLessons: 0,
        streak: 0,
        colors: const LinearGradient(
          colors: [AppColors.commerceColor, Color(0xFF4CC9F0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.attach_money,
        isLocked: true,
      ),
      SubjectModel(
        subject: 'Computer',
        progress: 0,
        totalLessons: 15,
        completedLessons: 0,
        streak: 0,
        colors: const LinearGradient(
          colors: [AppColors.computerColor, Color(0xFF7209B7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.computer,
        isLocked: true,
      ),
    ];

    // Calculate total progress
    totalProgress = (coreSubjects.fold<int>(
      0,
      (sum, subject) => sum + subject.progress,
    ) / coreSubjects.length).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardHeader(
        studentName: widget.studentName,
        onSettings: widget.onSettings,
        onLogout: widget.onLogout,
      ),
      body: SafeArea( // Use SafeArea directly
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Stats Card
                // Your StudentDashboardScreen file
HeroStatsCard(
  totalProgress: totalProgress,
  dayStreak: 15, // Corrected from streakDays
  totalStars: 127,
  badgesEarned: 5,
  backgroundImage: 'assets/images/hero_learning.jpg', // This parameter is now accepted
),
                
                const SizedBox(height: 32),
                
                // Core Subjects Section
                SubjectsSection(
  title: AppStrings.coreSubjects,
  badgeText: AppStrings.basicCurriculum, // Corrected from `badge`
  badgeVariant: BadgeVariant.secondary,
  subjects: coreSubjects,
  // Removed crossAxisCount, as the widget handles it responsively
),

const SizedBox(height: 32),

// Higher Education Section
SubjectsSection(
  title: AppStrings.higherEducationPrep,
  badgeText: AppStrings.comingSoon, // Corrected from `badge`
  badgeVariant: BadgeVariant.outline,
  subjects: higherSubjects,
  // Removed crossAxisCount, as the widget handles it responsively
),
                
                const SizedBox(height: 32),
                
                // Quick Actions Section
                QuickActionsSection(
                  onTodayLesson: _handleTodayLesson,
                  onPracticeQuestions: _handlePracticeQuestions,
                  onViewRewards: _handleViewRewards,
                  onSettings: widget.onSettings,
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  void _handleTodayLesson() {
    // Navigate to today's lesson
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Today\'s Lesson...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handlePracticeQuestions() {
    // Navigate to practice questions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Practice Questions...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleViewRewards() {
    // Navigate to rewards page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Rewards Page...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}