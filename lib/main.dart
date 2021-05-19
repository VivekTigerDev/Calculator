import 'dart:ui';

import 'package:calculator/calc_buttons.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Buttons(),
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  var userInput = "";
  var userOutput = "";
  final List<String> buttons = [
    "C",
    "AC",
    "(",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    ".",
    "0",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    // This Container Is Used For Input
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topRight,
                      child: Text(
                        userInput,
                        style: TextStyle(
                            fontSize: 55,
                            color: Color(0xFFC0C2C1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //This Container Is Used For Output
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        userOutput,
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF606A70),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4)),
                  itemBuilder: (BuildContext context, int index) {
                    // This Statement Used For Clear Button
                    if (index == 0) {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            userInput = "";
                          });
                        },
                        buttonText: buttons[index],
                        color: Color(0xFFFFB927),
                        textColor: Color(0xFFFDFDFC),
                      );
                      // This Statement Used For Delete Button
                    } else if (index == 1) {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            userInput =
                                // Sub-string Means We Only Want Part Of The String
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Color(0xFFE4E8EA),
                        textColor: Color(0xFF869196),
                      );
                    }
                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return SizedBox(
                        child: CalcButtons(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFF8A31DA),
                          textColor: Colors.white,
                        ),
                      );
                    }

                    // This Statement Used For parenthesis()
                    else if (index == 1) {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            // parenthesisPressed();
                          });
                        },
                      );
                    }
                    // This Statement Used For Reset
                    else {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        // Number Buttons
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Color(0xFFDFD5ED)
                            : Color(0xFFF3F4F6),
                        textColor: isOperator(buttons[index])
                            ? Color(0xFF89719F)
                            : Color(0xFF869196),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//The Boolean Statement Used For Different The Colors (/),(%)Button From Other Operators
  bool isOperator(String x) {
    if (x == "/" || x == "*" || x == "-" || x == "+") {
      return true;
    }
    return false;
  }

//This Void Statement Used For (=) Button
  void equalPressed() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userOutput = eval.toString();
  }

// //This Void Statement Used For Percentage Button
//   void percentagePressed() {
//     String finalInput = userInput;
//     finalInput = finalInput.substring(userInput.length - 1);
//     Parser p = Parser();
//     Expression exp = p.parse(finalInput);
//     ContextModel cm = ContextModel();
//     double eval = exp.evaluate(EvaluationType.REAL, cm);
//     userOutput = eval.toString();
//   }
}
