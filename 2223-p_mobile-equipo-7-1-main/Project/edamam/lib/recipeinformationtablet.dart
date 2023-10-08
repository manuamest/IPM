import 'package:edamam/edamam.dart';
import 'package:edamam/resultstablet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'hometablet.dart';

class RecipeInformationT extends StatefulWidget {
  Recipe recipe;
  String? search;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;
  RecipeInformationT(this.recipe, this.search, this.filters, this.meals,
      this.calorieMin, this.calorieMax, this.filterColors, this.mealColors,
      {Key? key})
      : super(key: key);

  @override
  State<RecipeInformationT> createState() => _RecipeInformationTState(recipe,
      search, filters, meals, calorieMin, calorieMax, filterColors, mealColors);
}

class _RecipeInformationTState extends State<RecipeInformationT> {
  Recipe recipe;
  String? search;
  List<String> filters;
  List<String> meals;
  double calorieMin;
  double calorieMax;
  List<Color> filterColors;
  List<Color> mealColors;

  _RecipeInformationTState(this.recipe, this.search, this.filters, this.meals,
      this.calorieMin, this.calorieMax, this.filterColors, this.mealColors);

  List<String> filterNames = [];

  List<String> mealTypes = [];

  final TextEditingController inputBusqueda = TextEditingController();
  String listFormatting(List<String> lista) {
    String finalString = " ";
    for (String x in lista) {
      if (finalString == " ") {
        finalString = x;
      } else {
        finalString = finalString + "\n" + x;
      }
    }
    return finalString;
  }

  Widget informationBodyCreator() {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    return SizedBox(
      width: maxwidth,
      height: maxheight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Spacer(),
            Container(
              height: maxheight * 0.5,
              width: maxwidth * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(recipe.image!), fit: BoxFit.fill),
                  color: Colors.teal.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
            const Spacer(),
            SizedBox(
              height: maxheight * 0.7,
              width: maxwidth * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        width: maxwidth * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          recipe.label!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    width: maxwidth * 0.4,
                    color: Colors.teal.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("CALORIES",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade400,
                                  letterSpacing: 2),
                            )),
                        Text(recipe.calories!.toInt().toString(),
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade200,
                                  letterSpacing: 2),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: maxwidth * 0.4,
                    color: Colors.teal.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("DIET",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade400,
                                  letterSpacing: 2),
                            )),
                        Text(listFormatting(recipe.dietLabels!),
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade200,
                                  letterSpacing: 2),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: maxwidth * 0.4,
                    color: Colors.teal.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("MEAL TYPE",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade400,
                                  letterSpacing: 2),
                            )),
                        Text(listFormatting(recipe.mealType!),
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade200,
                                  letterSpacing: 2),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: maxwidth * 0.4,
                    color: Colors.teal.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("EMISIONS",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade400,
                                  letterSpacing: 2),
                            )),
                        Text(recipe.totalCO2Emissions!.toInt().toString(),
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.teal.shade200,
                                  letterSpacing: 2),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: maxwidth * 0.4,
                    color: Colors.teal.shade100,
                  ),
                  Center(
                    child: Text("INGRIDIENTS",
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.teal.shade400,
                              letterSpacing: 2),
                        )),
                  ),
                  Container(
                    width: maxwidth * 0.4,
                    height: maxheight * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal.shade300),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: recipe.ingredients!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: Row(
                              children: [
                                Text("$index->   ",
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.teal.shade300,
                                          letterSpacing: 2),
                                    )),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle:
                                        const StrutStyle(fontSize: 15.0),
                                    text: TextSpan(
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.teal.shade200,
                                              letterSpacing: 2),
                                        ),
                                        text: recipe.ingredients![index]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

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
    SfRangeValues _values = SfRangeValues(calorieMin, calorieMax);
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
                                                hintText: search,
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
                                                            this.filterColors,
                                                            this.mealColors),
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
      body: informationBodyCreator(),
    );
  }
}
