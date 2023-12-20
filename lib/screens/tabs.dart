import 'package:flutter/material.dart';
import 'package:plate_pilot_riverpod/data/dummy_data.dart';
import 'package:plate_pilot_riverpod/models/meal.dart';
import 'package:plate_pilot_riverpod/screens/categories.dart';
import 'package:plate_pilot_riverpod/screens/filters_screen.dart';
import 'package:plate_pilot_riverpod/screens/meals.dart';
import 'package:plate_pilot_riverpod/widgets/main_drawer.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactusFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _activeIndex = 0;
  String _activeTitle = 'Categories';
  bool isFavourite = false;
  final List<Meal> _favoutiteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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
        toggleMealSnackBar('removed');
      });
    } else {
      setState(() {
        _favoutiteMeals.add(meal);
        toggleMealSnackBar('added');
      });
    }
  }

  void toggleMealSnackBar(String title) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(title),
      ),
    );
  }

  void selectDrawerScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      var result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => Filters(
            selectedFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactusFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavoutiteMeal: _toggleMealFavoutiteState,
      availableMeals: availableMeals,
    );
    if (_activeIndex == 1) {
      activeScreen = Meals(
        meals: _favoutiteMeals,
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
