import 'package:flutter/material.dart';
import '../widgets/ui/custom_card.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class HeroStatsCard extends StatelessWidget {
  final int totalProgress;
  final int dayStreak; // Corrected parameter name
  final int totalStars;
  final int badgesEarned;
  final String backgroundImage; // New parameter to accept the image path

  const HeroStatsCard({
    Key? key,
    required this.totalProgress,
    required this.dayStreak, // Corrected parameter name
    required this.totalStars,
    required this.badgesEarned,
    required this.backgroundImage, // New required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Stack(
        children: [
          // Background image with opacity
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                image: DecorationImage(
                  image: AssetImage(backgroundImage), // Using the provided image path
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
            ),
          ),
          // Content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.cardPadding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive layout
                if (constraints.maxWidth > 600) {
                  return _buildDesktopLayout();
                } else {
                  return _buildMobileLayout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(child: _buildStatItem(totalProgress, AppStrings.totalProgress, Icons.trending_up, AppColors.primary, suffix: '%')),
        Expanded(child: _buildStatItem(dayStreak, AppStrings.dayStreak, Icons.local_fire_department, AppColors.secondary)),
        Expanded(child: _buildStatItem(totalStars, AppStrings.totalStars, Icons.star, AppColors.success)),
        Expanded(child: _buildStatItem(badgesEarned, AppStrings.badgesEarned, Icons.military_tech, Colors.purple)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatItem(totalProgress, AppStrings.totalProgress, Icons.trending_up, AppColors.primary, suffix: '%')),
            const SizedBox(width: AppDimensions.lg),
            Expanded(child: _buildStatItem(dayStreak, AppStrings.dayStreak, Icons.local_fire_department, AppColors.secondary)),
          ],
        ),
        const SizedBox(height: AppDimensions.lg),
        Row(
          children: [
            Expanded(child: _buildStatItem(totalStars, AppStrings.totalStars, Icons.star, AppColors.success)),
            const SizedBox(width: AppDimensions.lg),
            Expanded(child: _buildStatItem(badgesEarned, AppStrings.badgesEarned, Icons.military_tech, Colors.purple)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(int value, String label, IconData icon, Color color, {String suffix = ''}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconXl,
              color: color,
            ),
            const SizedBox(width: AppDimensions.sm),
            Text(
              '$value$suffix',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.xs),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mutedForeground,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}