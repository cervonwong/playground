import 'dart:math';

import 'package:flutter/material.dart';

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
              SelectableText(
                'Welcome to my playground!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: currentColor.shade800,
                      fontFamily: 'Fraunces 72pt',
                    ),
              ),
              const SizedBox(height: 24.0),
              SelectableText(
                'There\'s nothing here at all :)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: currentColor.shade800,
                      fontFamily: 'Fraunces 9pt',
                      fontSize: 18.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
