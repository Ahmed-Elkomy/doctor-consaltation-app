import 'package:doc_consult/screens/doctorList/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// #### [Description]
///
/// Screen which allows the users to choose from the different format
/// to connect to the doctor.
/// Fetch the doctors list based on the choice of the user for instant connection.
///
class Support extends StatelessWidget {
  final String category;
  final String assetUrl;

  Support({this.category, this.assetUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Choose consultation format"),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 13) {
            Navigator.pop(context);
          }
        },
        child: Container(
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Header(
                  assetUrl: assetUrl,
                ),
                DisplayCategory(category: category),
                SizedBox(
                  height: 40,
                ),
                ChoiceContainer(
                  heading: "Chat",
                  subHeading:
                      "\nWhen you are busy to talk you should pick this option",
                  icon: SvgPicture.asset(
                    "lib/assets/svg/support.svg",
                    height: 40,
                  ),
                  color: Color(0xFF9ECEF9),
                ),
                ChoiceContainer(
                  heading: "Call",
                  subHeading: "\nTalk to a doctor on the voice call",
                  icon: SvgPicture.asset(
                    "lib/assets/svg/contact.svg",
                    height: 40,
                  ),
                  color: Color(0xFF9ECEF9),
                ),
                ChoiceContainer(
                  heading: "Video Call",
                  subHeading: "\nTalk to a doctor in a video call",
                  icon: SvgPicture.asset(
                    "lib/assets/svg/video.svg",
                    height: 40,
                  ),
                  color: Color(0xFF9ECEF9),
                ),
              ],
            )),
      ),
    );
  }
}

class DisplayCategory extends StatelessWidget {
  const DisplayCategory({
    Key key,
    @required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 40),
      child: RichText(
        text: TextSpan(
            text: "Category: ",
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                  text: "$category",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0))
            ]),
      ),
    );
  }
}

class ChoiceContainer extends StatelessWidget {
  const ChoiceContainer({
    Key key,
    @required this.heading,
    @required this.subHeading,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  final String heading;
  final String subHeading;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => DoctorsList()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 12, right: 30, bottom: 12),
        margin: EdgeInsets.all(10),
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
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: "$heading",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: "$subHeading",
                        style: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
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


class Header extends StatelessWidget {
  final String assetUrl;
  const Header({
    Key key,
    this.assetUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SvgPicture.asset(
        assetUrl,
        height: 200,
        width: 100,
      ),
    );
  }
}
