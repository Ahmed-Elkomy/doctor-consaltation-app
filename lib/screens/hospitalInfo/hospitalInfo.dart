import 'package:doc_consult/screens/hospitalInfo/__mockData__.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///
/// #### [Description]
///
/// Returns the information about the hospital or clinic on the screen
/// Shows a loading indicator while the data is being loaded.
///
class HospitalInfoScreen extends StatefulWidget {
  final dynamic id, contact;
  final String imageUrl, name, email, address;

  HospitalInfoScreen(
      {Key key,
      @required this.id,
      @required this.imageUrl,
      @required this.name,
      this.contact,
      this.email,
      this.address})
      : super(key: key);

  @override
  _HospitalInfoScreenState createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  final double _borderRadius = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "${widget.imageUrl}",
                    ),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: 330,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  color: Colors.white),
            ),
          ),
          ScrollView(
            borderRadius: _borderRadius,
            name: widget.name,
            email: widget.email,
            contact: widget.contact,
            address: widget.address,
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: EdgeInsets.all(15),
            height: AppBar().preferredSize.height,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

///
/// #### [Description]
///
/// Helper widget for the main screen.
/// Returns the data in a widget which has the scrolling effect and contains other
/// widgets that are used to display on the screen.
/// Server as a parent widget for scrolling other child widgets which hold information.
///
class ScrollView extends StatefulWidget {
  final dynamic id, contact;
  final String name, email, address;

  ScrollView({
    Key key,
    @required double borderRadius,
    @required this.name,
    this.id,
    this.contact,
    this.email,
    this.address,
  })  : _borderRadius = borderRadius,
        super(key: key);

  final double _borderRadius;

  @override
  _ScrollViewState createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView>
    with SingleTickerProviderStateMixin {
  // Function to get Hospital Info
  static Future<Map<String, dynamic>> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return HOSPITAL_INFO_DATA;
  }

  final Future<Map<String, dynamic>> hospitalData = getData();

  final TextStyle _labelTextStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black26);
  final TextStyle _infoTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(80, 80, 80, 1));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget._borderRadius),
                    topRight: Radius.circular(widget._borderRadius)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: Offset(0, -10))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.name}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address:",
                  style: _labelTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                // Text("${widget.address}",style: _infoTextStyle),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.red[400],
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "${widget.address}",
                        style: _infoTextStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Contact:", style: _labelTextStyle),
                SizedBox(
                  height: 5,
                ),
                // Text("${widget.contact}",style: _infoTextStyle),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      color: Colors.green[400],
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "${widget.contact}",
                        style: _infoTextStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Email:", style: _labelTextStyle),
                SizedBox(
                  height: 5,
                ),
                // Text("${widget.email}",style: _infoTextStyle),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.blue[400],
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "${widget.email}",
                        style: _infoTextStyle,
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 80,
                  thickness: 2,
                  color: Color.fromRGBO(230, 230, 230, 1),
                ),
                FutureBuilder(
                  future: hospitalData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "About:",
                            style: _infoTextStyle,
                          ),
                          AboutSection(about: snapshot.data['about']),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Specialities:",
                            style: _infoTextStyle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SpecialitiesScetion(
                              data: snapshot.data['specialities']),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Doctors:",
                            style: _infoTextStyle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DoctorsListSection(
                              data: snapshot.data['doctorsList']),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                  child: Text(
                                "Book an appointment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          )
                        ],
                      );
                    } else {
                      return SizedBox(
                          height: 100,
                          child: SpinKitWave(
                            color: Colors.black87,
                            type: SpinKitWaveType.center,
                            controller: AnimationController(
                                vsync: this,
                                duration: Duration(milliseconds: 800)),
                            size: 30,
                          ));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///
/// #### [Description]
///
/// Returns the information about the hospital
///
class AboutSection extends StatelessWidget {
  final String about;
  const AboutSection({
    Key key,
    this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: LightTheme.shadowColor,
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Text(
        "$about",
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Returns the `specialities` of the hospital in tile layout
///
class SpecialitiesScetion extends StatelessWidget {
  final data;
  const SpecialitiesScetion({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...data
            .map((item) => Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: LightTheme.shadowColor,
                            spreadRadius: 2,
                            blurRadius: 5)
                      ]),
                  child: Text(item),
                ))
            .toList()
      ],
    );
  }
}

///
/// #### [Description]
///
/// Returns the doctors list in a horizontal format.
///
class DoctorsListSection extends StatelessWidget {
  final data;
  const DoctorsListSection({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => DoctorListItem(
          name: data[i]['name'],
          imageUrl: data[i]['imageUrl'],
          speciality: data[i]['speciality'],
        ),
        itemCount: data.length,
      ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final String name;
  final String speciality;
  final String imageUrl;

  DoctorListItem({Key key, this.name, this.speciality, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Color.fromRGBO(0, 137, 255, 0.15)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(width: 8.5, color: Colors.white),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 8),
                      color: LightTheme.shadowColor,
                      spreadRadius: 1,
                      blurRadius: 10),
                ]),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(240, 240, 240, 1),
              backgroundImage: NetworkImage("$imageUrl"),
            ),
          ),
          Flexible(
            child: Text(
              "Dr. $name",
              textAlign: TextAlign.center,
              style: LightTheme.boldBlackText,
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 137, 255, 0.15),
                  borderRadius: BorderRadius.circular(8)),
              child: Text("$speciality",
              textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Color.fromRGBO(0, 137, 255, 1),
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
