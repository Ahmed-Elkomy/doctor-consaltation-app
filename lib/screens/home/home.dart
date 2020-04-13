import 'package:doc_consult/provider/user_provider.dart';
import 'package:doc_consult/screens/blogs/blogSmallList.dart';
import 'package:doc_consult/screens/callscreens/pickup/pickup_layout.dart';
import 'package:doc_consult/screens/hospitalList/hospitalSmallList.dart';
import 'package:doc_consult/screens/support/support.dart';
import 'package:doc_consult/shared/customDrawer.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

///
/// #### [Description]
///
/// Home widget which is the main widget.
/// Returns the main interactive elements of the app at one place.
/// The app will ask for a surety check before exiting the application
/// which is handled by `WillPopScope` of the scaffold.
///

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserProvider userProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Refresh the user in the home page after the login, this is called after the login in the home screen after the login.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        drawer: CustomDrawer(),
        body: WillPopScope(
          onWillPop: () {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.light,
            ));
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.white,
                    title: Text(
                      "Are you sure you want to exit?",
                      textAlign: TextAlign.center,
                    ),
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    actions: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.red,
                        child: Text("Yes",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.blue,
                        child: Text("No",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () {
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                            systemNavigationBarColor: Colors.white,
                            systemNavigationBarIconBrightness: Brightness.dark,
                          ));
                          Navigator.of(context).pop(false);
                        },
                      )
                    ],
                  );
                });
          },
          child: Container(
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Heading(),
                  SearchTextInput(),
                  CategorySelector(),
                  CategoryOptions(),
                  SizedBox(
                    height: 40,
                  ),
                  HealthConcernList(),
                  SizedBox(
                    height: 30,
                  ),
                  SmallHospitalList(),
                  SizedBox(
                    height: 40,
                  ),
                  SmallBlogList()
                ],
              )),
        ),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Health Concern List widget that contains the options for
