import 'dart:math' show pow;

import 'package:petitparser/expression.dart' show ExpressionBuilder;
import 'package:petitparser/petitparser.dart';

buildParser() async {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
            digit().plus() &
            (char('.') & digit().plus()).optional() &
            (pattern('eE') & pattern('+-').optional() & digit().plus())
                .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group().prefix(char('-').trim(), (op, num a) => -a);
  builder.group().right(char('^').trim(), (num a, op, num b) => pow(a, b));
  builder.group()
    ..left(char('*').trim(), (num a, op, num b) => a * b)
    ..left(char('/').trim(), (num a, op, num b) => a / b);
  builder.group()
    ..left(char('+').trim(), (num a, op, num b) => a + b)
    ..left(char('-').trim(), (num a, op, num b) => a - b);
  return builder.build().end();
}

double calcString(String text) {
  final parser = buildParser();
  final input = text;
  final result = parser.parse(input);
  if (result.isSuccess)
    return result.value.toDouble();
  else
    return double.parse(text);
}
