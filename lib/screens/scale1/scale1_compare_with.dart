import 'dart:io';

import 'package:rmsnewmodule/screens/scale1/fis.dart';
import 'package:rmsnewmodule/screens/scale1/rmsps.dart';
import 'package:rmsnewmodule/screens/scale1/scale1_review.dart';
import 'package:rmsnewmodule/screens/scale1/vpt.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:flutter/material.dart';

class RmsDSCompareWith extends StatefulWidget {
  const RmsDSCompareWith({
    super.key,
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
  State<RmsDSCompareWith> createState() => _RmsDSCompareWithState();
}

class _RmsDSCompareWithState extends State<RmsDSCompareWith> {
  bool _rmsPS = false;
  bool _fis = false;
  bool _vpt = false;

  void _proceed() {
    final args = (
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
    );

    Widget next;
    if (!_rmsPS && !_fis && !_vpt) {
      next = ReviewScale1(
        isRmspsSelected: false,
        isFisSelected: false,
        isVptSelected: false,
        rmsDs: args.rmsDs,
        getImage: args.getImage,
        scaleNumber: args.scaleNumber,
        patientid: args.patientid,
        name: args.name,
        appointmentNum: args.appointmentNum,
        age: args.age,
        address: args.address,
        gender: args.gender,
        phnum: args.phnum,
      );
    } else if (_rmsPS) {
      next = RMSPS(
        isRmspsSelected: _rmsPS,
        isFisSelected: _fis,
        isVptSelected: _vpt,
        rmsDs: args.rmsDs,
        getImage: args.getImage,
        scaleNumber: args.scaleNumber,
        patientid: args.patientid,
        name: args.name,
        appointmentNum: args.appointmentNum,
        age: args.age,
        address: args.address,
        gender: args.gender,
        phnum: args.phnum,
      );
    } else if (_fis) {
      next = Fis(
        isRmspsSelected: false,
        isFisSelected: _fis,
        isVptSelected: _vpt,
        rmsDs: args.rmsDs,
        getImage: args.getImage,
        scaleNumber: args.scaleNumber,
        patientid: args.patientid,
        name: args.name,
        appointmentNum: args.appointmentNum,
        age: args.age,
        address: args.address,
        gender: args.gender,
        phnum: args.phnum,
      );
    } else {
      next = Vpt(
        isRmspsSelected: false,
        isFisSelected: false,
        isVptSelected: true,
        rmsDs: args.rmsDs!,
        getImage: args.getImage!,
        scaleNumber: args.scaleNumber!,
        patientid: args.patientid!,
        name: args.name!,
        appointmentNum: args.appointmentNum!,
        age: args.age!,
        address: args.address!,
        gender: args.gender!,
        phnum: args.phnum!,
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
            _InfoRow('RMS - PS', 'RMS Pictorial Scale'),
            const SizedBox(height: 10),
            _InfoRow('FIS', 'Facial Image Scale'),
            const SizedBox(height: 10),
            _InfoRow('VPT', 'Venham Picture Test'),
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
    final anySelected = _rmsPS || _fis || _vpt;

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
              'Select any additional scales to administer alongside RMS - DAS.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 28),

            // Toggle chips
            _ToggleChip(
              label: 'RMS - PS',
              subtitle: 'RMS Pictorial Scale',
              selected: _rmsPS,
              onTap: () => setState(() => _rmsPS = !_rmsPS),
            ),
            const SizedBox(height: 12),
            _ToggleChip(
              label: 'FIS',
              subtitle: 'Facial Image Scale',
              selected: _fis,
              onTap: () => setState(() => _fis = !_fis),
            ),
            const SizedBox(height: 12),
            _ToggleChip(
              label: 'VPT',
              subtitle: 'Venham Picture Test',
              selected: _vpt,
              onTap: () => setState(() => _vpt = !_vpt),
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
          child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(value, style: AppTextStyles.bodySmall)),
      ],
    );
  }
}
