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
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: AppDimensions.sm),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 28, // Larger avatar
                  backgroundImage: AssetImage('assets/images/owl_logo.png'),
                  backgroundColor: AppColors.background,
                ),
              ),
              const SizedBox(width: AppDimensions.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi, $studentName! 👋',
                      style: const TextStyle(
                        fontSize: 24, // Larger greeting
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                      ),
                    ),
                    const Text(
                      'Ready to learn something new?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.mutedForeground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    // Deprecated - logic moved to build method for better layout control
    return const SizedBox.shrink();
  }

  Widget _buildActions() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings_outlined, color: AppColors.primary),
            tooltip: 'Settings',
          ),
        ),
        const SizedBox(width: AppDimensions.sm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout, color: AppColors.destructive),
            tooltip: 'Logout',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Taller header
}