import 'package:rmsnewmodule/screens/files.dart';
import 'package:rmsnewmodule/screens/step_one_add_patient.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('RMS Scales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Welcome!', style: AppTextStyles.heading1),
            const SizedBox(height: 4),
            Text(
              'Select a scale to begin assessment.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 24),
            _ScaleCard(
              scaleNumber: 1,
              tag: 'RMS-DAS',
              title: 'RMS Digital Anxiety Scale',
              description:
                  'Measures dental anxiety in children using AI-powered digital assessment with multiple validated sub-scales.',
            ),
            const SizedBox(height: 16),
            _ScaleCard(
              scaleNumber: 2,
              tag: 'RMS-DCDAS',
              title: 'RMS Digital Child Dental Anxiety Scale',
              description:
                  'Evaluates child dental anxiety using a comprehensive digital assessment tailored for paediatric patients.',
            ),
            const SizedBox(height: 16),
            _ScaleCard(
              scaleNumber: 3,
              tag: 'RMS-PCDAS',
              title: 'RMS Pictorial Child Dental Anxiety Scale',
              description:
                  'A pictorial scale for measuring dental anxiety in children using the RMS Pictorial Scale methodology.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('About RMS Scales', style: AppTextStyles.heading3),
        content: Text(
          'RMS Anxiety Scales are validated digital tools developed by Dr. Ragavendra M. Shetty for measuring dental anxiety in paediatric patients.',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ScaleCard extends StatelessWidget {
  final int scaleNumber;
  final String tag;
  final String title;
  final String description;

  const _ScaleCard({
    required this.scaleNumber,
    required this.tag,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Text(
              tag,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: AppTextStyles.heading3),
          const SizedBox(height: 6),
          Text(description, style: AppTextStyles.bodySmall),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Start New',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StepOneAddPatient(scaleNumber: scaleNumber),
                  )),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton.outlined(
                  label: 'Retest',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Files(backArrow: true),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
