import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playground/utils/layout_calculator.dart';

const colorList = [
  [Color(0XFFFEF2F2), Color(0XFFDC2626)], // Red light.
  [Color(0XFFFFF7ED), Color(0XFFEA580C)], // Orange light.
  [Color(0XFFFFFBEB), Color(0XFFD97706)], // Amber light.
  [Color(0XFFF7FEE7), Color(0XFF65A30D)], // Lime light.
  [Color(0XFFF0FDF4), Color(0XFF16A34A)], // Green light.
  [Color(0XFFF0FDFA), Color(0XFF0D9488)], // Teal light.
  [Color(0XFFECFEFF), Color(0XFF0891B2)], // Cyan light.
  [Color(0XFFF0F9FF), Color(0XFF0284C7)], // Sky light.
  [Color(0XFFEEF2FF), Color(0XFF4F46E5)], // Indigo light.
  [Color(0XFFF5F3FF), Color(0XFF7C3AED)], // Violet light.
  [Color(0XFFFDF4FF), Color(0XFFC026D3)], // Fuchsia light.
  [Color(0XFFFDF2F8), Color(0XFFDB2777)], // Pink light.
];
const animationDuration = Duration(milliseconds: 150);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentColorIndex = -1;
  Color backgroundColor = const Color(0XFFF3F4F6);
  Color foregroundColor = const Color(0XFF4B5563);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: animationDuration,
        color: backgroundColor,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              int newColorIndex = currentColorIndex;
              while (newColorIndex == currentColorIndex) {
                newColorIndex =
                  Random().nextInt(colorList.length);
              }
              setState(() {
                currentColorIndex = newColorIndex;
                backgroundColor = colorList[newColorIndex][0];
                foregroundColor = colorList[newColorIndex][1];
              });
            },
            splashColor: Colors.white,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: animationDuration,
                style: TextStyle(color: foregroundColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to my playground!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: LayoutCalculator.breakpoint(context: context) ==
                                LayoutBreakpoint.smallest
                            ? 36.0
                            : LayoutCalculator.breakpoint(context: context) ==
                                    LayoutBreakpoint.small
                                ? 48.0
                                : 56.0,
                        fontFamily: 'Fraunces 72pt',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'There\'s nothing here at all :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                            fontFamily: 'Fraunces 9pt',
                            fontSize: LayoutCalculator.breakpoint(context: context) ==
                                    LayoutBreakpoint.smallest
                                ? 16.0
                                : 18.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
