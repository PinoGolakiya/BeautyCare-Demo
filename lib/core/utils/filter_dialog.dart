import 'package:beuticare_app/core/utils/app_colors.dart';
import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/provider_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showBrandFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<HomeViewModel>(
        builder: (context, provider, _) {
          final Set<String> selectedBrands = provider.selectedBrands;
          final List<String> allBrands = provider.allBrands;

          return AlertDialog(
            title: const Text(
              AppStrings.categories,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: allBrands.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCheckboxTile(
                    context,
                    title: AppStrings.all,
                    isChecked: selectedBrands.isEmpty,
                    onChanged: (bool? value) {
                      if (value == true) {
                        provider.clearAllBrands();
                      }
                    },
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: allBrands.map((brand) {
                        return _buildCheckboxTile(
                          context,
                          title: brand,
                          isChecked: selectedBrands.contains(brand),
                          onChanged: (bool? value) {
                            if (value == true) {
                              provider.addBrand(brand);
                            } else {
                              provider.removeBrand(brand);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
                  : const Center(
                child: Text(
                  AppStrings.noBrandes,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkColor,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(AppStrings.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

// Custom widget to build a checkbox with title
Widget _buildCheckboxTile(
    BuildContext context, {
      required String title,
      required bool isChecked,
      required void Function(bool?) onChanged,
    }) {
  return Row(
    children: [
      Checkbox(
        value: isChecked,
        onChanged: onChanged,
        activeColor: AppColors.selectionColor, // Customize the color as needed
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            onChanged(!isChecked); // Toggle the checkbox when the text is tapped
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isChecked ? AppColors.selectionColor : AppColors.whiteColor, // Change text color based on selection
            ),
          ),
        ),
      ),
    ],
  );
}
