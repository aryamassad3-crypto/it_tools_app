import 'package:flutter/material.dart';
import 'package:it_tools_app/core/theme/app_colors.dart';
import 'package:it_tools_app/core/theme/app_text_styles.dart';

class ProductGridCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleFavorite;

  const ProductGridCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = product['isAvailable'] ?? true;
    final bool isFavorite = product['isFavorite'] ?? false;
    final String? discount = product['discount'];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDefault, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColors.pageBg,
                      child: Opacity(
                        opacity: isAvailable ? 1.0 : 0.45,
                        child: Image.asset(
                          product['image'] ??
                              'assets/images/products/mouse_silent.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.textTertiary,
                                  size: 36,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: InkWell(
                      onTap: onToggleFavorite,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 16,
                          color: isFavorite
                              ? AppColors.danger
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 8,
                    start: 8,
                    child: isAvailable
                        ? (discount != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.orange,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    discount,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.onBrand,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink())
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.subtle,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'غير متوفر حالياً',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['category'] ?? 'ماوس',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['name'] ?? '',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product['rating']} (${product['reviewsCount']})',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['price'] ?? '',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              fontSize: 15,
                            ),
                          ),
                          if (product['oldPrice'] != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              product['oldPrice'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.textTertiary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                      InkWell(
                        onTap: isAvailable ? onAddToCart : null,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: isAvailable
                                ? AppColors.actionPrimary
                                : AppColors.actionDisabled,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: AppColors.onBrand,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
