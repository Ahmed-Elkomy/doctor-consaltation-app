import 'package:doc_consult/screens/accountInfo/__mockData__.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///
/// #### [Description]
///
/// Test function to simulate the data loading
/// from the API.
/// Show a loading indicator until the data is
/// loaded.
///
Future<Map<String, dynamic>> getData() async {
  await Future.delayed(Duration(seconds: 2));
  return ACCOUNT_INFO;
}

///
/// #### [Description]
///
/// Screen to render Account info of the user.
/// Will work well when used with `username` or `id`
/// for the network request.
///
class AccountInfo extends StatefulWidget {
  AccountInfo({Key key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo>
    with SingleTickerProviderStateMixin {
  Future<Map<String, dynamic>> accountData = getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Info"),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: FutureBuilder(
          future: accountData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: 250,
                          height: 250,
                          child: CircleAvatar(
                            backgroundColor: Colors.black12,
                            backgroundImage:
                                NetworkImage(snapshot.data['imageUrl']),
                          ),
                        ),
                        Text(
                          "${snapshot.data['name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20.0),
                        ),
                        Text("@${snapshot.data['username']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black38,
                            )),
                      ],
                    ),
                  ),
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
                  buildListTile(title: "Edit Personal Info"),
                  buildListTile(title: "Scheduled Appointments"),
                  buildListTile(title: "Medicine Course"),
                  buildListTile(title: "My Saved Blogs"),
                  buildListTile(title: "Previous Appointments"),
                ],
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

  ///
  /// #### [Description]
  ///
  /// Function that returns the list tile for the various options 
  /// provided to the user.
  ///
  ListTile buildListTile({@required String title, Function onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
      ),
      title: Text(
        "$title",
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
