import 'package:doc_consult/resources/firebase_repository.dart';
import 'package:doc_consult/screens/home/home.dart';
import 'package:doc_consult/screens/signup/signup.dart';
import 'package:doc_consult/shared/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
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
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Input(
              placeholder: "Username or Email",
              controller: usernameController,
            ),
            Input(
              placeholder: "Password",
              controller: passwordController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  performLogin();
                },
                child: Text(
                  "Let Me In",
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
            Stack(
              children: <Widget>[
                Divider(
                  indent: 20,
                  endIndent: 20,
                  height: 50,
                  thickness: 2,
                  color: Color.fromRGBO(230, 230, 230, 1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                      child: Text(
                    "   or   ",
                    style: TextStyle(
                        backgroundColor: Colors.white, color: Colors.black26),
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: SvgPicture.asset(
                    "lib/assets/svg/google.svg",
                    height: 30,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: SvgPicture.asset(
                    "lib/assets/svg/facebook.svg",
                    height: 30,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: SvgPicture.asset(
                    "lib/assets/svg/twitter.svg",
                    height: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?",
                    style: TextStyle(
                      color: Colors.black26,
                    )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (context) => Signup()));
                    },
                    highlightColor: Colors.transparent,
                    child: Text(
                      "Sign Up",
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
      ),
    );
  }

  void performLogin() {
    print(usernameController.text + ":AEK");
    print("tring to perform login");

    setState(() {
      isLoading = true;
    });
    try {
      _repository
          .authenticateUserWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((FirebaseUser user) {
        setState(() {
          isLoading = false;
        });
        if (user != null) {
          print("user auhtenticates successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
//          authenticateUser(user);
        } else {
          print("There was an error");
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SvgPicture.asset(
      "lib/assets/svg/cardiogram.svg",
      width: 200,
      height: 200,
    ));
  }
}
