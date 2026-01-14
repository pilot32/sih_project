import 'package:flutter/material.dart';

class SubjectModel {
  final String subject;
  final int progress;
  final int totalLessons;
  final int completedLessons;
  final int streak;
  final LinearGradient? colors; // Now nullable
  final String? backgroundImage; // New nullable property for image path
  final IconData icon;
  final bool isLocked;

  const SubjectModel({
    required this.subject,
    required this.progress,
    required this.totalLessons,
    required this.completedLessons,
    required this.streak,
    this.colors, // Optional
    this.backgroundImage, // Optional
    required this.icon,
    this.isLocked = false,
  });

  SubjectModel copyWith({
    String? subject,
    int? progress,
    int? totalLessons,
    int? completedLessons,
    int? streak,
    LinearGradient? colors,
    String? backgroundImage, // Update copyWith with new property
    IconData? icon,
    bool? isLocked,
  }) {
    return SubjectModel(
      subject: subject ?? this.subject,
      progress: progress ?? this.progress,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      streak: streak ?? this.streak,
      colors: colors ?? this.colors,
      backgroundImage: backgroundImage ?? this.backgroundImage, // Handle new property
      icon: icon ?? this.icon,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}