import 'package:flutter/material.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabscreen.dart';
import './category_meal_screen.dart';
import './screens/filters.dart';
import './models/meal.dart';
import './dummy.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> favourite_meals=[];

  void toggleFavourites(String MealId) {
    if(favourite_meals==null){
      setState(() {
        favourite_meals=DUMMY_MEALS.where((element) => element.id == MealId).toList();
        });
    return ;
    }

    final index = favourite_meals.indexWhere((element) => element.id == MealId);
    if (index >= 0) {
      setState(() {
        favourite_meals.removeAt(index);
      });
    } else {
      setState(() {
        favourite_meals.add(
          DUMMY_MEALS.firstWhere((element) => element.id == MealId),
        );
      });
    }
  }

  List<Meal> _availableMeals = DUMMY_MEALS.where((element) {
    ///...
    if (_filters['gluten'] && !element.isGlutenFree) {
      return false;
    }
    if (_filters['lactose'] && !element.isLactoseFree) {
      return false;
    }
    if (_filters['vegan'] && !element.isVegan) {
      return false;
    }
    if (_filters['vegetarian'] && !element.isVegetarian) {
      return false;
    }
    return true;
  }).toList();

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
    });
  }

  bool isMealFavourite(String id) {
    if(favourite_meals==null)
    return false;
    return favourite_meals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

 debugShowCheckedModeBanner: false,
        title: 'Meals App',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 234, 229, 0.9999),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontFamily: "RobotoCondesed",
                  fontWeight: FontWeight.bold,
                ))),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(favourite_meals),
          '/Category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(toggleFavourites, isMealFavourite),
          Filter.routeName: (ctx) => Filter(_filters, _setFilters),
        });
  }
}
