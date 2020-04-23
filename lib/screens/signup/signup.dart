import 'package:doc_consult/resources/firebase_repository.dart';
import 'package:doc_consult/screens/home/home.dart';
import 'package:doc_consult/shared/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  FirebaseRepository _repository = FirebaseRepository();
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
            controller: emailController,
          ),
          Input(
            placeholder: "Username",
            controller: usernameController,
          ),
          Input(
            placeholder: "Password",
            controller: passwordController,
          ),
          Input(
            placeholder: "Confirm Password",
            controller: confirmPasswordController,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                performSignUp();
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.red[300]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void performSignUp() {
    print("tring to perform singup");
    print("AEK:" + usernameController.text);
    print("AEK:" + passwordController.text);
    print("AEK:" + emailController.text);
    print("AEK:" + confirmPasswordController.text);

    setState(() {
      isLoading = true;
    });
    try {
      _repository
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((FirebaseUser user) async {
        if (user != null) {
          print("user created successfully");
          await authenticateUser(user);
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => Home()));
        } else {
          print("There was an error");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> authenticateUser(FirebaseUser user) async {
    await _repository.authenticateUser(user).then((isNewUser) async {
      setState(() {
        isLoading = false;
      });

      if (isNewUser) {
        UserUpdateInfo info = UserUpdateInfo();
        info.displayName = usernameController.text;
        info.photoUrl = "";
        user.updateProfile(info);
        _repository.addDataToDb(user, usernameController.text).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        });
      } else {
//        Navigator.pushReplacement(context,
//            MaterialPageRoute(builder: (context) {
//          return Home();
//        }));
      }
    });
  }
}
