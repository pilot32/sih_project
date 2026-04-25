// lib/presentation/screens/student_dashboard_screen.dart
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
  late List<SubjectModel> coreSubjects = [];
  late List<SubjectModel> higherSubjects = [];
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
      ),
    ];

    // Calculate total progress
    totalProgress =
        (coreSubjects.fold<int>(0, (sum, subject) => sum + subject.progress) /
                coreSubjects.length)
            .round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: DashboardHeader(
        studentName: widget.studentName,
        onSettings: widget.onSettings,
        onLogout: widget.onLogout,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/student_dash_BG.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeroStatsCard(
                      totalProgress: totalProgress,
                      dayStreak: 15,
                      totalStars: 127,
                      badgesEarned: 5,
                      backgroundImage: 'assets/images/hero_learning.jpg',
                    ),
                    const SizedBox(height: 32),
                    SubjectsSection(
                      title: AppStrings.coreSubjects,
                      badgeText: AppStrings.basicCurriculum,
                      badgeVariant: BadgeVariant.secondary,
                      subjects: coreSubjects,
                      onSubjectTap: _handleCoreSubjectTap,
                    ),
                    const SizedBox(height: 32),
                    SubjectsSection(
                      title: AppStrings.higherEducationPrep,
                      badgeText: AppStrings.availableNow,
                      badgeVariant: BadgeVariant.outline,
                      subjects: higherSubjects,
                      onSubjectTap: _handleHigherSubjectTap,
                    ),
                    const SizedBox(height: 32),
                    QuickActionsSection(
                      onTodayLesson: _handleTodayLesson,
                      onPracticeQuestions: _handlePracticeQuestions,
                      onViewRewards: _handleViewRewards,
                      onSettings: _handleSettings,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTodayLesson() {
    final topSubject = coreSubjects.reduce(
      (a, b) => a.progress >= b.progress ? a : b,
    );
    _showActionDialog(
      title: 'Continue Learning',
      icon: Icons.play_circle_outline,
      message:
          'Resume ${topSubject.subject}: lesson ${topSubject.completedLessons + 1} of ${topSubject.totalLessons}.',
    );
  }

  void _handlePracticeQuestions() {
    _showActionDialog(
      title: 'Practice Mode',
      icon: Icons.quiz,
      message: 'Daily practice is ready with 15 mixed questions.',
    );
  }

  void _handleViewRewards() {
    _showActionDialog(
      title: 'Your Rewards',
      icon: Icons.emoji_events_outlined,
      message: 'You have earned 127 stars and 5 badges so far.',
    );
  }

  void _handleSettings() {
    if (widget.onSettings != null) {
      widget.onSettings!.call();
      return;
    }

    _showActionDialog(
      title: 'Settings',
      icon: Icons.settings,
      message: 'Settings page is not connected yet for this flow.',
    );
  }

  void _handleCoreSubjectTap(SubjectModel subject) {
    _showActionDialog(
      title: subject.subject,
      icon: subject.icon,
      message:
          'Progress: ${subject.progress}% (${subject.completedLessons}/${subject.totalLessons} lessons).',
    );
  }

  void _handleHigherSubjectTap(SubjectModel subject) {
    _showActionDialog(
      title: '${subject.subject} Track',
      icon: subject.icon,
      message: 'Syllabus preview is available and enrollment opens soon.',
    );
  }

  Future<void> _showActionDialog({
    required String title,
    required IconData icon,
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Expanded(child: Text(title)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
