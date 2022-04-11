import 'package:flutter/material.dart';

class LayoutCalculator {
  LayoutCalculator._(); // Prevent instantiation with private constructor.

  static LayoutBreakpoint breakpoint({required BuildContext context}) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600.0) {
      return LayoutBreakpoint.smallest;
    } else if (screenWidth < 905.0) {
      return LayoutBreakpoint.small;
    } else if (screenWidth < 1240.0) {
      return LayoutBreakpoint.medium;
    } else if (screenWidth < 1440.0) {
      return LayoutBreakpoint.large;
    } else {
      return LayoutBreakpoint.largest;
    }
  }

  static double margin({required BuildContext context}) {
    final screenWidth = MediaQuery.of(context).size.width;

    switch (breakpoint(context: context)) {
      case LayoutBreakpoint.smallest:
        return 16.0;
      case LayoutBreakpoint.small:
        return 32.0;
      case LayoutBreakpoint.medium:
        return (screenWidth - 840.0) / 2;
      case LayoutBreakpoint.large:
        return 200.0;
      case LayoutBreakpoint.largest:
        return (screenWidth - 1040.0) / 2;
    }
  }

  static double wideMargin({required BuildContext context}) {
    final screenWidth = MediaQuery.of(context).size.width;

    switch (breakpoint(context: context)) {
      case LayoutBreakpoint.smallest:
        return 16.0;
      case LayoutBreakpoint.small:
        return (screenWidth - 400.0) / 2;
      case LayoutBreakpoint.medium:
        return (screenWidth - 600.0) / 2; // Placeholder value.
      case LayoutBreakpoint.large:
        return (screenWidth - 600.0) / 2; // Placeholder value.
      case LayoutBreakpoint.largest:
        return (screenWidth - 600.0) / 2; // Placeholder value.
    }
  }
}

// The relative size of the app window wrt to the width of the app window.
enum LayoutBreakpoint {
  smallest, // Approx. width of Phone.
  small, // Approx. width of Small Tablet or Landscape Phone.
  medium, // Approx. width of Tablet.
  large, // Approx. width of Laptop.
  largest, // Approx. width of Desktop.
}
