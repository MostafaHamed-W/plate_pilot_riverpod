import 'package:flutter/material.dart';
import 'package:plate_pilot/models/meal.dart';
import 'package:plate_pilot/screens/meal_details.dart';
import 'package:plate_pilot/widgets/meal_item.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, required this.meals, this.title, required this.onToggleFavoutiteMeal});

  final List<Meal> meals;
  final String? title;
  final void Function(Meal meal) onToggleFavoutiteMeal;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsDetails(
          meal: meal,
          onToggleFavoutiteMeal: onToggleFavoutiteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        onSelectMeal: _selectMeal,
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }
    return title == null
        ? content
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content,
          );
  }
}
