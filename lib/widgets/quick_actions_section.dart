import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/app_strings.dart';
import 'quick_action_button.dart';

class QuickActionsSection extends StatelessWidget {
  final VoidCallback? onTodayLesson;
  final VoidCallback? onPracticeQuestions;
  final VoidCallback? onViewRewards;
  final VoidCallback? onSettings;

  const QuickActionsSection({
    Key? key,
    this.onTodayLesson,
    this.onPracticeQuestions,
    this.onViewRewards,
    this.onSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.quickActions,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: AppDimensions.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            return _buildActionsGrid(constraints.maxWidth);
          },
        ),
      ],
    );
  }

  Widget _buildActionsGrid(double screenWidth) {
    final actions = [
      (
        icon: Icons.menu_book,
        label: AppStrings.todayLesson,
        onTap: onTodayLesson,
      ),
      (
        icon: Icons.quiz,
        label: AppStrings.practiceQuestions,
        onTap: onPracticeQuestions,
      ),
      (icon: Icons.star, label: AppStrings.viewRewards, onTap: onViewRewards),
      (icon: Icons.settings, label: AppStrings.settings, onTap: onSettings),
    ];

    final crossAxisCount = screenWidth > 800 ? 4 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppDimensions.md,
        mainAxisSpacing: AppDimensions.md,
        childAspectRatio: 2.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return QuickActionButton(
          icon: action.icon,
          label: action.label,
          onTap: action.onTap,
        );
      },
    );
  }
}
