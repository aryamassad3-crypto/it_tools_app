import 'package:flutter/material.dart';
import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final String rating;
  final String reviewsCount;
  final String? discount;
  final bool isOutOfStock;
  final VoidCallback onAddToCart;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    this.rating = '4.8',
    this.reviewsCount = '128',
    this.discount,
    this.isOutOfStock = false,
    required this.onAddToCart,
    required this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDefault, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. جزء الصورة المربعة مع خلفية ناعمة
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Container(
                    height: 155, // ارتفاع مطابق لصورة Figma المربعة
                    width: double.infinity,
                    color: const Color(0xFFF6F9FC),
                    child: Opacity(
                      opacity: isOutOfStock ? 0.45 : 1.0,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.textTertiary,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // زر الإضافة للمفضلة (القلب) في أعلى اليسار
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 16,
                        color: isFavorite
                            ? Colors.red
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                // وسم الخصم (-20%) في أعلى اليمين
                if (discount != null && !isOutOfStock)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        discount!,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.navy900,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // نص "غير متوفر حالياً" في أعلى اليمين مطابق لـ Figma
                if (isOutOfStock)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      'غير متوفر حالياً',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

            // 2. تفاصيل المنتج والنصوص
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم التصنيف المصغر
                    Text(
                      category,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // اسم المنتج
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isOutOfStock
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 6),

                    // التقييم والنجوم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.orange,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($reviewsCount)',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // السعر على اليمين وزر الإضافة (+) على اليسار
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // السعر الحالي والقديم
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              price,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: isOutOfStock
                                    ? AppColors.textTertiary
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (oldPrice != null)
                              Text(
                                oldPrice!,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textTertiary,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),

                        // زر الإضافة للسلة (+)
                        GestureDetector(
                          onTap: isOutOfStock ? null : onAddToCart,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isOutOfStock
                                  ? const Color(0xFFD5E1EB)
                                  : AppColors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
