import 'package:doc_consult/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:doc_consult/screens/accountInfo/accountInfo.dart';

///
/// #### [Description]
///
/// Drawer widget that returns a drawer for the Home Scaffold.
///
class CustomDrawer extends StatelessWidget {
  final String username = "alice";
  final String name = "Alice Naymer";
  final String url =
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80";

  CustomDrawer({Key key}):super(key: key);

  ListTile listTile({String svgIconName, String title, Function onTap}) =>
      ListTile(
        leading: SvgPicture.asset(
          "lib/assets/svg/$svgIconName.svg",
          height: 35,
        ),
        title: Text("$title", style: TextStyle(fontWeight: FontWeight.w600)),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
              child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              width: 150,
              height: 150,
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(url),
              ),
            ),
            Text(
              "$name",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
            ),
            Text("@$username",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.black38,
                )),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Divider(
                color: Colors.black12,
                height: 2.0,
                thickness: 1.5,
                indent: 20,
                endIndent: 20,
              ),
            ),
            listTile(
                svgIconName: "info_coloured",
                title: "Account Info",
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 300), () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return AccountInfo();
                    }));
                  });
                }),
            listTile(svgIconName: "help_coloured", title: "Help"),
            listTile(svgIconName: "contact_us_coloured", title: "Contact Us"),
            listTile(svgIconName: "settings_coloured", title: "Settings"),
            listTile(svgIconName: "logout_coloured", title: "Logout", onTap: (){
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>Login()));
            }),
          ],
        ),
      ),
    );
  }
}