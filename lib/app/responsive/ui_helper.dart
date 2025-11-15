import 'package:flutter/material.dart';

class UIHelpers {
  UIHelpers._();

  // Baseline dimensions (Figma reference)
  static const double _refWidth = 390.0;
  static const double _refHeight = 844.0;
  // Scaling bounds
  static const double _minScale = 0.85;
  static const double _maxScale = 1.35;

  //  BASE SCALING

  static double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width / _refWidth).clamp(_minScale, _maxScale);
  }

  //  FONT SIZE

  static double font(BuildContext context, double base) {
    return base * _scale(context);
  }

  //  SPACING

  static double space(BuildContext context, double base) {
    return base * _scale(context);
  }

  //  WIDTH

  static double w(BuildContext context, double base) {
    final width = MediaQuery.of(context).size.width;
    return (base / _refWidth) * width;
  }

  //  HEIGHT

  static double h(BuildContext context, double base) {
    final height = MediaQuery.of(context).size.height;
    return (base / _refHeight) * height;
  }

  //  RADIUS

  static double radius(BuildContext context, double base) {
    return base * _scale(context);
  }

  //  ICON SIZE

  static double icon(BuildContext context, double base) {
    return base * _scale(context);
  }

  //  TEXT PRESETS

  static double headerTextSize(BuildContext c) => font(c, 26);
  static double largeTextSize(BuildContext c) => font(c, 20);
  static double mediumTextSize(BuildContext c) => font(c, 16);
  static double normalTextSize(BuildContext c) => font(c, 14);
  static double smallTextSize(BuildContext c) => font(c, 12);

  //  SPACING PRESETS

  static double spaceSmall(BuildContext c) => space(c, 8);
  static double spaceMedium(BuildContext c) => space(c, 16);
  static double spaceLarge(BuildContext c) => space(c, 24);
  static double spaceExtraLarge(BuildContext c) => space(c, 32);

  static double spaceVertical(BuildContext c) => space(c, 14);
  static double spaceHorizontal(BuildContext c) => space(c, 18);

  //  RADIUS PRESETS

  static double radiusSmall(BuildContext c) => radius(c, 8);
  static double radiusMedium(BuildContext c) => radius(c, 16);
  static double radiusLarge(BuildContext c) => radius(c, 24);

  //  ICON PRESETS

  static double iconSmallSize(BuildContext c) => icon(c, 16);
  static double iconMediumSize(BuildContext c) => icon(c, 24);
  static double iconLargeSize(BuildContext c) => icon(c, 32);
}
