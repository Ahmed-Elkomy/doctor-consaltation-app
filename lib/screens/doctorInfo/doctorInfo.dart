import 'package:doc_consult/shared/specialityContainer.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doc_consult/screens/doctorInfo/__mockData__.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DoctorInfo extends StatefulWidget {
  final dynamic id;
  final String name;
  final String address;
  final String speciality;
  final double rating;
  final String imageUrl;
  final int experience;
  final int price;

  DoctorInfo(
      {Key key,
      @required this.id,
      this.name,
      this.address,
      this.speciality,
      this.rating,
      this.imageUrl,
      this.experience,
      this.price})
      : super(key: key);

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo>
    with SingleTickerProviderStateMixin {
  // Function to get data from the API.
  static Future<Map<String, dynamic>> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return DOCTOR_INFO;
  }

  final Future<Map<String, dynamic>> doctorInfo = getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Dr. ${widget.name}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${widget.address}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SpecialityContainer(
                                  speciality: widget.speciality,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RowItem(lable: "Experience", value: "5 years"),
                          RowItem(lable: "Rating", value: 4.5),
                          RowItem(lable: "Appointments", value: "2.5K"),
                          RowItem(lable: "Likes", value: "12K"),
                          RowItem(lable: "Recommended", value: "256"),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: doctorInfo,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            AboutContainer(
                              data: snapshot.data['about'],
                            ),
                            ReviewContainer(
                              data: snapshot.data['reviews'],
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
          ),
          Positioned(
            bottom: 0,
            child: BlueButton(
              lable: "Connect Now",
            ),
          )
        ]));
  }
}

class BlueButton extends StatelessWidget {
  final String lable;
  final Function onPress;
  final bool isOutline;

  const BlueButton({
    Key key,
    this.lable,
    this.onPress,
    this.isOutline = false,
  }) : super(key: key);

  const BlueButton.outline({
    Key key,
    this.lable,
    this.onPress,
    this.isOutline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isOutline ? Colors.transparent : Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Center(
              child: Text(
            "$lable",
            style: TextStyle(
                color: isOutline ? Colors.blue : Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
          decoration: BoxDecoration(
              color: isOutline ? Colors.white : Colors.blue,
              border: isOutline
                  ? Border.all(width: 3, color: Colors.blue)
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class ReviewContainer extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ReviewContainer({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Reviews",
                style: LightTheme.doctorInfoHeading,
              ),
              data.length < 5
                  ? Text('')
                  : InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                height:
                                    MediaQuery.of(context).size.height - 150,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 245, 245, 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: BottomSheet(
                                  onClosing: () {},
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            "All Reviews",
                                            style: LightTheme.doctorInfoHeading,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              240,
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: data.length,
                                            itemBuilder: (context, i) {
                                              return ReviewRowContainer(
                                                username: data[i]['username'],
                                                comment: data[i]['comment'],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            });
                      },
                      child: Text("See all",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38)),
                    )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 420,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.length < 5 ? data.length : 5,
                itemBuilder: (context, i) {
                  return ReviewRowContainer(
                    username: data[i]['username'],
                    comment: data[i]['comment'],
                  );
                },
              )),
          BlueButton.outline(
            lable: "Write a review",
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class ReviewRowContainer extends StatelessWidget {
  final String username, comment;

  const ReviewRowContainer({
    Key key,
    this.username,
    this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$username",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$comment",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class AboutContainer extends StatelessWidget {
  final String data;
  const AboutContainer({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "About",
            style: LightTheme.doctorInfoHeading,
          ),
          SizedBox(
            height: 10,
          ),
          Text("$data")
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String lable;
  final dynamic value;
  const RowItem({Key key, this.lable, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$lable",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black38)),
            SizedBox(
              height: 10,
            ),
            Text(
              "$value",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
