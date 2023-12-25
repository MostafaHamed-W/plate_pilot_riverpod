import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plate_pilot_riverpod/providers/meals_provider.dart';
import 'package:plate_pilot_riverpod/screens/filters_screen.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactusFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};
final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(kInitialFilters);

  setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  setAllFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeMeals = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeMeals[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeMeals[Filter.lactusFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeMeals[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeMeals[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
