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
          colors: [Color(0xFFFF6B35), Color(0xFFEF4444)],
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
          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
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
          colors: [Color(0xFF10B981), Color(0xFF059669)],
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
          colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
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
          colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
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
          colors: [Color(0xFF14B8A6), Color(0xFF0891B2)],
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
          colors: [Color(0xFF64748B), Color(0xFF475569)],
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: DashboardHeader(
        studentName: widget.studentName,
        onSettings: widget.onSettings,
        onLogout: widget.onLogout,
       // mascotImage: 'assets/images/mascot-owl.png',
      ),
      body: SingleChildScrollView(
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
  backgroundImage: 'assets/images/hero-learning.jpg', // This parameter is now accepted
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