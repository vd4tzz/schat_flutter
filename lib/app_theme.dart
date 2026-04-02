import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF000000),
          onPrimary: Colors.white,
          secondary: Color(0xFF191919),
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF191919),
          onSurfaceVariant: Color(0xFF6B6B6B),
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Color(0xFFF5F5F5),
          surfaceContainer: Color(0xFFEEEEEE),
          surfaceContainerHigh: Color(0xFFE0E0E0),
          surfaceContainerHighest: Color(0xFFD6D6D6),
          outline: Color(0xFFBDBDBD),
          outlineVariant: Color(0xFFE0E0E0),
          error: Colors.redAccent,
          onError: Colors.white,
          errorContainer: Color(0xFFFFEBEE),
          onErrorContainer: Colors.redAccent,
          scrim: Colors.black,
        ),
        scaffoldBg: const Color(0xFFF7F7F7),
        appBarBg: const Color(0xFFF7F7F7),
        appBarFg: const Color(0xFF191919),
        appColors: AppColors.light,
      );

  static ThemeData get darkTheme => _buildTheme(
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          onPrimary: Color(0xFF1A1A1A),
          secondary: Color(0xFFE0E0E0),
          onSecondary: Color(0xFF1A1A1A),
          surface: Color(0xFF1A1A1A),
          onSurface: Color(0xFFE8E8E8),
          onSurfaceVariant: Color(0xFF9E9E9E),
          surfaceContainerLowest: Color(0xFF0F0F0F),
          surfaceContainerLow: Color(0xFF1E1E1E),
          surfaceContainer: Color(0xFF252525),
          surfaceContainerHigh: Color(0xFF2C2C2C),
          surfaceContainerHighest: Color(0xFF363636),
          outline: Color(0xFF616161),
          outlineVariant: Color(0xFF424242),
          error: Color(0xFFFF6B6B),
          onError: Color(0xFF1A1A1A),
          errorContainer: Color(0xFF3D1F1F),
          onErrorContainer: Color(0xFFFF6B6B),
          scrim: Colors.black,
        ),
        scaffoldBg: const Color(0xFF121212),
        appBarBg: const Color(0xFF121212),
        appBarFg: const Color(0xFFE8E8E8),
        appColors: AppColors.dark,
      );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBg,
    required Color appBarBg,
    required Color appBarFg,
    required AppColors appColors,
  }) {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData(colorScheme: colorScheme).textTheme,
      ),
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBg,
        foregroundColor: appBarFg,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scaffoldBg,
        indicatorColor: colorScheme.primary.withAlpha(30),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            );
          }
          return TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          );
        }),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        dragHandleColor: colorScheme.outlineVariant,
        showDragHandle: true,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 0.5,
        space: 0.5,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.secondary,
        contentTextStyle: TextStyle(color: colorScheme.onSecondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      extensions: [appColors],
    );
  }
}
