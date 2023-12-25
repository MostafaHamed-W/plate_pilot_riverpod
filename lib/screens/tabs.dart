import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';
import 'package:plate_pilot_riverpod/providers/favourite_meals_provider.dart';
import 'package:plate_pilot_riverpod/providers/filters_provider.dart';
import 'package:plate_pilot_riverpod/screens/categories.dart';
import 'package:plate_pilot_riverpod/screens/filters_screen.dart';
import 'package:plate_pilot_riverpod/screens/meals.dart';
import 'package:plate_pilot_riverpod/widgets/main_drawer.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int _activeIndex = 0;
  String _activeTitle = 'Categories';
  bool isFavourite = false;
  final List<Meal> _favoutiteMeals = [];

  void _selectPage(index) {
    setState(() {
      _activeIndex = index;
      _activeTitle = 'Favourite';
    });
  }

  void _toggleMealFavoutiteState(Meal meal) {
    final isExisting = _favoutiteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoutiteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favoutiteMeals.add(meal);
      });
    }
  }

  void selectDrawerScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const Filters(),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      onToggleFavoutiteMeal: _toggleMealFavoutiteState,
      availableMeals: availableMeals,
    );
    if (_activeIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activeScreen = Meals(
        meals: favouriteMeals,
        onToggleFavoutiteMeal: _toggleMealFavoutiteState,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(_activeTitle)),
      drawer: MainDrawer(
        onSelectScreen: selectDrawerScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _activeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          )
        ],
      ),
      body: activeScreen,
    );
  }
}
