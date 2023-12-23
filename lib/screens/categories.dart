import 'package:flutter/material.dart';
import 'package:plate_pilot_riverpod/data/dummy_data.dart';
import 'package:plate_pilot_riverpod/models/category.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';
import 'package:plate_pilot_riverpod/screens/meals.dart';
import 'package:plate_pilot_riverpod/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFavoutiteMeal, required this.availableMeals});
  final void Function(Meal meal) onToggleFavoutiteMeal;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, {required Category category}) {
    final filteredMeals =
        availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Meals(
          meals: filteredMeals,
          title: category.title,
          onToggleFavoutiteMeal: onToggleFavoutiteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return CategoryItem(
            category: availableCategories[index],
            onSelectCategory: () {
              _selectCategory(context, category: availableCategories[index]);
            },
          );
        },
      ),
    );
  }
}
