import 'dart:io';

import 'package:image/image.dart' as image_lib;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:photofilters/photofilters.dart';
import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';

import '../scale2/rmsPcdas.dart';

class Scale3AddImage extends StatefulWidget {
  const Scale3AddImage({
    super.key,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.scaleNumber,
  });

  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;

  @override
  State<Scale3AddImage> createState() => _Scale3AddImageState();
}

class _Scale3AddImageState extends State<Scale3AddImage> {
  XFile? _image;
  File? _filteredImage;
  bool _loading = false;
  final _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _loading = true);
    try {
      final picked = await _picker.pickImage(source: source);
      if (picked == null) {
        if (mounted) setState(() => _loading = false);
        return;
      }
      _image = picked;

      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 900,
        maxWidth: 900,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Cropper'),
        ],
      );

      if (cropped == null) {
        if (mounted) setState(() => _loading = false);
        return;
      }

      var decoded = image_lib.decodeImage(
        await File(cropped.path).readAsBytes(),
      );
      decoded = image_lib.copyResize(decoded!, width: 420);

      if (!mounted) return;

      final result = await Navigator.push<Map>(
        context,
        MaterialPageRoute(
          builder: (_) => PhotoFilterSelector(
            title: Text('Add Filters', style: AppTextStyles.heading3),
            image: decoded!,
            filters: presetFiltersList,
            filename: basename(picked.path),
            loader: const Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (!mounted) return;
      if (result != null && result.containsKey('image_filtered')) {
        setState(() {
          _filteredImage = result['image_filtered'] as File;
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text('Gallery', style: AppTextStyles.body),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text('Camera', style: AppTextStyles.body),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _proceed() {
    if (_image == null) {
      AppSnack.error(context, 'Please take or select a picture first.');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SecondScale(
          scaleNumber: widget.scaleNumber,
          patientid: widget.patientid,
          name: widget.name,
          appointmentNum: widget.appointmentNum,
          age: widget.age,
          address: widget.address,
          gender: widget.gender,
          phnum: widget.phnum,
          img: _filteredImage ?? File(_image!.path),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: _loading
            ? const SizedBox()
            : IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
      ),
      body: _loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text('Processing image…', style: AppTextStyles.bodySmall),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Text('Add Patient Picture', style: AppTextStyles.heading2),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to add an image for ${widget.name ?? 'patient'}.',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: GestureDetector(
                      onTap: _showSourceSheet,
                      child: Stack(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _filteredImage != null
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: _filteredImage != null ? 2 : 1,
                              ),
                            ),
                            child: _filteredImage != null
                                ? ClipOval(
                                    child: Image.file(
                                      _filteredImage!,
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  AppButton(label: 'Proceed', onTap: _proceed),
                ],
              ),
            ),
    );
  }
}
