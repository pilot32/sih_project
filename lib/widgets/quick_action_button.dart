import 'package:flutter/material.dart';
import '../widgets/ui/custom_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

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
      _ActionItem(
        icon: Icons.menu_book,
        label: AppStrings.todayLesson,
        onTap: onTodayLesson,
      ),
      _ActionItem(
        icon: Icons.quiz,
        label: AppStrings.practiceQuestions,
        onTap: onPracticeQuestions,
      ),
      _ActionItem(
        icon: Icons.star,
        label: AppStrings.viewRewards,
        onTap: onViewRewards,
      ),
      _ActionItem(
        icon: Icons.settings,
        label: AppStrings.settings,
        onTap: onSettings,
      ),
    ];

    int crossAxisCount = 2;
    if (screenWidth > 800) {
      crossAxisCount = 4;
    }

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
        return _QuickActionButton(action: actions[index]);
      },
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    this.onTap,
  });
}

class _QuickActionButton extends StatelessWidget {
  final _ActionItem action;

  const _QuickActionButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: action.onTap,
      variant: CustomButtonVariant.outline,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.sm,
          vertical: AppDimensions.xs,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              action.icon,
              size: 24,
              color: AppColors.foreground,
            ),
            const SizedBox(height: AppDimensions.xs),
            Flexible(
              child: Text(
                action.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.foreground,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}