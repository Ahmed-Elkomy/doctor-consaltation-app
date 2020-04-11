import 'package:flutter/material.dart';
import 'package:doc_consult/screens/article/__mockData__.dart';

///
/// #### [Description]
/// 
/// Screen to show the article from the DB.
/// Use this screen if you do not want to render a web page
/// inside your flutter application.
///
class ArticleScreen extends StatefulWidget {
  final dynamic id;
  final String title, imageUrl;

  const ArticleScreen({Key key, this.id, this.title, this.imageUrl})
      : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String data;

  ///
  /// #### [Description]
  ///
  /// Get the data from the API with the post ID to
  /// display the text with RichText or other
  /// methods.
  ///
  /// #### Prefered Method:
  ///
  /// * If the article is in a webpage, use a
  /// `WebView` instead of other methods.
  ///
  /// * If the article is in a DB, `split` the string and render
  /// it as list with separated childs containing
  /// chunks of text.
  ///
  Future<String> getPostData({String id}) async {
    await Future.delayed(Duration(seconds: 2));
    return "Some Text";
  }

  @override
  void initState() {
    super.initState();
    data = getPostData(id: widget.id).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Article"),
          elevation: 0,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: <Widget>[
            Text(
              """${widget.title}""",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: FadeInImage.assetNetwork(
                image: widget.imageUrl,
                placeholder: "assets/images/placeholder-img.jpg",
              ),
            ),
            ...POST_DATA_LIST.map((item) => Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("$item",
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                )).toList()
          ],
        ));
  }
}
