import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmsnewmodule/screens/constant_pages/blogDetails.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Blog')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('blog').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.article_outlined, size: 56, color: AppColors.textHint),
                  const SizedBox(height: 12),
                  Text('No posts yet', style: AppTextStyles.bodyMedium),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              final heading = data['heading']?.toString() ?? '';
              final body = data['body']?.toString() ?? '';
              final img = data['img']?.toString() ?? '';
              final link = data['link']?.toString() ?? '';
              final citation = data['citation']?.toString() ?? '';
              final date = data['date']?.toString() ?? '';

              return _BlogCard(
                heading: heading,
                body: body,
                img: img,
                date: date,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlogPreview(
                    heading: heading,
                    body: body,
                    date: date,
                    citation: citation,
                    img: img,
                    link: link,
                    index: docs[i].reference,
                  ),
                )),
              );
            },
          );
        },
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final String heading;
  final String body;
  final String img;
  final String date;
  final VoidCallback onTap;

  const _BlogCard({
    required this.heading,
    required this.body,
    required this.img,
    required this.date,
    required this.onTap,
  });

  Widget _imgPlaceholder() => Container(
        width: 80,
        height: 80,
        color: AppColors.primaryLight,
        child: const Icon(Icons.article_outlined, color: AppColors.primary, size: 36),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: img.isNotEmpty
                  ? Image.network(
                      img,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imgPlaceholder(),
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : Container(
                              width: 80,
                              height: 80,
                              color: AppColors.primaryLight,
                              child: const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                    )
                  : _imgPlaceholder(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      '10 min read',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    heading,
                    style: AppTextStyles.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (date.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(date, style: AppTextStyles.caption),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
