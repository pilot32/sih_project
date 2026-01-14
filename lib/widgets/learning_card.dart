import 'package:flutter/material.dart';
import '../../data/models/subject_model.dart';
import '../widgets/ui/custom_card.dart';
import '../widgets/ui/custom_badge.dart';
import '../widgets/ui/custom_progress.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class LearningCard extends StatelessWidget {
  final SubjectModel subject;
  final VoidCallback? onTap;

  const LearningCard({
    Key? key,
    required this.subject,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: CustomCard(
        onTap: subject.isLocked ? null : onTap,
        child: Opacity(
          opacity: subject.isLocked ? 0.6 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppDimensions.lg),
              _buildProgressSection(),
              if (!subject.isLocked) ...[
                const SizedBox(height: AppDimensions.md),
                _buildFooter(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Handle null colors with a default gradient
    final gradientColors = subject.colors?.colors ?? 
        [AppColors.primary, AppColors.accent]; // Use your app's colors
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors.first.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  subject.icon,
                  size: AppDimensions.iconLg,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppDimensions.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.subject,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (subject.streak > 0)
          CustomBadge(
            text: '${subject.streak} ${AppStrings.days}',
            variant: BadgeVariant.success,
            icon: Icons.star,
          ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  size: AppDimensions.iconSm,
                  color: AppColors.mutedForeground,
                ),
                const SizedBox(width: AppDimensions.xs),
                Text(
                  '${subject.completedLessons}/${subject.totalLessons} ${AppStrings.lessons}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
            Text(
              '${subject.progress}%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.md),
        LearningProgress(value: subject.progress.toDouble()),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.schedule,
              size: AppDimensions.iconXs,
              color: AppColors.mutedForeground,
            ),
            const SizedBox(width: AppDimensions.xs),
            Text(
              AppStrings.nextLesson,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AppStrings.continueLesson,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}