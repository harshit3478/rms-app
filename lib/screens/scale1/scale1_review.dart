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

class ReviewScale1 extends StatefulWidget {
  const ReviewScale1({
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
    this.fis,
    this.rmsPs,
    this.vpt,
    this.isFisSelected,
    this.isRmspsSelected,
    this.isVptSelected,
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
  final String? rmsPs;
  final String? fis;
  final String? vpt;
  final bool? isRmspsSelected;
  final bool? isFisSelected;
  final bool? isVptSelected;

  @override
  State<ReviewScale1> createState() => _ReviewScale1State();
}

class _ReviewScale1State extends State<ReviewScale1> {
  String? _note;
  String _favScale = 'RMS - DAS';
  bool _loading = false;

  List<String> get _availableScales {
    final scales = ['RMS - DAS'];
    if (widget.isRmspsSelected == true) scales.add('RMS - PS');
    if (widget.isFisSelected == true) scales.add('FIS');
    if (widget.isVptSelected == true) scales.add('VPT');
    return scales;
  }

  Future<void> _addData() async {
    setState(() => _loading = true);
    funcationLoaderBox(context);
    try {
      final authModal = await AuthCache().getAuth();
      final finalEmail = authModal.name;
      final finalUid = authModal.uid;

      dev.log('Starting image upload for patient: ${widget.name}', name: 'Scale1Review');

      final url = await uploadToCloudinary(
        widget.getImage!,
        folder: 'rms_dental/$finalEmail/${widget.name}',
      );

      final now = DateTime.now();
      final date = DateFormat('MMM d,yyyy').format(now);
      final time = DateFormat('EEEE, hh:mm aaa').format(now);

      final data = {
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
        'RMS Digital Anxiety Scale': widget.rmsDs,
        'fis scale score': widget.fis,
        'vpt scale score': widget.vpt,
        'note': _note,
        'fav scale': _favScale,
        if (widget.gender == 'FEMALE')
          'rms ps girls': widget.rmsPs
        else
          'rms ps scale score': widget.rmsPs,
      };

      dev.log('Saving patient record to Firestore', name: 'Scale1Review');
      await FirebaseFirestore.instance.collection('Patient').add(data);
      dev.log('Patient record saved successfully', name: 'Scale1Review');

      if (!mounted) return;
      Navigator.of(context).pop(); // dismiss loader
      dataSavedDialogBox(context);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.of(context).pop(); // dismiss success dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Navigation()),
      );
    } catch (e) {
      dev.log('Submit failed: $e', name: 'Scale1Review', level: 1000);
      if (!mounted) return;
      Navigator.of(context).pop(); // dismiss loader if open
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

            // Scale selector chips
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

            // Note field
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
