import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas'),
        centerTitle: true,
      ),
      body: Text('Receitas por Categoria'),
    );
  }
}
