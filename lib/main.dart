import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'models/settings.dart';

import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settngs) {
    setState(() {
      this.settings = settngs;

      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settngs.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settngs.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settngs.isVegan && !meal.isVegan;
        final filterVegetarian = settngs.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos cozinhar?',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.pink,
              secondary: Colors.amber,
            ),
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: ((ctx) =>
            CategoryMealsScreen(_availableMeals)),
        AppRoutes.MEAL_DETAIL: ((ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite)),
        AppRoutes.SETTINGS: ((ctx) => SettingsScreen(settings, _filterMeals)),
      },
    );
  }
}
