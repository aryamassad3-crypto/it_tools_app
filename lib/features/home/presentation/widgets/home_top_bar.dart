import 'package:flutter/material.dart';

import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // اليمين: أيقونة الإشعارات مع نقطة التنبيه الحمراء
        Stack(
          children: [
            IconButton(
              onPressed: () {
                // TODO: الانتقال لشاشة الإشعارات
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 26,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        // اليسار: الترحيب، العبارة، وشعار التطبيق (حرف الميم داخل المربع الأزرق)
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'أهلاً نور',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('👋', style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'اكتشف أحدث الإكسسوارات',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // شعار التطبيق (حرف الميم)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'م',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
