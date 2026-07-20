import 'package:rmsnewmodule/screens/camera.dart';
import 'package:rmsnewmodule/screens/scale3/scale3_add_image.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_input.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepOneAddPatient extends StatefulWidget {
  const StepOneAddPatient({super.key, this.scaleNumber});
  final int? scaleNumber;

  @override
  _StepOneAddPatientState createState() => _StepOneAddPatientState();
}

class _StepOneAddPatientState extends State<StepOneAddPatient> {
  final _patientIdController = TextEditingController();
  final _appointmentNumController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _gender = '';

  @override
  void dispose() {
    _patientIdController.dispose();
    _appointmentNumController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _proceed() {
    final patientid = _patientIdController.text.trim();
    final appointmentNum = _appointmentNumController.text.trim();
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final address = _addressController.text.trim();
    final phnum = _phoneController.text.trim();

    if (patientid.isEmpty || appointmentNum.isEmpty || name.isEmpty ||
        age.isEmpty || address.isEmpty || _gender.isEmpty || phnum.isEmpty) {
      AppSnack.error(context, 'Please fill in all fields before proceeding.');
      return;
    }

    if (widget.scaleNumber == 3) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Scale3AddImage(
          scaleNumber: widget.scaleNumber!,
          patientid: patientid,
          name: name,
          appointmentNum: appointmentNum,
          age: age,
          address: address,
          gender: _gender,
          phnum: phnum,
        ),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Camera(
          scaleNumber: widget.scaleNumber!,
          patientid: patientid,
          name: name,
          appointmentNum: appointmentNum,
          age: age,
          address: address,
          gender: _gender,
          phnum: phnum,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Patient Information'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Patient Info', style: AppTextStyles.heading1),
              const SizedBox(height: 6),
              Text(
                'Fill in all fields to register the patient and proceed.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 28),
              AppInput(
                controller: _patientIdController,
                hint: 'Patient Unique ID',
                prefixIcon: Icons.format_list_numbered,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _appointmentNumController,
                hint: 'Test number for this patient',
                prefixIcon: Icons.confirmation_number_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _nameController,
                hint: 'Patient full name',
                prefixIcon: Icons.person_outline,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _ageController,
                hint: 'Patient age',
                prefixIcon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _addressController,
                hint: 'Patient address',
                prefixIcon: Icons.location_on_outlined,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              // Gender selector
              Text('Gender', style: AppTextStyles.label),
              const SizedBox(height: 8),
              Row(
                children: [
                  _GenderChip(
                    label: 'Male',
                    selected: _gender == 'MALE',
                    onTap: () => setState(() => _gender = 'MALE'),
                  ),
                  const SizedBox(width: 12),
                  _GenderChip(
                    label: 'Female',
                    selected: _gender == 'FEMALE',
                    onTap: () => setState(() => _gender = 'FEMALE'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _phoneController,
                hint: 'Phone number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _proceed(),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Proceed',
                onTap: _proceed,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.label.copyWith(
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
