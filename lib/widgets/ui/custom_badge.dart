import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

enum BadgeVariant {
  primary,
  secondary,
  success,
  outline,
  destructive,
}

class CustomBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final IconData? icon;
  final bool iconFirst;
  final EdgeInsets? padding;

  const CustomBadge({
    Key? key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.icon,
    this.iconFirst = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppDimensions.sm + 2,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        gradient: _getGradient(),
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
        border: variant == BadgeVariant.outline
            ? Border.all(color: AppColors.border)
            : null,
        boxShadow: _getShadow(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && iconFirst) ...[
            Icon(
              icon,
              size: AppDimensions.iconXs,
              color: _getForegroundColor(),
            ),
            const SizedBox(width: AppDimensions.xs),
          ],
          Text(
            text,
            style: TextStyle(
              color: _getForegroundColor(),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (icon != null && !iconFirst) ...[
            const SizedBox(width: AppDimensions.xs),
            Icon(
              icon,
              size: AppDimensions.iconXs,
              color: _getForegroundColor(),
            ),
          ],
        ],
      ),
    );
  }

  Gradient? _getGradient() {
    switch (variant) {
      case BadgeVariant.success:
        return const LinearGradient(
          colors: AppColors.successGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      default:
        return null;
    }
  }

  Color? _getBackgroundColor() {
    switch (variant) {
      case BadgeVariant.primary:
        return AppColors.primary;
      case BadgeVariant.secondary:
        return AppColors.secondary;
      case BadgeVariant.success:
        return null; // Use gradient
      case BadgeVariant.destructive:
        return AppColors.destructive;
      case BadgeVariant.outline:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case BadgeVariant.primary:
        return AppColors.primaryForeground;
      case BadgeVariant.secondary:
        return AppColors.secondaryForeground;
      case BadgeVariant.success:
        return AppColors.successForeground;
      case BadgeVariant.destructive:
        return AppColors.destructiveForeground;
      case BadgeVariant.outline:
        return AppColors.foreground;
    }
  }

  List<BoxShadow>? _getShadow() {
    switch (variant) {
      case BadgeVariant.success:
        return [
          BoxShadow(
            color: AppColors.success.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
      default:
        return null;
    }
  }
}