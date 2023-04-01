import 'package:math_expressions/math_expressions.dart';

import 'colors.dart';

String calculate(String userInput) {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  } catch (e) {
    return "ERROR";
  }
}

getColor(String text, bool darkMode) {
  if (text == "AC" || text == "(" || text == ")") {
    return darkMode ? orange : green;
  }
  if (text == "/" || text == "x" || text == "-" || text == "+" || text == "=") {
    return darkMode ? green : orange;
  }
  return darkMode ? white : dark;
}

getUserInputColor(String userInput, bool darkMode) {
  if (userInput.contains("/") ||
      userInput.contains("x") ||
      userInput.contains("-") ||
      userInput.contains("+")) {
    return darkMode ? green : orange;
  } else {
    return darkMode ? white : dark;
  }
}
