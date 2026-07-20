import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';

enum AppButtonVariant { primary, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  final AppButtonVariant variant;
  final IconData? icon;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.width,
    this.height,
  });

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.icon,
    this.width,
    this.height,
  })  : variant = AppButtonVariant.outlined;

  const AppButton.text({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.icon,
    this.width,
    this.height,
  })  : variant = AppButtonVariant.text;

  Widget _buildChild() {
    if (loading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: variant == AppButtonVariant.primary
              ? Colors.white
              : AppColors.primary,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 6),
        ],
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();
    final effectiveWidth = width ?? double.infinity;

    switch (variant) {
      case AppButtonVariant.outlined:
        return SizedBox(
          width: effectiveWidth,
          height: height,
          child: OutlinedButton(
            onPressed: loading ? null : onTap,
            child: child,
          ),
        );
      case AppButtonVariant.text:
        return SizedBox(
          width: width,
          height: height,
          child: TextButton(
            onPressed: loading ? null : onTap,
            child: child,
          ),
        );
      case AppButtonVariant.primary:
        return SizedBox(
          width: effectiveWidth,
          height: height,
          child: ElevatedButton(
            onPressed: loading ? null : onTap,
            child: child,
          ),
        );
    }
  }
}
