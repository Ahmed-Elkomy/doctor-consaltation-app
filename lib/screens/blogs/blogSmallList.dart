import 'package:doc_consult/screens/blogs/__mockData__.dart';
import 'package:doc_consult/screens/blogs/blogScreen.dart';
import 'package:doc_consult/theme/lightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///
/// #### [Description]
///
/// This widget provides 3-4 blogs in list and is
/// intended to work as the small link to move to
/// the all blogs post screen.
///
class SmallBlogList extends StatefulWidget {
  SmallBlogList({Key key}) : super(key: key);

  _SmallBlogListState createState() => _SmallBlogListState();
}

/// State to get the data of blogs from the API
class _SmallBlogListState extends State<SmallBlogList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 20, 00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Blogs",
              style: LightTheme.boldBlackText,
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
                  return BlogsScreen();
                }));
              },
            )
          ],
        ),
      ),
      Container(
        height: 330,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: BLOG_LIST_SMALL_DATA.length,
          itemBuilder: (BuildContext context, int i) => BlogListItem(
            id: BLOG_LIST_SMALL_DATA[i]['id'],
            title: BLOG_LIST_SMALL_DATA[i]['title'],
            imageUrl: BLOG_LIST_SMALL_DATA[i]['imageUrl'],
            description: BLOG_LIST_SMALL_DATA[i]['description'],
            url: BLOG_LIST_SMALL_DATA[i]['url'],
          ),
        ),
      ),
    ]);
  }
}

///
/// #### [Description]
///
/// Blog List Item takes in a Map{} of blog post data.
/// Displays each Map as a card with specified length
/// and width.
/// Best to use as an item of a list
///
/// #### Note:
///
/// * `description` must be less than "100" Characters in length
/// * `title` must is less than "22" Characters in length
///
class BlogListItem extends StatelessWidget {
  final dynamic id;
  final String title, description, imageUrl, url;

  BlogListItem(
      {Key key, this.id, this.description, this.title, this.imageUrl, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ///
        /// Function that goes to a new screen to load data
        /// from DB.
        ///

        // Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
        //   return ArticleScreen(
        //     id: id,
        //     imageUrl: imageUrl,
        //     title: title,
        //   );
        // }));

        ///
        /// [______OPTIONAL______]
        ///
        /// Function to create a WebView to create a
        /// web page in the app.
        ///
        /// NOTE: [REQUIRES A URL]
        ///
        /// Uncomment the function to use it.
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
      },
      child: Container(
        height: 260,
        width: 210,
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
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "$description",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black26,
                        fontWeight: FontWeight.w600),
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
