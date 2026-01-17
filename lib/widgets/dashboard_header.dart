import 'package:flutter/material.dart';
import '../widgets/ui/custom_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String studentName;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  const DashboardHeader({
    Key? key,
    required this.studentName,
    this.onSettings,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Row(
            children: [
              _buildUserInfo(),
              const Spacer(),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/owl_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${AppStrings.welcome}, $studentName!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AppStrings.todayLearn,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        CustomButton(
          onPressed: onSettings,
          variant: CustomButtonVariant.ghost,
          size: CustomButtonSize.icon,
          icon: Icons.settings,
        ),
        const SizedBox(width: AppDimensions.sm),
        CustomButton(
          onPressed: onLogout,
          variant: CustomButtonVariant.ghost,
          size: CustomButtonSize.icon,
          icon: Icons.logout,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}