/// geneal category selection.
/// Returns a horizontal list which is hard coded in.
/// To use more than 5 options, define an array of options and use that to render
/// each element.
///
class HealthConcernList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, top: 0, right: 20, bottom: 00),
          child:
              Text("Search by health concern", style: LightTheme.boldBlackText),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
          physics: BouncingScrollPhysics(),
          child: Row(
            children: <Widget>[
              buildChoiceContainer(
                  heading: "General\nDoctor",
                  icon: SvgPicture.asset(
                    "lib/assets/svg/doctor.svg",
                    height: 40,
                  ),
                  color: Color(0xFF9ECEF9),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Support(
                              category: "General Doctor",
                              assetUrl: "lib/assets/svg/doctor.svg",
                            )));
                  }),
              buildChoiceContainer(
                  heading: "Dental\nCare",
                  icon: SvgPicture.asset(
                    "lib/assets/svg/dental.svg",
                    height: 40,
                  ),
                  color: Color(0xFFF1A7F2),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Support(
                              category: "Dental Care",
                              assetUrl: "lib/assets/svg/dental.svg",
                            )));
                  }),
            ],
          ),
        )
      ],
    );
  }

  ///
  /// #### [Description]
  ///
  /// Function that returns a widget which takes care of the touch event
  /// and serves as the item layout for the list.
  ///
  GestureDetector buildChoiceContainer(
      {String heading, Widget icon, Color color, Function onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 12, right: 30, bottom: 12),
        margin: EdgeInsets.only(right: 20),
        child: Row(
          children: <Widget>[
            Container(
              child: icon,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "$heading",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(235, 235, 235, 1),
                  spreadRadius: 0,
                  blurRadius: 10)
            ]),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Widget that returns the main list of categories displayed
/// to the user to select from.
/// Returns a horizontal list of illness with SVG assets in card
/// format.
///
class CategoryOptions extends StatefulWidget {
  @override
  _CategoryOptionsState createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> {
  final List<Map<String, String>> choiceList = [
    {"heading": "Cough", "svgUrl": "lib/assets/svg/cough.svg"},
    {"heading": "Cold", "svgUrl": "lib/assets/svg/nose.svg"},
    {"heading": "Fever", "svgUrl": "lib/assets/svg/thermometer.svg"},
    {"heading": "Skin", "svgUrl": "lib/assets/svg/rash.svg"},
    {"heading": "Allergy", "svgUrl": "lib/assets/svg/allergy.svg"},
    {"heading": "Flu", "svgUrl": "lib/assets/svg/headache.svg"},
    {"heading": "Stomach", "svgUrl": "lib/assets/svg/stomach.svg"},
    {"heading": "Eye", "svgUrl": "lib/assets/svg/eye.svg"},
    {"heading": "Bone", "svgUrl": "lib/assets/svg/bicepBones.svg"},
    {"heading": "Spine", "svgUrl": "lib/assets/svg/spine.svg"},
    {"heading": "Diabetes", "svgUrl": "lib/assets/svg/bloodCheck.svg"},
  ];

  final List<Color> colorList = [
    Color(0xaaE090C9),
    Color(0xaaFBBA7B),
    Color(0xaaF59482),
    Color(0xaaE090C9),
  ];

  int _colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: ListView.builder(
        itemCount: choiceList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index % 3 == 0 || index == 3) {
            _colorIndex = 0;
          }
          Widget item = buildChoiceContainer(
              heading: choiceList[index]["heading"],
              backgroundColor: colorList[_colorIndex],
              svgUrl: choiceList[index]["svgUrl"],
              onPress: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => Support(
                          category: choiceList[index]["heading"],
                          assetUrl: choiceList[index]["svgUrl"],
                        )));
              });
          _colorIndex += 1;
          return item;
        },
      ),
    );
  }

  ///
  /// #### [Description]
  ///
  /// Function which returns a widget that takes care of the touch event and
  /// serves as the item layout for the list.
  ///
  GestureDetector buildChoiceContainer(
      {String heading,
      Color backgroundColor,
      String svgUrl,
      Function onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 180,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$heading",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 180,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  svgUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Widget to determine for which age group is the consultation sought.
/// Best used when data is seperated for different age groups.
///
class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String selectedValue = "Adults";

  @override
  Widget build(BuildContext context) {
    final bgHighlightColor = Theme.of(context).highlightColor;
    final bgColor = Color.fromRGBO(240, 240, 240, 1);
    final textHighlightColor = Color.fromRGBO(251, 186, 123, 1);
    final textColor = Color.fromRGBO(150, 150, 150, 1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      child: Row(
        children: <Widget>[
          Text(
            "Choose\na category",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: ButtonBar(
              children: <Widget>[
                buildActionChip(
                    label: "Adults",
                    textColor: selectedValue == "Adults"
                        ? textHighlightColor
                        : textColor,
                    bgColor:
                        selectedValue == "Adults" ? bgHighlightColor : bgColor,
                    onPress: () {
                      if (selectedValue == "Adults") {
                        return;
                      } else {
                        setState(() {
                          selectedValue = "Adults";
                        });
                      }
                    }),
                buildActionChip(
                    label: "Children",
                    textColor: selectedValue == "Children"
                        ? textHighlightColor
                        : textColor,
                    bgColor: selectedValue == "Children"
                        ? bgHighlightColor
                        : bgColor,
                    onPress: () {
                      if (selectedValue == "Children") {
                        return;
                      } else {
                        setState(() {
                          selectedValue = "Children";
                        });
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  ActionChip buildActionChip(
      {String label, Color textColor, Color bgColor, Function onPress}) {
    return ActionChip(
      label: Text(
        "$label",
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: bgColor,
      onPressed: onPress,
    );
  }
}

///
/// #### [Description]
///
/// Text input which can used to search for illness, doctors, hospitals and anything you
/// want. Just plug in your functions and get going.
///
class SearchTextInput extends StatelessWidget {
  const SearchTextInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
        child: TextField(
          cursorColor: Theme.of(context).cursorColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            alignLabelWithHint: true,
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            icon: Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, bottom: 12, right: 0),
              child: Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Returns the heading text for the `Home` widget.
///
class Heading extends StatelessWidget {
  const Heading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 40),
      child: Text(
        "Online doctor\nConsultation",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
