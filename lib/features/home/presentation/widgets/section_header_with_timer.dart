import 'package:flutter/material.dart';

import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';

class SectionHeaderWithTimer extends StatelessWidget {
  final String title;
  final VoidCallback onViewAllPressed;

  const SectionHeaderWithTimer({
    super.key,
    required this.title,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // اليمين: زر "عرض الكل" مع السهم
        TextButton(
          onPressed: onViewAllPressed,
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

        // اليسار: عنوان القسم مع عداد الوقت الرقمي (Hours : Minutes : Seconds)
        Row(
          children: [
            // مربعات الوقت الرقمي المصغرة (مثلاً 12 : 45 : 08)
            const Row(
              children: [
                _TimeUnitBox(timeText: '12'),
                _TimeSeparator(),
                _TimeUnitBox(timeText: '45'),
                _TimeSeparator(),
                _TimeUnitBox(timeText: '08'),
              ],
            ),
            const SizedBox(width: 8),
            // أيقونة البرق بجانب العنوان
            const Icon(
              Icons.flash_on_rounded,
              size: 20,
              color: Color(0xFFF79009), // لون برتقالي مميز للعروض
            ),
            const SizedBox(width: 4),
            // عنوان القسم (عروض اليوم)
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ودجت فرعية صغيرة ومغلقة لتمثيل مربع الوقت الرقمي
class _TimeUnitBox extends StatelessWidget {
  final String timeText;

  const _TimeUnitBox({required this.timeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF101828), // خلفية داكنة احترافية للعداد
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        timeText,
        // تم استبدال labelSmall بـ labelMedium مع تحديد الحجم لتجنب أي خطأ
        style: AppTextStyles.labelMedium.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}

// الفاصل بين مربعات الوقت (النقطتين رأسيتين)
class _TimeSeparator extends StatelessWidget {
  const _TimeSeparator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: Text(
        ':',
        style: TextStyle(
          color: Color(0xFF101828),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
