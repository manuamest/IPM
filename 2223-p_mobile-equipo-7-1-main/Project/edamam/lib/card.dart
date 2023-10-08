import 'dart:math';

import 'package:edamam/recipeinformation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edamam.dart';

class CardRecipe extends StatelessWidget {
  Recipe recipe;

  String? search;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;
  CardRecipe(this.recipe, this.search, this.filters, this.meals,
      this.calorieMin, this.calorieMax, this.filterColors, this.mealColors,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeInformation(
                recipe,
                search,
                filters,
                meals,
                calorieMin,
                calorieMax,
                filterColors,
                mealColors,
              ),
            ));
      },
      child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 250,
          width: maxwidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(recipe.image!), fit: BoxFit.fill),
              color: Colors.teal.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: maxwidth,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade300,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    recipe.label!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                  )),
            ],
          )),
    );
  }
}
