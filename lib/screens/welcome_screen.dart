import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playground/utils/layout_calculator.dart';

class WelcomeScreen extends StatefulWidget {
  final List<MaterialColor> colorList = [];

  WelcomeScreen({Key? key}) : super(key: key) {
    for (final primary in Colors.primaries) {
      colorList.add(primary);
    }
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  MaterialColor currentColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor.shade50,
      body: InkWell(
        onTap: () {
          MaterialColor newTextColor = currentColor;
          while (newTextColor == currentColor) {
            newTextColor = widget.colorList.elementAt(
              Random().nextInt(widget.colorList.length),
            );
          }
          setState(() {
            currentColor = newTextColor;
          });
        },
        splashColor: Colors.white,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to my playground!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentColor.shade800,
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
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: currentColor.shade800,
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
    );
  }
}
