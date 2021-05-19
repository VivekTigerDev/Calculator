import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CalcButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  const CalcButtons({
    Key key,
    this.color,
    this.textColor,
    this.buttonText,
    this.buttonTapped,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD6D8DB),
                spreadRadius: .1,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(width: 1.1, color: Colors.white24),
            ),
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                color: color,
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 40.0,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
