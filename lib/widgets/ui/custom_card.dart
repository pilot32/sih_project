import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool showShadow;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.elevation,
    this.color,
    this.borderRadius,
    this.onTap,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: AppDimensions.shadowBlur,
                  offset: const Offset(0, AppDimensions.shadowOffset),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
        child: child,
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}

class CustomCardHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const CustomCardHeader({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(
        left: AppDimensions.cardPadding,
        right: AppDimensions.cardPadding,
        top: AppDimensions.cardPadding,
        bottom: AppDimensions.sm,
      ),
      child: child,
    );
  }
}

class CustomCardContent extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const CustomCardContent({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppDimensions.cardPadding,
      ),
      child: child,
    );
  }
}

class CustomCardFooter extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const CustomCardFooter({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(
        left: AppDimensions.cardPadding,
        right: AppDimensions.cardPadding,
        bottom: AppDimensions.cardPadding,
        top: AppDimensions.sm,
      ),
      child: child,
    );
  }
}