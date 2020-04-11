import 'package:doc_consult/screens/hospitalInfo/hospitalInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:doc_consult/screens/hospitalList/__mockData__.dart';

///
/// #### [Description]
///
/// Test function to simulate the data loading
/// from the API.
/// Show a loading indicator until the data is
/// loaded.
///
Future<List<Map<String, dynamic>>> getData() async {
  await Future.delayed(Duration(seconds: 3));
  return HOSPITAL_LIST_DATA;
}

///
/// ### [Description]
///
/// Screen to fetch hospitals list. Get the data from the API.
/// Takes in a
///
/// ```dart
/// Future<List<Map<String, dynamic>>>
/// ```
///
/// and builds a list based on the data. Animates each item with the animation
/// object (which can be changed anytime)
///
class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen>
    with TickerProviderStateMixin {
  final Future<List<Map<String, dynamic>>> postData = getData();
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Hospitals List"),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: postData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  controller.forward();
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, Widget w) {
                      return FadeTransition(
                        opacity: animation,
                        child: HospitalListItem(
                          id: snapshot.data[i]['id'],
                          name: snapshot.data[i]['name'],
                          imageUrl: snapshot.data[i]['imageUrl'],
                          address: snapshot.data[i]['address'],
                          rating: snapshot.data[i]['rating'],
                          contact: snapshot.data[i]['contact'],
                          email: snapshot.data[i]['email'],
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                  child: SpinKitWave(
                color: Colors.black87,
                type: SpinKitWaveType.center,
                controller: AnimationController(
                    vsync: this, duration: Duration(milliseconds: 800)),
                size: 30,
              ));
            }
          },
        ),
      ),
    );
  }
}

///
/// #### [Description]
///
/// Widget that contains the information about the hospital.
/// Clicking on it will navigate to the hospital info page.
///
class HospitalListItem extends StatelessWidget {
  final dynamic id, contact;
  final String name, address, imageUrl, rating, email;

  final TextStyle _infoText = TextStyle(
      fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w600);
  final double iconSize = 16;

  HospitalListItem(
      {Key key,
      this.id,
      this.name,
      this.address,
      this.imageUrl,
      this.contact,
      this.rating,
      this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          return HospitalInfoScreen(
            name: name,
            imageUrl: imageUrl,
            id: id,
            contact: contact,
            email: email,
            address: address
          );
        }));
      },
      child: Container(
        width: 250,
        height: 400,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(235, 235, 235, 1),
                  spreadRadius: 0,
                  blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$name",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red[400],
                        size: iconSize,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "$address",
                          style: _infoText,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        color: Colors.green[400],
                        size: iconSize,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "$contact",
                          style: _infoText,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.blue[400],
                        size: iconSize,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "$email",
                          style: _infoText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
