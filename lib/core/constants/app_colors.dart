import 'package:flutter/material.dart';

class AppColors {
  // Educational Color Palette - Light Theme
  static const Color background = Color(0xFFFBFCFE);
  static const Color foreground = Color(0xFF1E293B);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF1E293B);
  
  // Learning-focused primary - trustworthy blue
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color primaryGlow = Color(0xFF3B82F6);
  
  // Energy secondary - motivational orange
  static const Color secondary = Color(0xFFEA580C);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color secondaryGlow = Color(0xFFF97316);
  
  // Success achievement - encouraging green
  static const Color success = Color(0xFF059669);
  static const Color successForeground = Color(0xFFFFFFFF);
  static const Color successGlow = Color(0xFF10B981);
  
  // Soft backgrounds
  static const Color muted = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF64748B);
  
  static const Color accent = Color(0xFFE0E7FF);
  static const Color accentForeground = Color(0xFF3730A3);
  
  static const Color destructive = Color(0xFFEF4444);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  
  static const Color border = Color(0xFFE2E8F0);
  static const Color input = Color(0xFFF1F5F9);
  
  // Subject Colors
  static const Color hindiColor = Color(0xFFEA580C);
  static const Color englishColor = Color(0xFF2563EB);
  static const Color mathColor = Color(0xFF059669);
  static const Color scienceColor = Color(0xFF9333EA);
  static const Color socialColor = Color(0xFFD97706);
  static const Color commerceColor = Color(0xFF0891B2);
  static const Color computerColor = Color(0xFF475569);
  
  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color foregroundDark = Color(0xFFF1F5F9);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color mutedDark = Color(0xFF334155);
  static const Color mutedForegroundDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF334155);
  
  // Gradients
  static const List<Color> primaryGradient = [primary, primaryGlow];
  static const List<Color> secondaryGradient = [secondary, secondaryGlow];
  static const List<Color> successGradient = [success, successGlow];
  static const List<Color> learningGradient = [Color(0xFF2563EB), Color(0xFF9333EA)];
  static const List<Color> heroGradient = [Color(0xFF2563EB), Color(0xFFEA580C)];
}