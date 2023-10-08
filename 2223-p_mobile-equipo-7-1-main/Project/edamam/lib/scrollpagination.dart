import 'package:edamam/card.dart';
import 'package:edamam/edamam.dart';
import 'package:flutter/material.dart';

class ScrollPagination extends StatefulWidget {
  String query;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;
  ScrollPagination(this.query, this.filters, this.meals, this.calorieMin,
      this.calorieMax, this.filterColors, this.mealColors,
      {Key? key})
      : super(key: key);

  @override
  State<ScrollPagination> createState() => _ScrollPaginationState(
      query, filters, meals, calorieMin, calorieMax, filterColors, mealColors);
}

class _ScrollPaginationState extends State<ScrollPagination> {
  String? query;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;
  _ScrollPaginationState(this.query, this.filters, this.meals, this.calorieMin,
      this.calorieMax, this.filterColors, this.mealColors);

  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 20;
  late List<Recipe> _posts;
  final int _nextPageTrigger = 1;
  late RecipeBlock? bloqueRecetas;

  List<Recipe> filterCalories(List<Recipe> lista) {
    List<Recipe> result = [];
    for (Recipe recipe in lista) {
      if (recipe.calories! < calorieMax && recipe.calories! > calorieMin) {
        result.add(recipe);
      }
    }
    return result;
  }

  Future<void> fetchData(String myquery) async {
    List<Recipe> toadd = [];
    try {
      bloqueRecetas = await search_recipes(myquery);
      if (bloqueRecetas!.recipes != null) {
        for (Recipe recipe in bloqueRecetas!.recipes!) {
          if (filters.isNotEmpty && meals.isNotEmpty) {
            if (filters
                .any((element) => recipe.dietLabels!.contains(element))) {
              if (meals.any((element) => recipe.mealType!.contains(element))) {
                toadd.add(recipe);
              }
            }
          } else {
            if (filters.isNotEmpty) {
              if (filters
                  .any((element) => recipe.dietLabels!.contains(element))) {
                toadd.add(recipe);
              }
            } else if (meals.isNotEmpty) {
              if (meals.any((element) => recipe.mealType!.contains(element))) {
                toadd.add(recipe);
              }
            } else {
              toadd.add(recipe);
            }
          }
        }
        toadd = filterCalories(toadd);
      }

      setState(() {
        _isLastPage = bloqueRecetas!.count < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _posts.addAll(toadd);
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorMessage() {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("An error ocurred"),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _loading = true;
                _error = false;
                fetchData(query!);
              });
            },
            child: const Text("RETRY"))
      ]),
    );
  }

  Widget refresh() {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Can't find more recipes"),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _loading = true;
                _error = false;
                fetchData(query!);
              });
            },
            child: const Text("RETRY"))
      ]),
    );
  }

  Widget buildPaginationView() {
    if (_posts.isEmpty) {
      if (_loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Center(
          child: errorMessage(),
        );
      }
    }
    return ListView.builder(
      itemCount: _posts.length + (_isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == _posts.length - _nextPageTrigger) {
          if (bloqueRecetas!.nextBlock != null) {
            fetchData(bloqueRecetas!.nextBlock!);
          }
        }
        if (index == _posts.length) {
          if (_error) {
            return Center(
              child: refresh(),
            );
          } else {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
          }
        }
        final Recipe receta = _posts[index];
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: CardRecipe(receta, query, filters, meals, calorieMin,
                calorieMax, filterColors, mealColors));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _posts = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData(query!);
  }

  @override
  Widget build(BuildContext context) {
    return buildPaginationView();
  }
}
