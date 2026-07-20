import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';

// Shows a non-dismissible loading dialog. Caller must pop it manually.
Future<void> funcationLoaderBox(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Text('Please wait…', style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ),
    ),
  );
}

// Auto-dismissing success dialog that pops itself and the caller screen.
Future<void> dataSavedDialogBox(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      Future.delayed(const Duration(seconds: 2), () {
        if (ctx.mounted) Navigator.of(ctx).pop(); // dialog
        if (context.mounted) Navigator.of(context).pop(); // caller screen
      });
      return Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 44),
              const SizedBox(height: 12),
              Text('Patient Data Saved!',
                  style: AppTextStyles.heading3,
                  textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text('Returning to previous screen…',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    },
  );
}
