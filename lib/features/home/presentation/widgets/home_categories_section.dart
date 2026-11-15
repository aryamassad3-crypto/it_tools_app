import 'package:flutter/material.dart';

import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'title': 'ماوس', 'icon': Icons.mouse_rounded},
      {'title': 'كيبورد', 'icon': Icons.keyboard_rounded},
      {'title': 'سماعات', 'icon': Icons.headphones_rounded},
      {'title': 'هب USB', 'icon': Icons.usb_rounded},
      {'title': 'ستاند', 'icon': Icons.laptop_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'عرض الكل',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 12,
                    color: AppColors.blue,
                  ),
                ],
              ),
            ),
            Text(
              'تسوق حسب القسم',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.borderDefault,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: AppColors.blue,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category['title'] as String,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
