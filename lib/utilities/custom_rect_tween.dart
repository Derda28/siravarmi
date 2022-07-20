import 'dart:ui';

import 'package:flutter/widgets.dart';

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);

    double left = lerpDouble(begin!.left, end!.left, elasticCurveValue) as double;
    double top = lerpDouble(begin!.top, end!.top, elasticCurveValue) as double;
    double right = lerpDouble(begin!.right, end!.right, elasticCurveValue) as double;
    double bottom = lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue) as double;
    return Rect.fromLTRB(left, top, right, bottom);
  }
}