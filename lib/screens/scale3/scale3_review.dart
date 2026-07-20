import 'dart:developer' as dev;
import 'dart:io';

import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:rmsnewmodule/widgets/functionLoaderBox.dart';
import 'package:rmsnewmodule/widgets/cloudinary_upload.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:rmsnewmodule/widgets/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scale3Review extends StatefulWidget {
  const Scale3Review({
    super.key,
    this.isSelected,
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
    this.mcdas1,
    this.mcdas2,
    this.mcdas3,
    this.mcdas4,
    this.mcdas5,
    this.mcdas6,
    this.mcdas7,
    this.mcdas8,
  });

  final bool? isSelected;
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
  final String? mcdas1, mcdas2, mcdas3, mcdas4, mcdas5, mcdas6, mcdas7, mcdas8;

  @override
  State<Scale3Review> createState() => _Scale3ReviewState();
}

class _Scale3ReviewState extends State<Scale3Review> {
  String? _note;
  String _favScale = 'RMS-PCDAS';
  bool _loading = false;

  List<String> get _availableScales {
    final scales = ['RMS-PCDAS'];
    if (widget.isSelected == true) scales.add('MCDASf');
    return scales;
  }

  Future<void> _addData() async {
    setState(() => _loading = true);
    funcationLoaderBox(context);
    try {
      final authModal = await AuthCache().getAuth();
      final finalEmail = authModal.name;
      final finalUid = authModal.uid;

      final url = await uploadToCloudinary(
        widget.img!,
        folder: 'rms_dental/$finalEmail/${widget.name}',
      );

      final now = DateTime.now();
      final date = DateFormat('MMM d,yyyy').format(now);
      final time = DateFormat('EEEE, hh:mm aaa').format(now);

      await FirebaseFirestore.instance.collection('Patient').add({
        'ID': widget.patientid,
        'patientid': widget.patientid,
        'app no': widget.appointmentNum,
        'name': widget.name,
        'age': widget.age,
        'address': widget.address,
        'gender': widget.gender,
        'phnum': widget.phnum,
        'uid': finalUid,
        'url': url,
        'date': date,
        'time': time,
        'dcdas1': null, 'dcdas2': null, 'dcdas3': null, 'dcdas4': null,
        'dcdas5': null, 'dcdas6': null, 'dcdas7': null, 'dcdas8': null,
        'pcdas1': widget.rmsPcdas1, 'pcdas2': widget.rmsPcdas2,
        'pcdas3': widget.rmsPcdas3, 'pcdas4': widget.rmsPcdas4,
        'pcdas5': widget.rmsPcdas5, 'pcdas6': widget.rmsPcdas6,
        'pcdas7': widget.rmsPcdas7, 'pcdas8': widget.rmsPcdas8,
        'note': _note,
        'fav scale': _favScale,
        'mcdasf1': widget.mcdas1, 'mcdasf2': widget.mcdas2,
        'mcdasf3': widget.mcdas3, 'mcdasf4': widget.mcdas4,
        'mcdasf5': widget.mcdas5, 'mcdasf6': widget.mcdas6,
        'mcdasf7': widget.mcdas7, 'mcdasf8': widget.mcdas8,
        'RMS Digital Anxiety Scale': null,
        'fis scale score': null,
        'vpt scale score': null,
        'rms ps girls': null,
        'rms ps scale score': null,
      });

      if (!mounted) return;
      Navigator.of(context).pop();
      dataSavedDialogBox(context);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Navigation()),
      );
    } catch (e) {
      dev.log('Submit failed: $e', name: 'Scale3Review', level: 1000);
      if (!mounted) return;
      Navigator.of(context).pop();
      AppSnack.error(context, 'Failed to save record. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scales = _availableScales;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Which scale did you like most?', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Select the scale that was easiest for the patient.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: scales.map((scale) {
                final selected = _favScale == scale;
                return GestureDetector(
                  onTap: () => setState(() => _favScale = scale),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.border,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      scale,
                      style: AppTextStyles.label.copyWith(
                        color: selected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            Text('Notes', style: AppTextStyles.label),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _note = v,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Optional notes for this assessment…',
                hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: AppTextStyles.body,
            ),

            const SizedBox(height: 32),

            AppButton(
              label: 'Finish & Save',
              loading: _loading,
              onTap: _addData,
            ),
          ],
        ),
      ),
    );
  }
}
