import 'package:flutter/material.dart';

import 'components/button_list.dart';
import 'components/colors.dart';
import 'components/function.dart';
import 'components/mediaquery.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  String userInput = "0", result = "0";
  double inputSize = 64, resultSize = 24;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? dark : white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: darkMode ? dark : white,
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: darkMode ? lightDark : grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    darkMode = false;
                  });
                },
                child: Icon(
                  Icons.light_mode_rounded,
                  color: darkMode ? white : dark,
                ),
              ),
              widthSpace(20),
              InkWell(
                onTap: () {
                  setState(() {
                    darkMode = true;
                  });
                },
                child: Icon(
                  Icons.dark_mode_outlined,
                  color: darkMode ? white : dark,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: inputSize,
                        //TODO Change the colors of the operations
                        color: getUserInputColor(
                          userInput,
                          darkMode,
                        ),
                        fontFamily: 'Baloo2',
                        letterSpacing: 0.01,
                        // height: 38.45 / inputSize,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: resultSize,
                        color: darkMode ? white : dark,
                        fontFamily: 'Baloo2',
                        letterSpacing: 0.01,
                        height: 102.53 / 64,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: darkMode ? lightDark : grey,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: darkMode ? dark : white,
          borderRadius: BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text, darkMode),
              fontSize: 30,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  handleButtons(text) {
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

      //TODO Remove all the ".0" from the result.

      // if (result.endsWith(".0")) {
      //   result = result.replaceAll(".0", "");
      // }

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
