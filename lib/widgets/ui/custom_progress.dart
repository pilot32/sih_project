import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class CustomProgress extends StatefulWidget {
  final double value;
  final double? height;
  final Color? backgroundColor;
  final Color? progressColor;
  final Gradient? progressGradient;
  final Duration animationDuration;

  const CustomProgress({
    Key? key,
    required this.value,
    this.height,
    this.backgroundColor,
    this.progressColor,
    this.progressGradient,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<CustomProgress> createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.value / 100,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void didUpdateWidget(CustomProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value / 100,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height ?? AppDimensions.progressHeight,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.muted,
            borderRadius: BorderRadius.circular(AppDimensions.progressRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
                //offset: true,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? AppColors.muted,
                  borderRadius: BorderRadius.circular(AppDimensions.progressRadius),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.progressGradient ?? 
                        const LinearGradient(
                          colors: AppColors.successGradient,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                    color: widget.progressColor,
                    borderRadius: BorderRadius.circular(AppDimensions.progressRadius),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LearningProgress extends StatelessWidget {
  final double value;
  
  const LearningProgress({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomProgress(
      value: value,
      progressGradient: const LinearGradient(
        colors: AppColors.successGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }
}