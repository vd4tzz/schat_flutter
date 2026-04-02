import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color warning;
  final Color onWarning;
  final Color warningContainer;

  const AppColors({
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
  });

  static const light = AppColors(
    warning: Color(0xFFF57C00),
    onWarning: Colors.white,
    warningContainer: Color(0xFFFFF3E0),
  );

  static const dark = AppColors(
    warning: Color(0xFFFFB74D),
    onWarning: Color(0xFF1A1A1A),
    warningContainer: Color(0xFF3E2C1A),
  );

  @override
  AppColors copyWith({
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
  }) {
    return AppColors(
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
    );
  }
}
