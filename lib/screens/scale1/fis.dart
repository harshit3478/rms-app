import 'dart:io';

import 'package:rmsnewmodule/screens/scale1/scale1_review.dart';
import 'package:rmsnewmodule/screens/scale1/vpt.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:flutter/material.dart';

class Fis extends StatefulWidget {
  const Fis({
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

  @override
  State<Fis> createState() => _FisState();
}

class _FisState extends State<Fis> {
  int? _selected; // 1–5

  static const _images = [
    'assets/newAssets/5. FIS 1.png',
    'assets/newAssets/4. FIS 2.png',
    'assets/newAssets/3. FIS 3.png',
    'assets/newAssets/2. FIS 4.png',
    'assets/newAssets/1. FIS 5.png',
  ];

  void _proceed() {
    if (_selected == null) {
      AppSnack.error(context, 'Please select a face image to continue.');
      return;
    }
    final score = _selected.toString();

    if (widget.isVptSelected == true) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => Vpt(
          isRmspsSelected: widget.isRmspsSelected!,
          isFisSelected: widget.isFisSelected!,
          isVptSelected: widget.isVptSelected!,
          rmsDs: widget.rmsDs!,
          getImage: widget.getImage!,
          scaleNumber: widget.scaleNumber!,
          patientid: widget.patientid!,
          name: widget.name!,
          appointmentNum: widget.appointmentNum!,
          age: widget.age!,
          address: widget.address!,
          gender: widget.gender!,
          phnum: widget.phnum!,
          rmsPs: widget.rmsPs.toString(),
          fis: score,
        ),
      ));
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => ReviewScale1(
          isRmspsSelected: widget.isRmspsSelected!,
          isFisSelected: widget.isFisSelected!,
          isVptSelected: widget.isVptSelected!,
          rmsDs: widget.rmsDs!,
          getImage: widget.getImage!,
          scaleNumber: widget.scaleNumber!,
          patientid: widget.patientid!,
          name: widget.name!,
          appointmentNum: widget.appointmentNum!,
          age: widget.age!,
          address: widget.address!,
          gender: widget.gender!,
          phnum: widget.phnum!,
          fis: score,
        ),
      ));
    }
  }

  void _showReference() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
        title: Text('Reference', style: AppTextStyles.heading3),
        content: Text(
          'Buchanan H, Niven N. Validation of a facial image scale to assess child dental anxiety. Int J Paediatr Dent 2002;12:47-52.',
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
    final images = _images;

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
          children: [
            Text('Facial Image Scale', style: AppTextStyles.heading2),
            const SizedBox(height: 16),

            // Scale reference image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Image.asset(
                'assets/newAssets/fis_scale.jpg',
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 90,
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Tap the face that best shows how you feel right now:',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Faces grid — 2 per row, last one centred
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: List.generate(images.length, (i) {
                final score = i + 1;
                return _FisButton(
                  imagePath: images[i],
                  label: score.toString(),
                  selected: _selected == score,
                  onTap: () => setState(() => _selected = score),
                );
              }),
            ),

            if (_selected != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'FIS Score: $_selected',
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
              ),
            ],

            const SizedBox(height: 32),
            AppButton(label: 'Proceed', onTap: _proceed),

            const SizedBox(height: 32),
            GestureDetector(
              onTap: _showReference,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Reference: ', style: AppTextStyles.caption),
                  Text(
                    'Buchanan H, Niven N., 2002',
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

class _FisButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FisButton({
    required this.imagePath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 3,
          ),
        ),
        child: Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
