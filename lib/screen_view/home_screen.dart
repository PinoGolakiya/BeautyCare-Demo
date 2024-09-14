import 'package:beuticare_app/core/utils/app_colors.dart';
import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/provider_model/home_view_model.dart';
import 'package:beuticare_app/screen_view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/filter_dialog.dart'; // Make sure this import matches the actual path

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => showBrandFilterDialog(context), // Show filter dialog
            child: Container(
              height: size.height * 0.040,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: const Center(
                child: Text(
                  AppStrings.filter,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Consumer<HomeViewModel>(
          builder: (context, provider, _) {
            if (provider.categories.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.whiteColor),
              );
            }

            return provider.isLoading == false
                ? Column(
                    children: [
                      const SizedBox(height: 5),
                      // Horizontal List for Categories
                      SizedBox(
                        height: size.height * 0.080,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.categories.length + 1,
                          itemBuilder: (context, index) {
                            final category = index == 0
                                ? AppStrings.all
                                : provider.categories[index - 1];
                            final isSelected =
                                provider.selectedCategories.contains(category);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                selectedColor: AppColors.selectionColor,
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.darkColor
                                        : AppColors.whiteColor,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  provider.filterByCategory(category, selected);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // List for Products
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.displayedProducts.length,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, index) {
                            final product = provider.displayedProducts[index];

                            final hasDiscount =
                                product.discountPercentage != null &&
                                    product.discountPercentage! > 0;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            product.thumbnail != null
                                                ? Image.network(
                                                    product.thumbnail!,
                                                    width: size.width * 0.300,
                                                    height: size.height * 0.15,
                                                    fit: BoxFit.fill,
                                                  )
                                                : const SizedBox(),
                                            const VerticalDivider(
                                              color: AppColors.darkColor,
                                              thickness: 1.5,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      product.title ??
                                                          'No Title',
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.darkColor,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          product.brand ??
                                                              'No Brand',
                                                          softWrap: true,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .darkColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹${product.price}",
                                                          softWrap: true,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .darkColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    hasDiscount
                                        ? Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              width: size.width * 0.2,
                                              height: size.height * 0.20,
                                              color: Colors.transparent,
                                              child: Banner(
                                                message:
                                                    '${AppStrings.saveDiscount} ${product.discountPercentage!}%',
                                                location:
                                                    BannerLocation.topStart,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child:
                        CircularProgressIndicator(color: AppColors.whiteColor),
                  );
          },
        ),
      ),
    );
  }
}
