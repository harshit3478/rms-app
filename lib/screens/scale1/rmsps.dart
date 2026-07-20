import 'dart:io';

import 'package:rmsnewmodule/screens/scale1/fis.dart';
import 'package:rmsnewmodule/screens/scale1/scale1_review.dart';
import 'package:rmsnewmodule/screens/scale1/vpt.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:flutter/material.dart';

class RMSPS extends StatefulWidget {
  const RMSPS({
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

  @override
  State<RMSPS> createState() => _RMSPSState();
}

class _RMSPSState extends State<RMSPS> {
  int? _selected;

  bool get _isFemale => widget.gender == 'FEMALE';

  List<String> get _images => _isFemale
      ? [
          'assets/newAssets/s1.jpg',
          'assets/newAssets/s2.jpg',
          'assets/newAssets/s3.jpg',
          'assets/newAssets/s4.jpg',
          'assets/newAssets/s5.jpg',
        ]
      : [
          'assets/newAssets/RMS PS 1.jpg',
          'assets/newAssets/RMS PS 2.jpg',
          'assets/newAssets/RMS PS 3.jpg',
          'assets/newAssets/RMS PS 4.jpg',
          'assets/newAssets/RMS PS 5.jpg',
        ];

  void _proceed() {
    if (_selected == null) {
      AppSnack.error(context, 'Please select an image to continue.');
      return;
    }
    final score = _selected.toString();

    if (widget.isFisSelected == true) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => Fis(
          isRmspsSelected: widget.isRmspsSelected,
          isFisSelected: widget.isFisSelected,
          isVptSelected: widget.isVptSelected,
          rmsPs: score,
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
        ),
      ));
    } else if (widget.isFisSelected == false && widget.isVptSelected == true) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => Vpt(
          isRmspsSelected: widget.isRmspsSelected!,
          isFisSelected: widget.isFisSelected!,
          isVptSelected: widget.isVptSelected!,
          rmsPs: score,
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
          rmsPs: score,
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
          'Shetty RM, Khandelwal M, Rath S (2015). RMS Pictorial Scale (RMS-PS): An innovative scale for the assessment of child\'s dental anxiety. J Indian Soc Pedod Prev Dent., 33(1):48-52.',
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
            Text('RMS Pictorial Scale', style: AppTextStyles.heading2),
            const SizedBox(height: 16),

            // Reference scale image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Image.asset(
                _isFemale
                    ? 'assets/newAssets/RMS PS for Girls.jpg'
                    : 'assets/newAssets/RMSPSforBoys.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 90,
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Tap the picture that best shows how you feel right now:',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: List.generate(images.length, (i) {
                final score = i + 1;
                return _PsButton(
                  imagePath: images[i],
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
                  'RMS-PS Score: $_selected',
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
                  Flexible(
                    child: Text(
                      'Shetty et al., 2015',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
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

class _PsButton extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const _PsButton({
    required this.imagePath,
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
