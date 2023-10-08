import 'dart:math';

import 'package:edamam/card.dart';
import 'package:edamam/hometablet.dart';
import 'package:edamam/scrollpaginationtablet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ResultsT extends StatefulWidget {
  String? search;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;

  ResultsT(this.search, this.filters, this.meals, this.calorieMin,
      this.calorieMax, this.filterColors, this.mealColors,
      {Key? key})
      : super(key: key);

  @override
  State<ResultsT> createState() => _ResultsTState(
      search, filters, meals, calorieMin, calorieMax, filterColors, mealColors);
}

class _ResultsTState extends State<ResultsT> {
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;
  String? search;
  _ResultsTState(this.search, this.filters, this.meals, this.calorieMin,
      this.calorieMax, this.filterColors, this.mealColors);

  SfRangeValues _values = const SfRangeValues(500, 600);

  List<String> filterNames = [];

  List<String> mealTypes = [];

  final TextEditingController inputBusqueda = TextEditingController();

  Widget chipMealCreator(
      int position, String icon, void Function(void Function()) f) {
    return FilterChip(
        showCheckmark: false,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.teal.shade300, width: 2),
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            icon,
          ),
        ),
        selected: meals.contains(mealTypes.elementAt(position)),
        selectedColor: Colors.teal.shade300,
        label: Text(mealTypes.elementAt(position),
            style: GoogleFonts.robotoCondensed(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: mealColors[position],
                  letterSpacing: 2),
            )),
        onSelected: (bool selected) {
          f(() {
            if (selected) {
              meals.add(mealTypes.elementAt(position));
              mealColors[position] = Colors.white;
            } else {
              meals.removeWhere(
                  (String element) => element == mealTypes.elementAt(position));
              mealColors[position] = Colors.teal.shade300;
            }
          });
        });
  }

  Widget chipFilterCreator(
      int position, String icon, void Function(void Function()) f) {
    return FilterChip(
        showCheckmark: false,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.teal.shade300, width: 2),
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            icon,
          ),
        ),
        selected: filters.contains(filterNames.elementAt(position)),
        selectedColor: Colors.teal.shade300,
        label: Text(
          filterNames.elementAt(position),
          style: GoogleFonts.robotoCondensed(
            textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: filterColors[position],
                letterSpacing: 2),
          ),
        ),
        onSelected: (bool selected) {
          f(() {
            if (selected) {
              filters.add(filterNames.elementAt(position));
              filterColors[position] = Colors.white;
            } else {
              filters.removeWhere((String element) =>
                  element == filterNames.elementAt(position));
              filterColors[position] = Colors.teal.shade300;
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    _values = SfRangeValues(calorieMin, calorieMax);
    for (int i = 0; i < 6; i++) {
      filterColors.add(Colors.teal.shade300);
    }
    for (int i = 0; i < 5; i++) {
      mealColors.add(Colors.teal.shade300);
    }

    //PREPARING FILTER DATASET
    filterNames.add("Balanced");
    filterNames.add("High-Fiber");
    filterNames.add("High-Protein");
    filterNames.add("Low-Carb");
    filterNames.add("Low-Fat");
    filterNames.add("Low-Sodium");

    //PREPARING MEAL TYPES DATASET
    mealTypes.add("Breakfast");
    mealTypes.add("Dinner");
    mealTypes.add("Lunch");
    mealTypes.add("Snack");
    mealTypes.add("Teatime");

    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal.shade300,
        title: Image.asset(
          "images/icon.png",
          height: 40,
          width: maxwidth,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeT()));
              },
              icon: const Icon(
                Icons.home_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setStaate) {
                        return ListView(
                          children: [
                            SizedBox(
                                height: maxheight * 0.8,
                                width: maxwidth,
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: maxheight * 0.15,
                                    width: maxwidth,
                                    decoration: BoxDecoration(
                                      color: Colors.teal.shade400,
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.teal.shade300,
                                            Colors.teal.shade600
                                          ]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: maxwidth * 0.94,
                                          child: TextFormField(
                                            controller: inputBusqueda,
                                            style: GoogleFonts.robotoCondensed(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  letterSpacing: 0),
                                            ),
                                            decoration: InputDecoration(
                                                hoverColor:
                                                    Colors.teal.shade100,
                                                enabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colors.white),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colors
                                                            .teal.shade100),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                hintText: "Search",
                                                hintStyle: const TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultsT(
                                                            inputBusqueda.text,
                                                            filters,
                                                            meals,
                                                            _values.start * 1.0,
                                                            _values.end * 1.0,
                                                            filterColors,
                                                            mealColors),
                                                  ));
                                            },
                                            icon: const Icon(
                                              Icons.search_rounded,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text("CALORIES",
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            color: Colors.teal.shade400,
                                            letterSpacing: 2),
                                      )),
                                  SfRangeSlider(
                                    activeColor: Colors.teal.shade400,
                                    values: _values,
                                    onChanged: (SfRangeValues newV) {
                                      setStaate(() {
                                        _values = newV;
                                      });
                                    },
                                    min: 0,
                                    max: 2000,
                                    interval: 20,
                                    stepSize: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text(_values.start.toString(),
                                          style: TextStyle(
                                              color: Colors.teal.shade200)),
                                      const Spacer(),
                                      Text(
                                        "TO",
                                        style: TextStyle(
                                            color: Colors.teal.shade200),
                                      ),
                                      const Spacer(),
                                      Text(_values.end.toString(),
                                          style: TextStyle(
                                              color: Colors.teal.shade200)),
                                      const Spacer()
                                    ],
                                  ),
                                  Text("DIET",
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            color: Colors.teal.shade400,
                                            letterSpacing: 5),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        chipFilterCreator(0, "📊", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        chipFilterCreator(1, "🥦", setStaate),
                                      ],
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        chipFilterCreator(2, "💪", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        chipFilterCreator(3, "🥑", setStaate),
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          chipFilterCreator(4, "🥗", setStaate),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          chipFilterCreator(5, "🧂", setStaate),
                                        ]),
                                  ),
                                  Text("MEAL TYPE",
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            color: Colors.teal.shade400,
                                            letterSpacing: 5),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        chipMealCreator(0, "🌅", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        chipMealCreator(2, "🕛", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        chipMealCreator(1, "🌕", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        chipMealCreator(3, "🥨", setStaate),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        chipMealCreator(4, "🍵", setStaate),
                                      ],
                                    ),
                                  ),
                                ])),
                          ],
                        );
                      });
                    });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SizedBox(
          height: maxheight,
          width: maxwidth,
          child: ScrollPaginationT(search!, filters, meals, calorieMin,
              calorieMax, filterColors, mealColors)),
    );
  }
}
