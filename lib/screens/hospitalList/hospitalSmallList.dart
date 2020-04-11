import 'package:doc_consult/screens/hospitalInfo/hospitalInfo.dart';
import 'package:doc_consult/screens/hospitalList/__mockData__.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hospitalListScreen.dart';

///
/// #### [Description]
///
/// This widget provides 3-4 hospitals info in list and is
/// intended to work as the small link to move to
/// the all hospitals screen.
///
class SmallHospitalList extends StatefulWidget {
  SmallHospitalList({Key key}) : super(key: key);

  _SmallHospitalListState createState() => _SmallHospitalListState();
}

class _SmallHospitalListState extends State<SmallHospitalList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 20, 00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                "Hospitals and Clinics",
                style: LightTheme.boldBlackText,
              ),
            ),
            FlatButton(
              child: Text(
                "See all",
                style: LightTheme.boldGreyText,
              ),
              onPressed: () {
                //  Go to all blogs screen
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return HospitalListScreen();
                }));
              },
            )
          ],
        ),
      ),
      Container(
        height: 350,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: HOSPITAL_LIST_SMALL_DATA.length,
          itemBuilder: (BuildContext context, int i) => HospitalSmallListItem(
            id: HOSPITAL_LIST_SMALL_DATA[i]['id'],
            name: HOSPITAL_LIST_SMALL_DATA[i]['name'],
            imageUrl: HOSPITAL_LIST_SMALL_DATA[i]['imageUrl'],
            address: HOSPITAL_LIST_SMALL_DATA[i]['address'],
            rating: HOSPITAL_LIST_SMALL_DATA[i]['rating'],
            contact: HOSPITAL_LIST_SMALL_DATA[i]['contact'],
            email: HOSPITAL_LIST_SMALL_DATA[i]['email'],
          ),
        ),
      ),
    ]);
  }
}

///
/// #### [Description]
///
/// Hospital List Item takes in a Map{} of hospital data.
/// Displays each Map as a card with specified length
/// and width.
/// Best to use as an item of a list
///
class HospitalSmallListItem extends StatelessWidget {
  final dynamic id, contact;
  final String name, address, imageUrl, rating, email;

  final TextStyle _infoText = TextStyle(
      fontSize: 14, color: Colors.black26, fontWeight: FontWeight.w500);

  HospitalSmallListItem(
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
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red[400],
                        size: 15,
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
                        size: 15,
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
                        size: 15,
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
