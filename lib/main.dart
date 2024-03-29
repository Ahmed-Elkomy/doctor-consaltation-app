import 'package:doc_consult/provider/image_upload_provider.dart';
import 'package:doc_consult/provider/user_provider.dart';
import 'package:doc_consult/resources/firebase_repository.dart';
import 'package:doc_consult/screens/home/home.dart';
import 'package:doc_consult/screens/login/login.dart';
import 'package:doc_consult/screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _sysOverlay();
    }
  }

  void _sysOverlay() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.transparent, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
  }

  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    _sysOverlay();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          routes: {
            "Login": (context) => Login(),
            "Home": (context) => Home(),
            "Signup": (context) => Signup()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              highlightColor: Color.fromRGBO(251, 186, 123, 0.2),
              splashColor: Colors.transparent,
              scaffoldBackgroundColor: Colors.white,
              accentColor: Color.fromRGBO(255, 255, 255, 0.1),
              hintColor: Colors.black26,
              cursorColor: Color.fromRGBO(245, 148, 130, 1),
              primaryColorLight: Colors.white,
              primaryColor: Colors.white,
              dialogBackgroundColor: Color(0xaaE090C9)),
          home: Login()
//          FutureBuilder(
////              future: _repository.getCurrentUser(),
////              builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
////                if (snapshot.hasData) {
////                  return Home();
////                } else {
////                  return Login();
////                }
////              })
          ),
    );
  }
}
