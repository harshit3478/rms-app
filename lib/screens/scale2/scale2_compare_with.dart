import 'dart:io';

import 'package:rmsnewmodule/screens/scale2/mcdas.dart';
import 'package:rmsnewmodule/screens/scale2/rmsPcdas.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:flutter/material.dart';

import 'scale2_review.dart';

class Scale2CompareWith extends StatefulWidget {
  const Scale2CompareWith({
    super.key,
    this.getImage,
    this.scaleNumber,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.dcdas1,
    this.dcdas2,
    this.dcdas3,
    this.dcdas4,
    this.dcdas5,
    this.dcdas6,
    this.dcdas7,
    this.dcdas8,
  });

  final File? getImage;
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;
  final String? dcdas1, dcdas2, dcdas3, dcdas4, dcdas5, dcdas6, dcdas7, dcdas8;

  @override
  State<Scale2CompareWith> createState() => _Scale2CompareWithState();
}

class _Scale2CompareWithState extends State<Scale2CompareWith> {
  bool _rmspcdas = false;
  bool _mcdasf = false;

  void _proceed() {
    Widget next;
    if (!_rmspcdas && !_mcdasf) {
      next = Scale2Review(
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        img: widget.getImage,
        isMcdasfSelected: false,
        isRmspcdasSelected: false,
        dcdas1: widget.dcdas1, dcdas2: widget.dcdas2,
        dcdas3: widget.dcdas3, dcdas4: widget.dcdas4,
        dcdas5: widget.dcdas5, dcdas6: widget.dcdas6,
        dcdas7: widget.dcdas7, dcdas8: widget.dcdas8,
      );
    } else if (_rmspcdas) {
      next = SecondScale(
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        img: widget.getImage,
        isMcdasfSelected: _mcdasf,
        isRmspcdasSelected: true,
        dcdas1: widget.dcdas1, dcdas2: widget.dcdas2,
        dcdas3: widget.dcdas3, dcdas4: widget.dcdas4,
        dcdas5: widget.dcdas5, dcdas6: widget.dcdas6,
        dcdas7: widget.dcdas7, dcdas8: widget.dcdas8,
      );
    } else {
      next = Mcdas(
        scaleNumber: widget.scaleNumber,
        patientid: widget.patientid,
        name: widget.name,
        appointmentNum: widget.appointmentNum,
        age: widget.age,
        address: widget.address,
        gender: widget.gender,
        phnum: widget.phnum,
        img: widget.getImage,
        isMcdasfSelected: true,
        isRmspcdasSelected: false,
        dcdas1: widget.dcdas1, dcdas2: widget.dcdas2,
        dcdas3: widget.dcdas3, dcdas4: widget.dcdas4,
        dcdas5: widget.dcdas5, dcdas6: widget.dcdas6,
        dcdas7: widget.dcdas7, dcdas8: widget.dcdas8,
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
    final anySelected = _rmspcdas || _mcdasf;

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
            Text('Compare with other scales?', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Select additional scales to administer alongside RMS-DCDAS.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 28),

            _ToggleChip(
              label: 'RMS-PCDAS',
              subtitle: 'RMS Pictorial Dental Anxiety Scale',
              selected: _rmspcdas,
              onTap: () => setState(() => _rmspcdas = !_rmspcdas),
            ),
            const SizedBox(height: 12),
            _ToggleChip(
              label: 'MCDASf',
              subtitle: 'Modified Child Dental Anxiety Scale',
              selected: _mcdasf,
              onTap: () => setState(() => _mcdasf = !_mcdasf),
            ),

            const Spacer(),

            AppButton(
              label: anySelected ? 'Proceed' : 'Skip',
              onTap: _proceed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleChip({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.label),
                Text(subtitle, style: AppTextStyles.caption),
              ],
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
