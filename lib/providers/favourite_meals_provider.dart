import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
  (ref) => FavouriteMealsNotifier(),
);

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  String toggleMealFavourite(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
      return 'removed';
    } else {
      state = [...state, meal];
      return 'added';
    }
  }
}
