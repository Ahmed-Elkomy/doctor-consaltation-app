import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Input Class that renders an Input Text field.
/// Takes in a `placeholder` to label the field.
class Input extends StatelessWidget {
  final String placeholder;

  const Input({
    Key key,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        onChanged: (String value) {
          print(value);
        },
        autocorrect: false,
        cursorColor: Colors.red,
        style: TextStyle(fontSize: 16.0),
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            contentPadding: EdgeInsets.all(10.0)),
      ),
    );
  }
}
