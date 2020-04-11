import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:doc_consult/screens/blogs/__mockData__.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
  return BLOG_LIST_SCREEN_DATA;
}

///
/// #### [Description]
///
/// Screen to fetch blogs list. Get the data from the API.
/// Takes in a
///
/// ```dart
/// Future<List<Map<String, dynamic>>>
/// ```
///
/// and builds a list based on the data. Animates each item with the animation
/// object (which can be changed anytime)
///
class BlogsScreen extends StatefulWidget {
  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen>
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
        title: Text("Blogs"),
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
                itemBuilder: (context, index) {
                  controller.forward();
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, Widget w) {
                      return FadeTransition(
                        opacity: animation,
                        child: BlogItem(
                          id: snapshot.data[index]['id'],
                          title: snapshot.data[index]['title'],
                          description: snapshot.data[index]['description'],
                          url: snapshot.data[index]['url'],
                          imageUrl: snapshot.data[index]['imageUrl'],
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
/// Widget that contains the `title` and the `description`
/// about the blog.
/// Clicking on it will navigate to the artice page.
///
class BlogItem extends StatelessWidget {
  final dynamic id;
  final String title, description, imageUrl, url;
  final double borderRadius = 20;

  BlogItem(
      {Key key, this.id, this.description, this.title, this.imageUrl, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ///
        /// [______PREFERRED______]
        ///
        /// Function to create a WebView to create a
        /// web page in the app.
        ///
        /// NOTE: [REQUIRES A URL]
        ///

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebviewScaffold(
            url: url,
            appBar: AppBar(
              title: Text("$title"),
            ),
            withJavascript: true,
          );
        }));

        ///
        /// [______OPTIONAL______]
        ///
        /// Function that goes to a new screen to load data
        /// from DB.
        ///
        /// Uncomment the block to use the function
        ///

        // Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
        //   return ArticleScreen(
        //     id: id,
        //     imageUrl: imageUrl,
        //     title: title,
        //   );
        // }));
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
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "$description",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        height: 1.3),
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
