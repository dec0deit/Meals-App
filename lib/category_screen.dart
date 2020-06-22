import 'package:flutter/material.dart';
import './dummy.dart';
import './categoryItem.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: GridView(
        padding:const EdgeInsets.all(10),
        children: DUMMY_CATEGORIES.map((item) {
          return CategoryItem(item.id,item.title, item.color);
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.9,
        ),
      ),
    );
  }
}
