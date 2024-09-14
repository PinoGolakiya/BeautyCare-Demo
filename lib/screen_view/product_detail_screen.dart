import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/model/beauticare_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/utils/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;

  ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.product.title ?? AppStrings.productDetails,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              if (widget.product.thumbnail != null)
                Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    widget.product.thumbnail!,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.description,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description ?? AppStrings.noDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.borderColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      AppStrings.reviews,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (widget.product.reviews != null &&
                        widget.product.reviews!.isNotEmpty)
                      ...widget.product.reviews!.map((review) {
                        final reviewDate = DateTime.parse(review.date!);
                        final formattedDate =
                            '${reviewDate.day} ${_getMonthName(reviewDate.month)} ${reviewDate.year}';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 2,
                            color: AppColors.whiteColor.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          review.reviewerName ??
                                              AppStrings.anonymous,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "On $formattedDate",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.darkColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 5),
                                  // LIST Generate rating value wise
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < review.rating!
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    review.comment ?? AppStrings.noComment,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColors.darkColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    else
                      const Text(AppStrings.noReviews),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom create date format
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
