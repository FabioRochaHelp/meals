import 'package:flutter/material.dart';
import '../models/category.dart';
import '../components/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  CategoryMealsScreen(this.meals);
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(category.title),
          centerTitle: true,
        ),
        body: Center(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(categoryMeals[index]);
            },
            itemCount: categoryMeals.length,
          ),
        ));
  }
}
