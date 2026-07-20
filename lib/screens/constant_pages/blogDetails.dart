import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPreview extends StatelessWidget {
  final String? heading;
  final String? body;
  final String? citation;
  final String? date;
  final String? img;
  final String? link;
  final index;

  const BlogPreview({
    super.key,
    this.heading,
    this.body,
    this.citation,
    this.date,
    this.img,
    this.link,
    this.index,
  });

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      AppSnack.error(context, 'Invalid link.');
      return;
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) AppSnack.error(context, 'Could not open link.');
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BLOG',
              style: AppTextStyles.caption.copyWith(letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            Text(
              heading ?? '',
              style: AppTextStyles.heading1.copyWith(letterSpacing: 0.5),
            ),
            const SizedBox(height: 10),
            Text(
              'Dr Shetty  ·  ${date ?? ''}  ·  10 min read',
              style: AppTextStyles.bodySmall,
            ),
            if (link != null && link!.isNotEmpty) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _openLink(context, link!),
                child: Row(
                  children: [
                    const Icon(Icons.link, color: AppColors.primary, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        link!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            if (img != null && img!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Image.network(
                  img!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(body ?? '', style: AppTextStyles.body.copyWith(height: 1.65)),
            if (citation != null && citation!.isNotEmpty) ...[
              const SizedBox(height: 28),
              const Divider(),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Citation: ',
                      style: AppTextStyles.bodySmall,
                    ),
                    TextSpan(
                      text: citation,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
