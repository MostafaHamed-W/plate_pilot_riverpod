import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';

final faouriteMeasProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
  (ref) => FavouriteMealsNotifier(),
);

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  void toggleMealFavourite(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}
