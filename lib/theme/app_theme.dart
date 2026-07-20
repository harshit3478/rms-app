import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Colours ────────────────────────────────────────────────────────────────

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF0D79DD);
  static const Color primaryDark = Color(0xFF0B68BF);
  static const Color primaryLight = Color(0xFFE8F1FB);

  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF4F4FA);
  static const Color surfaceDark = Color(0xFFEAEAF2);

  // Text
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF545D68);
  static const Color textHint = Color(0xFFAAAAAA);

  // Semantic
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFDEDED);
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFEDF7ED);
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFFF3E0);

  // Neutral
  static const Color divider = Color(0xFFE5E5EA);
  static const Color border = Color(0xFFDDDDE3);
  static const Color iconDefault = Color(0xFF545D68);
}

// ─── Typography ─────────────────────────────────────────────────────────────

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppColors.textSecondary,
      );

  static TextStyle get label => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.white,
        letterSpacing: 0.2,
      );

  static TextStyle get buttonTextSecondary => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: AppColors.primary,
        letterSpacing: 0.2,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        color: AppColors.textHint,
      );

  static TextStyle get navLabel => GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 11,
      );
}

// ─── Spacing & Radius ────────────────────────────────────────────────────────

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  AppRadius._();
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 14;
  static const double xl = 20;
  static const double full = 100;
}

// ─── ThemeData ───────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.iconDefault),
        titleTextStyle: AppTextStyles.heading3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primaryLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.buttonTextSecondary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
        prefixIconColor: AppColors.iconDefault,
        suffixIconColor: AppColors.iconDefault,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.body.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.all(12),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        titleTextStyle: AppTextStyles.heading2,
        contentTextStyle: AppTextStyles.body,
        elevation: 4,
      ),
      cardTheme: CardThemeData(
        color: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
    );
  }
}
