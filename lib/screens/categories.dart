import 'package:flutter/material.dart';
import 'package:plate_pilot_riverpod/data/dummy_data.dart';
import 'package:plate_pilot_riverpod/models/category.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';
import 'package:plate_pilot_riverpod/screens/meals.dart';
import 'package:plate_pilot_riverpod/widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFavoutiteMeal, required this.availableMeals});
  final void Function(Meal meal) onToggleFavoutiteMeal;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  void _selectCategory(BuildContext context, {required Category category}) {
    final filteredMeals =
        widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Meals(
          meals: filteredMeals,
          title: category.title,
          onToggleFavoutiteMeal: widget.onToggleFavoutiteMeal,
        ),
      ),
    );
  }

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.4),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInCubic,
          ),
        ),
        child: child,
      ),
      child: Padding(
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
      ),
    );
  }
}
