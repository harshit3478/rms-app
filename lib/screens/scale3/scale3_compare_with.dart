import 'dart:io';

import 'package:rmsnewmodule/screens/scale2/mcdas.dart';
import 'package:rmsnewmodule/screens/scale3/scale3_review.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:flutter/material.dart';

class Scale3CompareWith extends StatefulWidget {
  const Scale3CompareWith({
    super.key,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.scaleNumber,
    this.img,
    this.rmsPcdas1,
    this.rmsPcdas2,
    this.rmsPcdas3,
    this.rmsPcdas4,
    this.rmsPcdas5,
    this.rmsPcdas6,
    this.rmsPcdas7,
    this.rmsPcdas8,
  });

  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;
  final File? img;
  final String? rmsPcdas1, rmsPcdas2, rmsPcdas3, rmsPcdas4, rmsPcdas5, rmsPcdas6, rmsPcdas7, rmsPcdas8;

  @override
  State<Scale3CompareWith> createState() => _Scale3CompareWithState();
}

class _Scale3CompareWithState extends State<Scale3CompareWith> {
  bool _mcdasf = false;

  void _proceed() {
    Widget next;
    if (_mcdasf) {
      next = Mcdas(
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        img: widget.img,
        rmsPcdas1: widget.rmsPcdas1, rmsPcdas2: widget.rmsPcdas2,
        rmsPcdas3: widget.rmsPcdas3, rmsPcdas4: widget.rmsPcdas4,
        rmsPcdas5: widget.rmsPcdas5, rmsPcdas6: widget.rmsPcdas6,
        rmsPcdas7: widget.rmsPcdas7, rmsPcdas8: widget.rmsPcdas8,
      );
    } else {
      next = Scale3Review(
        isSelected: false,
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        img: widget.img,
        rmsPcdas1: widget.rmsPcdas1, rmsPcdas2: widget.rmsPcdas2,
        rmsPcdas3: widget.rmsPcdas3, rmsPcdas4: widget.rmsPcdas4,
        rmsPcdas5: widget.rmsPcdas5, rmsPcdas6: widget.rmsPcdas6,
        rmsPcdas7: widget.rmsPcdas7, rmsPcdas8: widget.rmsPcdas8,
      );
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
        title: Text('About Scales', style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow('MCDASf', 'Modified Child Dental Anxiety Scale'),
            const SizedBox(height: 10),
            _InfoRow('RMS-PCDAS', 'RMS Pictorial Dental Anxiety Scale'),
          ],
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfo,
            tooltip: 'About scales',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Compare with MCDASf?', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Optionally add MCDASf alongside RMS-PCDAS.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 28),

            GestureDetector(
              onTap: () => setState(() => _mcdasf = !_mcdasf),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: _mcdasf ? AppColors.primaryLight : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: _mcdasf ? AppColors.primary : AppColors.border,
                    width: _mcdasf ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _mcdasf ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _mcdasf ? AppColors.primary : AppColors.border,
                          width: 2,
                        ),
                      ),
                      child: _mcdasf
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MCDASf', style: AppTextStyles.label),
                        Text('Modified Child Dental Anxiety Scale', style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            AppButton(
              label: _mcdasf ? 'Proceed' : 'Skip',
              onTap: _proceed,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(value, style: AppTextStyles.bodySmall)),
      ],
    );
  }
}
