import 'package:flutter/material.dart';
import './meal_item.dart';
import './models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {

  final List<Meal> availableMeal;
  CategoryMealsScreen(this.availableMeal);
  @override
  Widget build(BuildContext context) {
    final routeAgrs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final categoryTitle = routeAgrs['title'];
    final Color color = (routeAgrs['color']);
    final categoryMeals =availableMeal
        .where((element) => element.categories.contains(routeAgrs['id']))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
          backgroundColor: color,
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id:categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
            );
          },
          itemCount: categoryMeals.length,
        ));
  }
}
