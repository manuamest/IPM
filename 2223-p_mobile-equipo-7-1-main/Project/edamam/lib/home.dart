import 'package:edamam/results.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SfRangeValues _values = const SfRangeValues(500.0, 1500.0);
  List<String> _filters = [];
  List<String> filterNames = [];
  List<String> _meals = [];
  List<String> mealTypes = [];
  List<Color> filterColors = [];
  List<Color> mealColors = [];
  final TextEditingController inputBusqueda = TextEditingController();

  Widget chipMealCreator(int position, String icon) {
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
        selected: _meals.contains(mealTypes.elementAt(position)),
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
          setState(() {
            if (selected) {
              _meals.add(mealTypes.elementAt(position));
              mealColors[position] = Colors.white;
            } else {
              _meals.removeWhere(
                  (String element) => element == mealTypes.elementAt(position));
              mealColors[position] = Colors.teal.shade300;
            }
          });
        });
  }

  Widget chipFilterCreator(int position, String icon) {
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
        selected: _filters.contains(filterNames.elementAt(position)),
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
          setState(() {
            if (selected) {
              _filters.add(filterNames.elementAt(position));
              filterColors[position] = Colors.white;
            } else {
              _filters.removeWhere((String element) =>
                  element == filterNames.elementAt(position));
              filterColors[position] = Colors.teal.shade300;
            }
          });
        });
  }

  Widget bodyContent() {
    Widget myWidget = chipFilterCreator(0, "📊");
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    return SizedBox(
      height: maxheight,
      child: Center(
        child: ListView(
          children: [
            //INICIO CABECERA
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: maxheight * 0.3,
              width: maxwidth,
              decoration: BoxDecoration(
                color: Colors.teal.shade400,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.teal.shade300, Colors.teal.shade600]),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    "images/icon.png",
                    height: maxheight * 0.1,
                    width: maxwidth,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: maxwidth * 0.8,
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
                              hoverColor: Colors.teal.shade100,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.teal.shade100),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              hintText: "Search",
                              hintStyle: const TextStyle(color: Colors.white)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Results(
                                      inputBusqueda.text,
                                      _filters,
                                      _meals,
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
                  const Spacer()
                ],
              ),
            ),
            //FIN CABECERA
            //INICIO CUERPO

            Text("CALORIES",
                textAlign: TextAlign.center,
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
                setState(() {
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
                    style: TextStyle(color: Colors.teal.shade200)),
                const Spacer(),
                Text(
                  "TO",
                  style: TextStyle(color: Colors.teal.shade200),
                ),
                const Spacer(),
                Text(_values.end.toString(),
                    style: TextStyle(color: Colors.teal.shade200)),
                const Spacer()
              ],
            ),

            Text("DIET",
                textAlign: TextAlign.center,
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
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myWidget,
                  const SizedBox(
                    width: 15,
                  ),
                  chipFilterCreator(1, "🥦"),
                ],
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              chipFilterCreator(2, "💪"),
              const SizedBox(
                width: 15,
              ),
              chipFilterCreator(3, "🥑"),
            ]),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                chipFilterCreator(4, "🥗"),
                const SizedBox(
                  width: 15,
                ),
                chipFilterCreator(5, "🧂"),
              ]),
            ),

            Text("MEAL TYPE",
                textAlign: TextAlign.center,
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
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  chipMealCreator(0, "🌅"),
                  const SizedBox(
                    width: 15,
                  ),
                  chipMealCreator(2, "🕛"),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  chipMealCreator(1, "🌕"),
                  const SizedBox(
                    width: 15,
                  ),
                  chipMealCreator(3, "🥨"),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  chipMealCreator(4, "🍵"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
    print(maxwidth);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: bodyContent(),
    );
  }
}
