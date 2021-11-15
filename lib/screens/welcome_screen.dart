import 'dart:math';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final List<Color> colorList = [];

  WelcomeScreen({Key? key}) : super(key: key) {
    for (final primary in Colors.primaries) {
      colorList.add(primary.shade700);
    }
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Color currentColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentColor,
        child: const Icon(Icons.palette),
        onPressed: () {
          Color newTextColor = currentColor;
          while (newTextColor == currentColor) {
            newTextColor = widget.colorList.elementAt(
              Random().nextInt(widget.colorList.length),
            );
          }
          setState(() {
            currentColor = newTextColor;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(
              'Welcome to the playground!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: currentColor,
                  ),
            ),
            const SizedBox(height: 24.0),
            SelectableText(
              'This website is still work in progress, check back soon for fun stuff. :)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: currentColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
