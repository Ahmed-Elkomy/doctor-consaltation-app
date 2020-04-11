import 'package:flutter/material.dart';

class SpecialityContainer extends StatelessWidget {
  final String speciality;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double textSize;


  const SpecialityContainer({
    Key key,
    @required this.speciality, this.verticalPadding = 8, this.horizontalPadding = 30, this.borderRadius = 8, this.textSize = 14,
  }) : super(key: key);
  
  SpecialityContainer.big({
    Key key,
    @required this.speciality, this.verticalPadding = 8, this.horizontalPadding = 30, this.borderRadius = 8, this.textSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 137, 255, 0.15),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Text("$speciality",
          style: TextStyle(
              fontSize: textSize,
              letterSpacing: 1.5,
              color: Color.fromRGBO(0, 137, 255, 1),
              fontWeight: FontWeight.w700)),
    );
  }
}