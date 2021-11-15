import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(
              'Welcome to the playground!',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 24.0),
            SelectableText(
              'This website is still in progress, check back soon for fun stuff.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
