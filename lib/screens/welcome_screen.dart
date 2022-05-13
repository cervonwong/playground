import 'dart:math';

import 'package:flutter/cupertino.dart';
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
const colorAnimationDuration = Duration(milliseconds: 150);
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
                      const QuoteText(),
                      const SizedBox(height: 24.0),
                      AuxiliaryText(clickCount: clickCount),
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

class AuxiliaryText extends StatefulWidget {
  const AuxiliaryText({
    Key? key,
    required this.clickCount,
  }) : super(key: key);

  final int clickCount;

  @override
  State<AuxiliaryText> createState() => _AuxiliaryTextState();
}

class _AuxiliaryTextState extends State<AuxiliaryText>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 110), vsync: this);
    scale = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    animationController
        .forward()
        .whenComplete(() => animationController.reverse());
  }

  @override
  void didUpdateWidget(covariant AuxiliaryText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clickCount == oldWidget.clickCount) {
      return;
    }
    animationController.reset();
    animationController
        .forward()
        .whenComplete(() => animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: textSwitcherAnimationDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: widget.clickCount == 0
          ? Text(
              'Click anywhere to start slaying.',
              textAlign: TextAlign.center,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontFamily: 'Fraunces 9pt',
                    fontSize: LayoutCalculator.breakpoint(context: context) ==
                            LayoutBreakpoint.smallest
                        ? 18.0
                        : 20.0,
                  ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Slay counter: ',
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontFamily: 'Fraunces 9pt',
                        fontSize:
                            LayoutCalculator.breakpoint(context: context) ==
                                    LayoutBreakpoint.smallest
                                ? 18.0
                                : 20.0,
                      ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, _) {
                    return Transform.scale(
                      scale: scale.value,
                      child: Text(
                        '${widget.clickCount}',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontFamily: 'Fraunces 9pt',
                              fontSize: LayoutCalculator.breakpoint(
                                          context: context) ==
                                      LayoutBreakpoint.smallest
                                  ? 18.0
                                  : 20.0,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class QuoteText extends StatelessWidget {
  const QuoteText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Why be gray when you can slay',
          style: DefaultTextStyle.of(context).style.copyWith(
                fontSize: LayoutCalculator.breakpoint(context: context) ==
                        LayoutBreakpoint.smallest
                    ? 48.0
                    : LayoutCalculator.breakpoint(context: context) ==
                            LayoutBreakpoint.small
                        ? 64.0
                        : 88.0,
                fontFamily: 'Fraunces 72pt',
              ),
          children: const [
            TextSpan(
              text: '!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ]),
      textAlign: TextAlign.center,
    );
  }
}
