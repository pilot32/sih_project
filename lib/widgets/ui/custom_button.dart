import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

enum CustomButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

enum CustomButtonSize {
  small,
  medium,
  large,
  icon,
}

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final CustomButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool iconFirst;

  const CustomButton({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.size = CustomButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconFirst = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: _getElevation(),
      borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
      shadowColor: _getShadowColor().withOpacity(0.25),
      child: Container(
        height: _getHeight(),
        constraints: size == CustomButtonSize.icon 
            ? BoxConstraints.tight(Size(_getHeight(), _getHeight()))
            : null,
        decoration: BoxDecoration(
          gradient: _getGradient(),
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: variant == CustomButtonVariant.outline
              ? Border.all(color: AppColors.border)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            onTap: isLoading ? null : onPressed,
            child: Padding(
              padding: _getPadding(),
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_getForegroundColor()),
          ),
        ),
      );
    }

    if (size == CustomButtonSize.icon && icon != null) {
      return Icon(
        icon,
        size: AppDimensions.iconMd,
        color: _getForegroundColor(),
      );
    }

    final content = child ?? Text(
      text ?? '',
      style: TextStyle(
        color: _getForegroundColor(),
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w500,
      ),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconFirst
            ? [
                Icon(
                  icon,
                  size: AppDimensions.iconSm,
                  color: _getForegroundColor(),
                ),
                const SizedBox(width: AppDimensions.sm),
                content,
              ]
            : [
                content,
                const SizedBox(width: AppDimensions.sm),
                Icon(
                  icon,
                  size: AppDimensions.iconSm,
                  color: _getForegroundColor(),
                ),
              ],
      );
    }

    return Center(child: content);
  }

  double _getHeight() {
    switch (size) {
      case CustomButtonSize.small:
        return AppDimensions.buttonHeightSm;
      case CustomButtonSize.medium:
        return AppDimensions.buttonHeight;
      case CustomButtonSize.large:
        return AppDimensions.buttonHeightLg;
      case CustomButtonSize.icon:
        return AppDimensions.buttonHeight;
    }
  }

  EdgeInsets _getPadding() {
    if (size == CustomButtonSize.icon) {
      return EdgeInsets.zero;
    }
    
    switch (size) {
      case CustomButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: AppDimensions.md);
      case CustomButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: AppDimensions.lg);
      case CustomButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: AppDimensions.xl);
      case CustomButtonSize.icon:
        return EdgeInsets.zero;
    }
  }

  double _getFontSize() {
    switch (size) {
      case CustomButtonSize.small:
        return 12;
      case CustomButtonSize.medium:
        return 14;
      case CustomButtonSize.large:
        return 16;
      case CustomButtonSize.icon:
        return 14;
    }
  }

  double _getElevation() {
    switch (variant) {
      case CustomButtonVariant.primary:
      case CustomButtonVariant.secondary:
        return 4;
      case CustomButtonVariant.destructive:
        return 4;
      case CustomButtonVariant.outline:
      case CustomButtonVariant.ghost:
        return 0;
    }
  }

  Color _getShadowColor() {
    switch (variant) {
      case CustomButtonVariant.primary:
        return AppColors.primary;
      case CustomButtonVariant.secondary:
        return AppColors.secondary;
      case CustomButtonVariant.destructive:
        return AppColors.destructive;
      case CustomButtonVariant.outline:
      case CustomButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Gradient? _getGradient() {
    switch (variant) {
      case CustomButtonVariant.primary:
        return const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      case CustomButtonVariant.secondary:
        return const LinearGradient(
          colors: AppColors.secondaryGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      default:
        return null;
    }
  }

  Color? _getBackgroundColor() {
    switch (variant) {
      case CustomButtonVariant.primary:
      case CustomButtonVariant.secondary:
        return null; // Use gradient instead
      case CustomButtonVariant.outline:
      case CustomButtonVariant.ghost:
        return Colors.transparent;
      case CustomButtonVariant.destructive:
        return AppColors.destructive;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case CustomButtonVariant.primary:
        return AppColors.primaryForeground;
      case CustomButtonVariant.secondary:
        return AppColors.secondaryForeground;
      case CustomButtonVariant.destructive:
        return AppColors.destructiveForeground;
      case CustomButtonVariant.outline:
        return AppColors.foreground;
      case CustomButtonVariant.ghost:
        return AppColors.foreground;
    }
  }
}