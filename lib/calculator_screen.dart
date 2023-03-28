import 'package:calculator/components/function.dart';
import 'package:calculator/components/mediaquery.dart';
import 'package:flutter/material.dart';

import 'components/button_list.dart';
import 'components/colors.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = "0", result = "0";
  double inputSize = 64, resultSize = 24;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? dark : white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // darkMode ? dark : light,
        elevation: 0,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            setState(() {
              darkMode = !darkMode;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: darkMode ? lightDark : grey,
            ),
            child: Row(
              children: [
                Icon(
                  darkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_rounded,
                  color: darkMode ? white : dark,
                ),
                widthSpace(20),
                Icon(
                  darkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_rounded,
                  color: darkMode ? white : dark,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.heightPercent(0.4),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 50,
                left: 25,
                right: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: inputSize,
                        color: darkMode ? white : dark,
                        fontFamily: 'Baloo2',
                        letterSpacing: 0.01,
                      ),
                    ),
                  ),
                  heightSpace(20),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: resultSize,
                        color: darkMode ? white : dark,
                        fontFamily: 'Baloo2',
                        letterSpacing: 0.01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: darkMode ? lightDark : grey,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              ),
              child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return customButton(buttonList[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(text) {
    return InkWell(
      onTap: () => setState(() {
        handleButtons(text);
      }),
      child: Ink(
        decoration: BoxDecoration(
            color: darkMode ? dark : null,
            borderRadius: BorderRadius.circular(21),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text, darkMode),
              fontSize: 30,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  handleButtons(String text) {
    if (text == "AC") {
      userInput = "0";
      result = "0";
      inputSize = 64;
      resultSize = 24;
      return;
    }
    if (text == "C") {
      result = "0";
      inputSize = 64;
      resultSize = 24;
      if (userInput == ".0") {
        userInput = userInput.replaceAll(".0", "0");
      }
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);

        if (userInput == "") {
          userInput = "0";
        }
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate(userInput);
      inputSize = 24;
      resultSize = 64;

      if (userInput.endsWith(".0")) {
        result = userInput.replaceAll(".0", "");
        if (result == "") {
          result = "0";
        }
        return;
      }
    } else {
      if (userInput == "0") {
        userInput = "";
      }
      userInput = userInput + text;
      inputSize = 64;
      resultSize = 24;
    }
  }
}
