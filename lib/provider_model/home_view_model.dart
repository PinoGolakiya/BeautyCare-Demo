import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../core/utils/app_strings.dart';
import '../model/beauticare_product_model.dart';

class HomeViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<String> categories = []; // List of categories
  List<Products> allProducts = []; // All products
  List<Products> displayedProducts = []; // Products displayed based on selected categories
  Set<String> selectedCategories = {}; // Track selected categories
  Set<String> selectedBrands = {}; // Track selected brands
  List<String> allBrands = []; // List of all brands
  bool isLoading = false;

  /// Fetch products detail data
  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        log("Response Data: ${response.data}");

        if (response.data is Map<String, dynamic>) {
          final data = BeautiCareProduct.fromJson(response.data);
          allProducts = data.products ?? [];
          categories = allProducts.map((p) => p.category ?? 'Unknown').toSet().toList();
          allBrands = allProducts.map((p) => p.brand ?? 'Unknown').toSet().toList();

          // Initialize with "All" selected
          selectedCategories = {AppStrings.all};
          displayedProducts = allProducts;

          notifyListeners();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log("Error: $e");
      throw Exception('Failed to load products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String category, bool isSelected) {
    if (category == AppStrings.all) {
      if (isSelected) {
        // Reset to show all products and clear other selections
        selectedCategories = {AppStrings.all};
      } else {
        // If "All" is deselected, show the products based on other selections
        if (selectedCategories.isNotEmpty) {
          selectedCategories.remove(AppStrings.all);
        }
        if (selectedCategories.isEmpty) {
          selectedCategories.add(AppStrings.all);
        }
      }
    } else {
      if (isSelected) {
        selectedCategories.add(category);
        // Remove "All" if other categories are selected
        selectedCategories.remove(AppStrings.all);
      } else {
        selectedCategories.remove(category);
        if (selectedCategories.isEmpty) {
          selectedCategories.add(AppStrings.all);
        }
      }
    }

    filterProducts();
  }

  void addBrand(String brand) {
    selectedBrands.add(brand);
    filterProducts();
    notifyListeners();
  }

  void removeBrand(String brand) {
    selectedBrands.remove(brand);
    filterProducts();
    notifyListeners();
  }

  void clearAllBrands() {
    selectedBrands.clear();
    filterProducts();
    notifyListeners();
  }

  void filterProducts() {
    if (selectedCategories.contains(AppStrings.all)) {
      displayedProducts = allProducts;
    } else {
      displayedProducts = allProducts.where((p) => selectedCategories.contains(p.category)).toList();
    }

    if (selectedBrands.isNotEmpty) {
      displayedProducts = displayedProducts.where((p) => selectedBrands.contains(p.brand)).toList();
    }

    notifyListeners();
  }
}
