import 'package:digital_learning_application/widgets/learning_card.dart';
import 'package:digital_learning_application/widgets/ui/custom_badge.dart';
import 'package:flutter/material.dart';
import '../../data/models/subject_model.dart';
//import '../widgets/learning_card.dart';
//import '../widgets/ui/custom_badge.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class SubjectsSection extends StatelessWidget {
  final String title;
  final String badge;
  final BadgeVariant badgeVariant;
  final List<SubjectModel> subjects;
  final Function(SubjectModel)? onSubjectTap;

  const SubjectsSection({
    Key? key,
    required this.title,
    required this.badge,
    required this.badgeVariant,
    required this.subjects,
    this.onSubjectTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        const SizedBox(height: AppDimensions.lg),
        _buildSubjectsGrid(context),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.foreground,
          ),
        ),
        CustomBadge(
          text: badge,
          variant: badgeVariant,
        ),
      ],
    );
  }

  Widget _buildSubjectsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        
        if (constraints.maxWidth > 1200) {
          crossAxisCount = subjects.length > 3 ? 4 : 3;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = subjects.length > 2 ? 3 : 2;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppDimensions.lg,
            mainAxisSpacing: AppDimensions.lg,
            childAspectRatio: _getAspectRatio(constraints.maxWidth),
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return LearningCard(
              subject: subject,
              onTap: () => onSubjectTap?.call(subject),
            );
          },
        );
      },
    );
  }

  double _getAspectRatio(double screenWidth) {
    if (screenWidth > 1200) {
      return 1.2; // More landscape for desktop
    } else if (screenWidth > 600) {
      return 1.1; // Slightly landscape for tablet
    } else {
      return 1.0; // Square for mobile
    }
  }
}