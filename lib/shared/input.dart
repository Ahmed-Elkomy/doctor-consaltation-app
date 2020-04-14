import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Input Class that renders an Input Text field.
/// Takes in a `placeholder` to label the field.
class Input extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;

  const Input({Key key, this.placeholder, this.controller}) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
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
        controller: widget.controller,
//        onChanged: (String value) {
//          print(value);
//        },
        autocorrect: false,
        cursorColor: Colors.red,
        style: TextStyle(fontSize: 16.0),
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.placeholder,
            contentPadding: EdgeInsets.all(10.0)),
      ),
    );
  }
}
