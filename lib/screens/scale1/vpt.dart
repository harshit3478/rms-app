import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';

import 'scale1_review.dart';

class Vpt extends StatefulWidget {
  const Vpt({
    super.key,
    this.isFisSelected,
    this.isRmspsSelected,
    this.isVptSelected,
    this.rmsDs,
    this.getImage,
    this.scaleNumber,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.fis,
    this.rmsPs,
  });

  final bool? isRmspsSelected;
  final bool? isFisSelected;
  final bool? isVptSelected;
  final File? getImage;
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;
  final String? rmsDs;
  final String? rmsPs;
  final String? fis;

  @override
  State<Vpt> createState() => _VptState();
}

class _VptState extends State<Vpt> {
  final List<int?> _scores = List.filled(8, null);

  static const _images = [
    'assets/vpt1.jpg',
    'assets/vpt2.jpg',
    'assets/vpt3.jpg',
    'assets/vpt4.jpg',
    'assets/vpt5.jpg',
    'assets/vpt6.jpg',
    'assets/vpt7.jpg',
    'assets/vpt8.jpg',
  ];

  void _proceed() {
    final unanswered = _scores.any((s) => s == null);
    if (unanswered) {
      AppSnack.error(context, 'Please score all 8 images before proceeding.');
      return;
    }
    final total = _scores.fold<int>(0, (sum, s) => sum + s!);
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ReviewScale1(
        isRmspsSelected: widget.isRmspsSelected,
        isFisSelected: widget.isFisSelected,
        isVptSelected: widget.isVptSelected,
        rmsDs: widget.rmsDs,
        getImage: widget.getImage,
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        rmsPs: widget.rmsPs,
        fis: widget.fis,
        vpt: total.toString(),
      ),
    ));
  }

  void _showReference() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
        title: Text('Reference', style: AppTextStyles.heading3),
        content: Text(
          'Venham LL, Gaulin-Kremer E. A self-report measure of situational anxiety for young children. Pediatr Dent 1979;1:91-6.',
          style: AppTextStyles.bodySmall,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answered = _scores.where((s) => s != null).length;
    final total = answered == 8
        ? _scores.fold<int>(0, (sum, s) => sum + s!)
        : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Venham Picture Test', style: AppTextStyles.heading2),
            const SizedBox(height: 4),
            Text(
              'For each image, select 0 (calm) or 1 (anxious).',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 12),

            // Progress indicator
            Row(
              children: [
                Text(
                  '$answered / 8 scored',
                  style: AppTextStyles.caption.copyWith(
                    color: answered == 8 ? AppColors.success : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: answered / 8,
                      backgroundColor: AppColors.border,
                      color: answered == 8 ? AppColors.success : AppColors.primary,
                      minHeight: 4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2-column grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 8,
              itemBuilder: (context, i) => _VptItem(
                imagePath: _images[i],
                label: '${i + 1}',
                score: _scores[i],
                onScore: (v) => setState(() => _scores[i] = v),
              ),
            ),

            if (total != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'VPT Total Score: $total / 8',
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            const SizedBox(height: 24),
            AppButton(label: 'Proceed', onTap: _proceed),

            const SizedBox(height: 24),
            GestureDetector(
              onTap: _showReference,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Reference: ', style: AppTextStyles.caption),
                  Text(
                    'Venham & Gaulin-Kremer, 1979',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VptItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final int? score;
  final ValueChanged<int> onScore;

  const _VptItem({
    required this.imagePath,
    required this.label,
    required this.score,
    required this.onScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: score != null ? AppColors.primary : AppColors.border,
          width: score != null ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            'Item $label',
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ScoreBtn(
                  label: '0',
                  sublabel: 'Calm',
                  selected: score == 0,
                  onTap: () => onScore(0),
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _ScoreBtn(
                  label: '1',
                  sublabel: 'Anxious',
                  selected: score == 1,
                  onTap: () => onScore(1),
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreBtn extends StatelessWidget {
  final String label;
  final String sublabel;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _ScoreBtn({
    required this.label,
    required this.sublabel,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: selected ? color : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: selected ? color : AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
            Text(
              sublabel,
              style: AppTextStyles.caption.copyWith(
                color: selected ? color : AppColors.textHint,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
