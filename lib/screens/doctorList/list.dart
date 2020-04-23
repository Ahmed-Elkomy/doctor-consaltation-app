import 'package:doc_consult/constants/strings.dart';
import 'package:doc_consult/screens/doctorInfo/doctorInfo.dart';
import 'package:doc_consult/shared/specialityContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:doc_consult/screens/doctorList/__mockData__.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///
/// #### [Description]
///
/// Function to get the list of the doctors from the API.
///
Future<List<Map<String, dynamic>>> getDoctorList() async {
  await Future.delayed(Duration(seconds: 2));
  return DOC_LIST_DATA;
}

///
/// ### [Description]
///
/// Screen to show the list of doctors available for the selected
/// format ( call, message, video call, etc ).
///
class DoctorsList extends StatelessWidget {
  final CALL_TYPE callType;
  DoctorsList({this.callType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors List"),
        elevation: 0,
      ),
      body: ListContainer(
        callType: callType,
      ),
    );
  }
}

///
/// #### [Description]
///
/// Widget to get the list of the data and display it using a Future.
/// It waits for the Future while displaying a loading indicator and
/// show the list when the Future is complete.
///
class ListContainer extends StatefulWidget {
  final CALL_TYPE callType;
  ListContainer({this.callType});
  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer>
    with TickerProviderStateMixin {
  final Future<List<Map<String, dynamic>>> listData = getDoctorList();
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.white,
      child: FutureBuilder(
        future: listData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  controller.forward();
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, w) {
                      return FadeTransition(
                        opacity: animation,
                        child: GestureDetector(
                          onTap: () {
                            // Takes the user to the Doctor's Info page.
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => DoctorInfo(
                                      id: snapshot.data[index]['id'],
                                      name: snapshot.data[index]['name'],
                                      address: snapshot.data[index]['address'],
                                      speciality: snapshot.data[index]
                                              ['speciality']
                                          .toUpperCase(),
                                      imageUrl: snapshot.data[index]
                                          ['imageUrl'],
                                      experience: snapshot.data[index]
                                          ['experience'],
                                      price: snapshot.data[index]['price'],
                                      rating: snapshot.data[index]['rating'],
                                      callType: widget.callType,
                                    )));
                          },
                          child: DoctorListItem(
                            name: snapshot.data[index]['name'],
                            address: snapshot.data[index]['address'],
                            speciality: snapshot.data[index]['speciality']
                                .toUpperCase(),
                            imageUrl: snapshot.data[index]['imageUrl'],
                            experience: snapshot.data[index]['experience'],
                            price: snapshot.data[index]['price'],
//                            price: 1010,
                          ),
                        ),
                      );
                    },
                  );
                });
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
    );
  }
}

///
/// #### [Description]
///
/// Returns the layout widget for the list of doctors.
///
class DoctorListItem extends StatelessWidget {
  final String name;
  final String address;
  final String speciality;
  final double rating;
  final String imageUrl;
  final int experience;
  final int price;

  DoctorListItem(
      {Key key,
      this.name,
      this.address,
      this.speciality,
      this.rating,
      this.experience,
      this.price,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 35, right: 5, left: 5, bottom: 5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Color.fromRGBO(0, 137, 255, 0.15)),
        borderRadius: BorderRadius.circular(35),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(width: 8.5, color: Colors.white),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 8),
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      spreadRadius: 0,
                      blurRadius: 20),
                ]),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(240, 240, 240, 1),
              backgroundImage: NetworkImage("$imageUrl"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Dr. $name",
            style: LightTheme.boldBlackText,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "$address",
            style: LightTheme.boldGreyText,
          ),
          SizedBox(
            height: 20,
          ),
          SpecialityContainer(speciality: speciality),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              "Exp $experience Years",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                // color: Color.fromRGBO(246, 246, 246, 1),
                color: Color.fromRGBO(0, 137, 255, 0.15),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: "₹ ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                        children: [
                          TextSpan(
                              text: "0 ",
                              style: TextStyle(
//                            decoration: TextDecoration.lineThrough,
                                fontSize: 30,
                              )),
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: " ₹ ",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2.85,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                              text: "$price",
                              style: TextStyle(
//                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                              )),
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: " 100% off",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff6FB174))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
