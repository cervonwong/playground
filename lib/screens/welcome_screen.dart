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
const colorAnimationDuration = Duration(milliseconds: 100);
const textSwitcherAnimationDuration = Duration(milliseconds: 500);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentColorIndex = -1;
  Color backgroundColor = const Color(0XFFF3F4F6);
  Color foregroundColor = const Color(0XFF4B5563);
  int clickCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: colorAnimationDuration,
        color: backgroundColor,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              int newColorIndex = currentColorIndex;
              while (newColorIndex == currentColorIndex) {
                newColorIndex = Random().nextInt(colorList.length);
              }
              setState(() {
                currentColorIndex = newColorIndex;
                backgroundColor = colorList[newColorIndex][0];
                foregroundColor = colorList[newColorIndex][1];
                clickCount++;
              });
            },
            splashColor: Colors.white,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: colorAnimationDuration,
                style: TextStyle(color: foregroundColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: LayoutCalculator.breakpoint(context: context) ==
                            LayoutBreakpoint.smallest
                        ? 16.0
                        : LayoutCalculator.breakpoint(context: context) ==
                                LayoutBreakpoint.small
                            ? 32.0
                            : 64.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Why be gray when you can slay!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: LayoutCalculator.breakpoint(
                                      context: context) ==
                                  LayoutBreakpoint.smallest
                              ? 48.0
                              : LayoutCalculator.breakpoint(context: context) ==
                                      LayoutBreakpoint.small
                                  ? 64.0
                                  : 88.0,
                          fontFamily: 'Fraunces 72pt',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      AnimatedSwitcher(
                        duration: textSwitcherAnimationDuration,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: Text(
                          clickCount == 0
                              ? 'Click anywhere to start slaying.'
                              : 'Slay counter: $clickCount',
                          key: ValueKey<bool>(clickCount == 0),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Fraunces 9pt',
                            fontSize:
                                LayoutCalculator.breakpoint(context: context) ==
                                        LayoutBreakpoint.smallest
                                    ? 18.0
                                    : 20.0,
                          ),
                        ),
                      ),
                    ],
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
