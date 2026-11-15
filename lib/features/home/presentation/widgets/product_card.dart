import 'package:flutter/material.dart';
import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';
// تأكدي من وجود هذا السطر

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final String rating;
  final String? discount;
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
    required this.rating,
    this.discount,
    required this.onAddToCart,
    required this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderDefault,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // جزء الصورة، زر المفضلة، ووسم الخصم
          Stack(
            children: [
              // صورة المنتج
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // زر الإضافة للمفضلة (القلب) على اليسار
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
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      size: 18,
                      color: isFavorite ? Colors.red : AppColors.textTertiary,
                    ),
                  ),
                ),
              ),

              // وسم الخصم (مثل -20%) على اليمين إن وجد
              if (discount != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF79009),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount!,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // تفاصيل المنتج والنصوص
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // التصنيف المصغر
                Text(
                  category,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                
                // اسم المنتج (سطرين كحد أقصى)
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),

                // التقييم (النجوم)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '(128)',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Color(0xFFFDB022),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // السعر وزر الإضافة إلى السلة (+)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر الإضافة للسلة (مربع أزرق عليه علامة +)
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    // السعر الحالي والقديم
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (oldPrice != null)
                          Text(
                            oldPrice!,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textTertiary,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}