import 'package:doc_consult/screens/home/home.dart';
import 'package:doc_consult/shared/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Center(
              child: SvgPicture.asset(
            "lib/assets/svg/cardiogram.svg",
            width: 200,
            height: 200,
          )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Input(
            placeholder: "Email",
          ),
          Input(
            placeholder: "Username",
          ),
          Input(
            placeholder: "Password",
          ),
          Input(
            placeholder: "Confirm Password",
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                // Signup logic and then go to home.
                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>Home()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 5,
              color: Color.fromRGBO(240, 240, 240, 1),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textColor: Colors.black87,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account?",
                  style: TextStyle(
                    color: Colors.black26,
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16, color: Colors.red[300]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
