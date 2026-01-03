import 'dart:math' as maths;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_project/spongebob/size_config.dart';

class SpongeBob extends CustomPainter with SizesHelper, Mathshelper {
  final double eyeValue;
  final double frownMouthValue;
  final double strokeProgress;

  SpongeBob({
    required this.eyeValue,
    required this.frownMouthValue,
    this.strokeProgress = 1.0,
  });

  // Draws a path progressively (0..1) using PathMetrics.
  void animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    final p = progress.clamp(0.0, 1.0);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      final extractPath = metric.extractPath(0.0, metric.length * p);
      canvas.drawPath(extractPath, paint);
    }
  }

  // Maps global progress (0..1) into a local segment progress for [start, end].
  // Returns 0 before start, 1 after end, linear in-between.
  double _segment(double start, double end) {
    final p = strokeProgress.clamp(0.0, 1.0);
    if (end <= start) return p >= end ? 1.0 : 0.0;
    if (p <= start) return 0.0;
    if (p >= end) return 1.0;
    return (p - start) / (end - start);
  }

  void _drawProgressivePoints(
    Canvas canvas, {
    required List<Offset> points,
    required Paint paint,
    required double progress,
  }) {
    final p = progress.clamp(0.0, 1.0);
    if (points.isEmpty || p <= 0) return;

    final count = (points.length * p).ceil().clamp(0, points.length);
    if (count == 0) return;

    canvas.drawPoints(PointMode.points, points.take(count).toList(), paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    initSize(size);

    // 1) Base fills/background (no stroke animation).
    canvas.drawPaint(Paint()..color = Colors.yellow[300]!);

    canvas.translate(size.width / 2, size.height / 2);

    // 2) Draw-on strokes (strokeProgress driven).
    _drawFace(canvas, size);
    _drawHands(canvas);
    _drawBody(size, canvas);
    _drawLegs(canvas);

    // 3) Secondary animations (eyes/mouth) are already baked into the paths
    // via eyeValue/frownMouthValue. Keeping this phase for future layering.
  }

  void _drawFace(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, -size.height / 4);
    final distanceBetweenPupils = w50;

    _drawEye(canvas, distanceBetweenPupils);

    _drawEye(canvas, -distanceBetweenPupils - w10);

    _drawNose(canvas);

    _drawMouth(canvas);

    canvas.restore();
  }

  void _drawEye(
    Canvas canvas,
    double distanceBetweenPupils,
  ) {
    final outlinePaint = _outlinePaint
      ..strokeWidth = h12
      ..color = const Color(0xff333333).withOpacity(eyeValue);

    // Eyelash/lines draw in early.
    final eyeLinesProgress = _segment(0.0, 0.20);

    animatePath(
      Path()
        ..moveTo(-distanceBetweenPupils, -h10)
        ..lineTo(
          w6 - distanceBetweenPupils,
          -computeRangeMinMax(eyeValue, h50, h60),
        ),
      outlinePaint,
      canvas,
      eyeLinesProgress,
    );

    animatePath(
      Path()
        ..moveTo(-w10 - distanceBetweenPupils, -h10)
        ..lineTo(
          -w35 - distanceBetweenPupils,
          -computeRangeMinMax(eyeValue, h40, h50),
        ),
      outlinePaint,
      canvas,
      eyeLinesProgress,
    );

    animatePath(
      Path()
        ..moveTo(w20 - distanceBetweenPupils, -h10)
        ..lineTo(
          w46 - distanceBetweenPupils,
          -computeRangeMinMax(eyeValue, h35, h45),
        ),
      outlinePaint,
      canvas,
      eyeLinesProgress,
    );

    // Keep circles as-is (non-path). We'll animate lid arcs below.

    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w50,
        _outlinePaint..color = const Color(0xff333333));
    canvas.drawCircle(
        Offset(-distanceBetweenPupils, 0), w46, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w24,
        _outlinePaint..strokeWidth = w3);
    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w23,
        Paint()..color = Colors.blue[200]!);
    canvas.drawCircle(
        Offset(-distanceBetweenPupils, 0), w12, Paint()..color = Colors.black);

    if (distanceBetweenPupils.isNegative) {
      // Yellow fill stays immediate.
      canvas.drawPath(
        Path()
          ..moveTo(-distanceBetweenPupils - w50, 0)
          ..arcTo(
            Rect.fromPoints(
              Offset(
                  -distanceBetweenPupils +
                      computeRangeMinMax(eyeValue, w50, w20),
                  -h50),
              Offset(
                -distanceBetweenPupils - computeRangeMinMax(eyeValue, w50, w20),
                computeRangeMinMax(eyeValue, h50, -h50),
              ),
            ),
            maths.pi,
            maths.pi,
            true,
          )
          ..moveTo(
            -distanceBetweenPupils + computeRangeMinMax(eyeValue, w40, 0),
            -computeRangeMinMax(eyeValue, h10, h50),
          )
          ..conicTo(
            -distanceBetweenPupils + computeRangeMinMax(eyeValue, w135, 0),
            -computeRangeMinMax(eyeValue, h10, h50),
            -distanceBetweenPupils + computeRangeMinMax(eyeValue, w50, 0),
            computeRangeMinMax(eyeValue, 0, -h50),
            0.3,
          )
          ..lineTo(
            -distanceBetweenPupils - computeRangeMinMax(eyeValue, w50, 0),
            computeRangeMinMax(eyeValue, 0, -h50),
          ),
        Paint()..color = Colors.yellow[300]!,
      );

      final lidPath = Path()
        ..moveTo(
          -distanceBetweenPupils + computeRangeMinMax(eyeValue, w40, w50),
          -h10,
        )
        ..conicTo(
          computeRangeMinMax(eyeValue, w185, w110),
          -h10,
          -distanceBetweenPupils + computeRangeMinMax(eyeValue, w50, w20),
          computeRangeMinMax(eyeValue, 0, -h50),
          0.3,
        )
        ..lineTo(
          -distanceBetweenPupils - computeRangeMinMax(eyeValue, w50, w20),
          computeRangeMinMax(eyeValue, 0, -h50),
        );

      animatePath(
        lidPath,
        _outlinePaint
          ..color = const Color(0xff333333)
              .withOpacity(computeRangeMinMax(eyeValue, 1, 0))
          ..strokeCap = StrokeCap.round
          ..strokeWidth = w4,
        canvas,
        _segment(0.15, 0.35),
      );
    } else {
      canvas.drawPath(
        Path()
          ..moveTo(-distanceBetweenPupils - w50, 0)
          ..arcTo(
            Rect.fromPoints(
              Offset(
                  -distanceBetweenPupils +
                      computeRangeMinMax(eyeValue, w50, w20),
                  -h50),
              Offset(
                -distanceBetweenPupils - computeRangeMinMax(eyeValue, w50, w20),
                computeRangeMinMax(eyeValue, h50, -h50),
              ),
            ),
            maths.pi,
            maths.pi,
            true,
          )
          ..moveTo(
              -distanceBetweenPupils - computeRangeMinMax(eyeValue, w60, 0),
              computeRangeMinMax(eyeValue, 0, -h40))
          ..conicTo(
            -computeRangeMinMax(eyeValue, w185, w105),
            computeRangeMinMax(eyeValue, -h40, -h30),
            distanceBetweenPupils - computeRangeMinMax(eyeValue, w60, 0),
            computeRangeMinMax(eyeValue, 0, -h40),
            computeRangeMinMax(eyeValue, 0.3, 0),
          ),
        Paint()..color = Colors.yellow[300]!,
      );

      final lidPath = Path()
        ..moveTo(
          -distanceBetweenPupils - computeRangeMinMax(eyeValue, w40, w50),
          -h10,
        )
        ..conicTo(
          -computeRangeMinMax(eyeValue, w185, w105),
          -h10,
          -distanceBetweenPupils - computeRangeMinMax(eyeValue, w50, w20),
          computeRangeMinMax(eyeValue, 0, -h50),
          0.3,
        )
        ..lineTo(
          -distanceBetweenPupils + computeRangeMinMax(eyeValue, w50, w20),
          computeRangeMinMax(eyeValue, 0, -h50),
        );

      animatePath(
        lidPath,
        _outlinePaint
          ..color = const Color(0xff333333)
              .withOpacity(computeRangeMinMax(eyeValue, 1, 0))
          ..strokeCap = StrokeCap.round
          ..strokeWidth = w4,
        canvas,
        _segment(0.15, 0.35),
      );
    }
  }

  void _drawNose(Canvas canvas) {
    final noseProgress = _segment(0.25, 0.45);

    Path _nosePathInner = Path()
      ..moveTo(w3, h15)
      ..arcToPoint(
        Offset(w7, h60),
        radius: Radius.elliptical(w25, h25),
      );

    animatePath(
      _nosePathInner,
      _outlinePaint
        ..strokeWidth = w5
        ..color = Colors.yellow[300]!
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
      canvas,
      noseProgress,
    );

    Path _nosePath = Path()
      ..moveTo(-w5, h50)
      ..quadraticBezierTo(-w10, h20, w10, h15)
      ..moveTo(w10, h15)
      ..arcToPoint(Offset(w7, h60), radius: Radius.elliptical(w30, h25));

    animatePath(
      _nosePath,
      _outlinePaint
        ..strokeWidth = w5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
      canvas,
      noseProgress,
    );
  }

  void _drawMouth(Canvas canvas) {
    _drawLip(canvas);

    _drawLeftCheek(canvas);

    _drawRightCheek(canvas);

    _drawTooth(canvas);

    _drawTooth(canvas, position: -1);
  }

  void _drawLip(Canvas canvas) {
    // Mouth draws after eyes/nose.
    final mouthProgress = _segment(0.40, 0.70);

    final closedLipDx = h140;
    final openLipDx = computeRangeMinMax(eyeValue, h140, h220);
    final fillupCount = (openLipDx - closedLipDx) ~/ w6;

    final x1 = -computeRangeMinMax(frownMouthValue, w100, w50),
        y1 = computeRangeMinMax(frownMouthValue, h55, h100);
    final x2 = w5,
        y2 = computeRangeMinMax(frownMouthValue, closedLipDx, h90),
        y2Open = computeRangeMinMax(frownMouthValue, openLipDx, h90);
    final x3 = computeRangeMinMax(frownMouthValue, w100, h50),
        y3 = computeRangeMinMax(frownMouthValue, h55, h100);



    Path _mouthPath = Path()
      ..moveTo(x1, y1)
      ..quadraticBezierTo(x2, y2, x3, y3);

    animatePath(
      _mouthPath,
      _outlinePaint,
      canvas,
      mouthProgress,
    );

    final mouthOpenPath = Path()
      ..moveTo(x1, y1)
      ..quadraticBezierTo(x2, y2Open, x3, y3);

    animatePath(
      mouthOpenPath,
      _outlinePaint,
      canvas,
      mouthProgress,
    );

    for (int i = fillupCount - 1; i > 1; i--) {
      animatePath(
        Path()
          ..moveTo(-w100, h55)
          ..quadraticBezierTo(w5, closedLipDx + (i * w6), w100, h55),
        _outlinePaint..color = const Color(0xff550015),
        canvas,
        mouthProgress,
      );
    }

    final smilePaint = _outlinePaint
      ..strokeWidth = w4
      ..color =
          Colors.black.withOpacity(computeRangeMinMax(frownMouthValue, 1, 0));

    final leftSmilePath = Path()
      ..moveTo(-w80, h55)
      ..arcToPoint(
        Offset(-w100, h70),
        radius: Radius.elliptical(w12, h10),
        clockwise: false,
      );

    final rightSmilePath = Path()
      ..moveTo(w80, h55)
      ..arcToPoint(
        Offset(w100, h70),
        radius: Radius.elliptical(w12, h10),
        clockwise: true,
      );

    // Animate just the smile "strokes" too (late mouth segment).
    animatePath(leftSmilePath, smilePaint, canvas, mouthProgress);
    animatePath(rightSmilePath, smilePaint, canvas, mouthProgress);
  }

  void _drawLeftCheek(Canvas canvas) {
    final cheekProgress = _segment(0.55, 0.78);

    final _cheekInner = Path()
      ..moveTo(-w130, h20)
      ..conicTo(w70, h40, -w80, h55, 0.1);

    animatePath(
      _cheekInner,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w13
        ..color = Colors.yellow[300]!
            .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0)),
      canvas,
      cheekProgress,
    );

    _drawCheek(canvas, position: -1);

    _drawDotsOnCheek(canvas, position: -1);
  }

  void _drawRightCheek(Canvas canvas) {
    final cheekProgress = _segment(0.55, 0.78);

    final _cheekInner = Path()
      ..moveTo(w120, h30)
      ..conicTo(w45, 0, w75, h60, 0.14);

    animatePath(
      _cheekInner,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w13
        ..color = Colors.yellow[300]!
            .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0)),
      canvas,
      cheekProgress,
    );

    _drawCheek(canvas);

    _drawDotsOnCheek(canvas);
  }

  void _drawCheek(Canvas canvas, {double position = 1}) {
    final cheekProgress = _segment(0.60, 0.82);

    final _cheeksPaint = Paint()
      ..strokeWidth = w5
      ..color = const Color(0xffA05729)
          .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    animatePath(
      Path()
        ..moveTo(w70 * position, h50)
        ..cubicTo(w110 * position, -h10, w160 * position, h70,
            w110 * position, h78),
      _cheeksPaint,
      canvas,
      cheekProgress,
    );
  }

  void _drawDotsOnCheek(Canvas canvas, {double position = 1}) {
    final dotsProgress = _segment(0.70, 0.90);
    if (dotsProgress <= 0.75) return;

    final _dotsOnCheekPaint = Paint()
      ..color = const Color(0xffA05729)
      ..strokeWidth = w3
      ..style = PaintingStyle.fill;

    final dotOnCheekRadius = w3;
    canvas.drawOval(
      Rect.fromCircle(
          center: Offset(w120 * position, h50), radius: dotOnCheekRadius),
      _dotsOnCheekPaint,
    );
    canvas.drawOval(
      Rect.fromCircle(
          center: Offset(w108 * position, h50), radius: dotOnCheekRadius),
      _dotsOnCheekPaint,
    );
    canvas.drawOval(
      Rect.fromCircle(
          center: Offset(w108 * position, h40), radius: dotOnCheekRadius),
      _dotsOnCheekPaint,
    );
  }

  void _drawTooth(Canvas canvas, {double position = 1}) {
    final toothProgress = _segment(0.70, 0.90);

    final toothPath = Path()
      ..moveTo(w30 * position, h95)
      ..lineTo(w28 * position, h115)
      ..moveTo(w28 * position, h115)
      ..lineTo(w5 * position, h115)
      ..moveTo(w5 * position, h115)
      ..lineTo(w5 * position, h100)
      ..close();

    animatePath(
      toothPath,
      _outlinePaint
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
      canvas,
      toothProgress,
    );

    // Tooth fill pops in after outline is mostly done.
    if (toothProgress > 0.85) {
      canvas.drawRect(
        Rect.fromPoints(
            Offset(w27 * position, h98), Offset(w9 * position, h112)),
        Paint()..color = Colors.white,
      );
    }
  }

  void _drawHands(Canvas canvas) {
    _drawHand(canvas);

    _drawHand(canvas, position: -1);
  }

  void _drawHand(Canvas canvas, {double position = 1}) {
    final handProgress = _segment(0.20, 0.55);

    var shirtHandPath = Path()
      ..moveTo(w150 * position, h20)
      ..conicTo(w190 * position, h30, h170 * position, h70, 0.2)
      ..conicTo(w10 * position, h100, w130 * position, h70, 0.1)
      ..conicTo(w90 * position, h70, w150 * position, h20, 0.2);

    animatePath(
      shirtHandPath,
      _outlinePaint..strokeWidth = w7,
      canvas,
      handProgress,
    );

    // Shirt fill after most of outline is there.
    if (handProgress > 0.85) {
      canvas.drawPath(
        shirtHandPath,
        _outlinePaint
          ..strokeWidth = w3
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );
    }

    final armPath = Path()
      ..moveTo(w160 * position, h75)
      ..lineTo(w155 * position, h150)
      ..cubicTo(w160 * position, h150, w170 * position, h190,
          w125 * position, h210)
      ..moveTo(w140 * position, h200)
      ..cubicTo(w100 * position, h230, w120 * position, h195,
          w140 * position, h190)
      ..moveTo(w125 * position, h190)
      ..cubicTo(w100 * position, h200, w120 * position, h210,
          w120 * position, h200)
      ..moveTo(w120 * position, h185)
      ..cubicTo(w100 * position, h200, w110 * position, h200,
          w115 * position, h195)
      ..moveTo(w120 * position, h185)
      ..conicTo(w130 * position, h130, w140 * position, h155, 0.1)
      ..lineTo(w145 * position, h75);

    animatePath(
      armPath,
      _outlinePaint..strokeWidth = w4,
      canvas,
      handProgress,
    );
  }

  void _drawBody(Size size, Canvas canvas) {
    // Body/header strokes should animate later in the sequence.
    final bodyProgress = _segment(0.50, 1.0);

    final pointWidth = size.width ~/ w40;

    final paint = Paint()
      ..color = const Color(0xff9B870C)
      ..strokeWidth = h6
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final List<Offset> horizontalPoints = [];
    final List<Offset> topHorizontalPoints = [];

    for (int i = 1; i <= pointWidth; i++) {
      horizontalPoints
          .add(Offset((i * w40) - (size.width / 2), i % 2 == 0 ? -h7 : h7));
      topHorizontalPoints.add(Offset(
          (i * w40) - (size.width / 2),
          i == 1
              ? h4
              : i % 2 == 0
                  ? h4
                  : -h4));
    }

    final horizontalCatmulSpline = CatmullRomSpline(horizontalPoints);
    final _horizontalSplinePoints =
        horizontalCatmulSpline.generateSamples().toList();

    _drawShirt(_horizontalSplinePoints, canvas);

    // Animate the "header" point bands by progressively revealing points.
    final bandProgress = _segment(0.58, 0.92);

    _drawProgressivePoints(
      canvas,
      points: _horizontalSplinePoints.map((e) => e.value.translate(0, h35)).toList(),
      paint: _outlinePaint
        ..strokeWidth = w30
        ..strokeCap = StrokeCap.round
        ..color = Colors.yellow[300]!,
      progress: bandProgress,
    );

    _drawProgressivePoints(
      canvas,
      points: _horizontalSplinePoints.map((e) => e.value.translate(0, h55)).toList(),
      paint: paint,
      progress: bandProgress,
    );

    _drawTopWavyLine(topHorizontalPoints, canvas, paint);

    _drawLeftWaveLine(size, canvas, paint);

    _drawRightWaveLine(size, canvas, paint);

    if (bodyProgress > 0.55) {
      _drawBodyPores(canvas);
      _drawChin(canvas);
      _drawChin(canvas, position: -1);
    }
  }

  void _drawShirt(List<Curve2DSample> _splinePoints, Canvas canvas) {
    final shirtProgress = _segment(0.55, 0.95);

    var first = _splinePoints.first.value;
    var last = _splinePoints.last.value;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = h10
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    Path _shirtPath = Path()..moveTo(first.dx, h100);
    for (var val in _splinePoints) {
      final offset = val.value.translate(0, h57);
      final lastOffset = last.translate(0, h57);

      var dx = offset.dx;
      var dy = offset.dy;
      _shirtPath
        ..lineTo(dx, dy + h20)
        ..moveTo(dx, dy);
      if (offset == lastOffset) {
        _shirtPath
          ..lineTo(dx, h100)
          ..lineTo(first.dx, h100);
      }
    }

    animatePath(_shirtPath, paint, canvas, shirtProgress);

    // Shirt fill appears after outline is mostly done.
    if (shirtProgress > 0.85) {
      canvas.drawRect(
        Rect.fromPoints(first.translate(0, h50), last.translate(0, h110)),
        paint..style = PaintingStyle.fill,
      );
    }

    // Bottom black line
    animatePath(
      Path()
        ..moveTo(first.translate(-w5, h100).dx, first.translate(-w5, h100).dy)
        ..lineTo(last.translate(w5, h115).dx, last.translate(w5, h115).dy),
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.black
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = w7,
      canvas,
      _segment(0.70, 0.98),
    );

    _drawColar(canvas);
    _drawColar(canvas, position: -1);

    if (shirtProgress > 0.80) {
      canvas.drawRect(
        Rect.fromPoints(Offset(-w145, h110), Offset(w148, h165)),
        Paint()..color = const Color(0xffA05729),
      );
    }

    // Decorative + border lines (convert drawLine -> animatePath)
    final borderProgress = _segment(0.75, 1.0);

    animatePath(
      Path()..moveTo(-w130, h125)..lineTo(-w80, h125),
      _outlinePaint..strokeWidth = w10,
      canvas,
      borderProgress,
    );
    animatePath(
      Path()..moveTo(-w70, h125)..lineTo(w10, h125),
      _outlinePaint..strokeWidth = w10,
      canvas,
      borderProgress,
    );
    animatePath(
      Path()..moveTo(w20, h125)..lineTo(w70, h125),
      _outlinePaint..strokeWidth = w10,
      canvas,
      borderProgress,
    );
    animatePath(
      Path()..moveTo(w80, h125)..lineTo(w130, h125),
      _outlinePaint..strokeWidth = w10,
      canvas,
      borderProgress,
    );

    _drawTie(canvas);

    animatePath(
      Path()..moveTo(-w145, h65)..lineTo(-w145, h165),
      _outlinePaint
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
      canvas,
      borderProgress,
    );

    animatePath(
      Path()..moveTo(w145, h50)..lineTo(w145, h165),
      _outlinePaint
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
      canvas,
      borderProgress,
    );

    animatePath(
      Path()..moveTo(-w145, h165)..lineTo(w145, h165),
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.black
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = w7,
      canvas,
      borderProgress,
    );
  }

  void _drawColar(Canvas canvas, {double position = 1}) {
    final collarProgress = _segment(0.62, 0.92);

    Path _colarPath = Path()
      ..moveTo((position.isNegative ? w55 : w60) * position,
          position.isNegative ? h65 : h50)
      ..lineTo(w30 * position, h90)
      ..lineTo(0, h55);

    animatePath(
      _colarPath,
      _outlinePaint
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
      canvas,
      collarProgress,
    );
  }

  void _drawTie(Canvas canvas) {
    final tieProgress = _segment(0.78, 1.0);

    final tieStrokePaint = _outlinePaint
      ..strokeWidth = w10
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // Convert the tie lines to paths so they animate.
    animatePath(Path()..moveTo(-w15, h80)..lineTo(-w30, h140), tieStrokePaint,
        canvas, tieProgress);
    animatePath(Path()..moveTo(-w30, h140)..lineTo(0, h160), tieStrokePaint,
        canvas, tieProgress);
    animatePath(Path()..moveTo(w30, h140)..lineTo(0, h160), tieStrokePaint,
        canvas, tieProgress);
    animatePath(Path()..moveTo(w15, h80)..lineTo(w30, h140), tieStrokePaint,
        canvas, tieProgress);

    final tiePaint = _outlinePaint
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = Colors.red;

    if (tieProgress > 0.65) {
      int index = 1;
      for (int i = 25; i >= 0; i -= 5) {
        final substract = index * w5;
        canvas
          ..drawLine(Offset(-w15 + substract, h80),
              Offset(-w30 + substract, h140), tiePaint)
          ..drawLine(
              Offset(-w30 + substract, h140), Offset(0, h155), tiePaint)
          ..drawLine(
              Offset(w30 - substract, h140), Offset(0, h155), tiePaint)
          ..drawLine(Offset(w15 - substract, h80),
              Offset(w30 - substract, h140), tiePaint);
        index++;
      }
    }

    // Ovals are not paths; show them when the tie is mostly drawn.
    if (tieProgress > 0.85) {
      canvas.drawOval(
          Rect.fromPoints(Offset(-w20, h58), Offset(w20, h90)), _outlinePaint);

      canvas.drawOval(
        Rect.fromPoints(Offset(-w18, h60), Offset(w18, h87)),
        Paint()..color = Colors.red,
      );
    }
  }

  void _drawTopWavyLine(
    List<Offset> topHorizontalPoints,
    Canvas canvas,
    Paint paint,
  ) {
    final waveProgress = _segment(0.62, 0.95);

    final topSplinePoint =
        CatmullRomSpline(topHorizontalPoints).generateSamples().toList();

    // Convert the sampled points into a polyline path so we can animate it.
    final path = Path();
    if (topSplinePoint.isNotEmpty) {
      final first = topSplinePoint.first.value.translate(0, -h230);
      path.moveTo(first.dx, first.dy);
      for (final sample in topSplinePoint.skip(1)) {
        final p = sample.value.translate(0, -h230);
        path.lineTo(p.dx, p.dy);
      }
    }

    animatePath(path, paint, canvas, waveProgress);
  }

  void _drawLeftWaveLine(Size size, Canvas canvas, Paint paint) {
    final waveProgress = _segment(0.62, 0.95);

    final pointHeight = (size.height * 0.5) ~/ w30;

    final List<Offset> verticalPoints = [];
    for (int i = 1; i <= pointHeight; i++) {
      var last = i == pointHeight;
      verticalPoints.add(Offset(
          last
              ? h2_5
              : i % 2 == 0
                  ? -h2_5
                  : h2_5,
          (i * w40) - (size.height / 2)));
    }

    final verticalCatmulSpline = CatmullRomSpline(verticalPoints);
    final _verticalSplinePoints =
        verticalCatmulSpline.generateSamples().toList();

    final firstVert = _verticalSplinePoints.first.value.translate(-w150, -h10);

    Path verticalWavePath = Path()
      ..moveTo(firstVert.dx + w10, firstVert.dy - h6);

    for (var val in _verticalSplinePoints) {
      final valOffset = val.value.translate(-w150, -h10);
      verticalWavePath
        ..lineTo(valOffset.dx, valOffset.dy)
        ..moveTo(valOffset.dx, valOffset.dy);
    }

    animatePath(verticalWavePath, paint, canvas, waveProgress);
  }

  void _drawRightWaveLine(Size size, Canvas canvas, Paint paint) {
    final waveProgress = _segment(0.62, 0.95);

    final pointHeight = (size.height * 0.45) ~/ w30;

    final List<Offset> verticalPoints = [];
    for (int i = 1; i <= pointHeight; i++) {
      var last = i == pointHeight;
      verticalPoints.add(Offset(
          last
              ? -h2_5
              : i % 2 == 0
                  ? h2_5
                  : -h2_5,
          (i * w40) - (size.height / 2)));
    }

    final verticalCatmulSpline = CatmullRomSpline(verticalPoints);
    final _verticalSplinePoints =
        verticalCatmulSpline.generateSamples().toList();

    final firstVert = _verticalSplinePoints.first.value.translate(w160, -h15);

    Path verticalWavePath = Path()..moveTo(firstVert.dx - w10, firstVert.dy);

    for (var val in _verticalSplinePoints) {
      final valOffset = val.value.translate(w150, h15);
      verticalWavePath
        ..lineTo(valOffset.dx, valOffset.dy)
        ..moveTo(valOffset.dx, valOffset.dy);
    }

    animatePath(verticalWavePath, paint, canvas, waveProgress);
  }

  void _drawBodyPores(Canvas canvas) {
    canvas.save();

    canvas.rotate(-maths.pi / 4);
    final dotsPaint = Paint()
      ..color = const Color(0x773e550c)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
        Rect.fromCenter(center: Offset(-w90, -h70), width: w40, height: h30),
        dotsPaint);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(w70, h90), width: w40, height: h30),
        dotsPaint);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(w60, -h220), width: w40, height: h30),
        dotsPaint);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(w30, -h200), width: w15, height: h10),
        dotsPaint);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(w50, h110), width: w15, height: h10),
        dotsPaint);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(w230, -h60), width: w40, height: h30),
        dotsPaint);
    canvas.restore();
  }

  void _drawChin(Canvas canvas, {double position = 1}) {
    final _paint = Paint()
      ..color = const Color(0xffff7d63)
      ..strokeWidth = w3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
      Path()
        ..moveTo(w40 * position, h10)
        ..conicTo(w40 * position, h50, 0, h15, 0.4),
      _paint,
    );
  }

  void _drawLegs(Canvas canvas) {
    _drawLeg(canvas);

    _drawLeg(canvas, position: -1);
  }

  void _drawLeg(Canvas canvas, {double position = 1}) {
    final legProgress = _segment(0.78, 1.0);

    animatePath(
      Path()
        ..moveTo(w87 * position, h174)
        ..lineTo(w42 * position, h174),
      Paint()
        ..color = const Color(0xffA05729)
        ..strokeWidth = h12,
      canvas,
      legProgress,
    );

    animatePath(
      Path()
        ..moveTo(w90 * position, h165)
        ..lineTo(
          w90 * position,
          h180,
        )
        ..conicTo(w80 * position, h210, w40 * position, h180, 0.1)
        ..lineTo(w40 * position, h165),
      _outlinePaint,
      canvas,
      legProgress,
    );

    animatePath(
      Path()
        ..moveTo(w60 * position, h185)
        ..conicTo(w30 * position, h200, w60 * position, h260, 0.2)
        ..moveTo(w70 * position, h185)
        ..conicTo(w45 * position, h200, w70 * position, h265, 0.2),
      _outlinePaint
        ..strokeCap = StrokeCap.square
        ..strokeWidth = w4,
      canvas,
      legProgress,
    );

    _drawSock(canvas, position);

    _drawShoe(canvas, position: position);
  }

  void _drawSock(Canvas canvas, double position) {
    final sockProgress = _segment(0.80, 1.0);

    animatePath(
      Path()
        ..moveTo(w62 * position, h225)
        ..conicTo(w40 * position, h255, w65 * position, h260, 0.1),
      _outlinePaint
        ..strokeCap = StrokeCap.square
        ..color = Colors.white
        ..strokeWidth = w5,
      canvas,
      sockProgress,
    );

    animatePath(
      Path()
        ..moveTo(w55 * position, h225)
        ..lineTo(w65 * position, h225),
      _outlinePaint..strokeWidth = w2_5,
      canvas,
      sockProgress,
    );

    animatePath(
      Path()
        ..moveTo(w57 * position, h235)
        ..lineTo(w65 * position, h235),
      _outlinePaint
        ..strokeWidth = w2_5
        ..color = Colors.blue,
      canvas,
      sockProgress,
    );

    animatePath(
      Path()
        ..moveTo(w57 * position, h245)
        ..lineTo(w65 * position, h245),
      _outlinePaint
        ..strokeWidth = w2_5
        ..color = Colors.red,
      canvas,
      sockProgress,
    );
  }

  void _drawShoe(Canvas canvas, {required double position}) {
    final shoeProgress = _segment(0.86, 1.0);

    final shoePath = Path()
      ..moveTo(w60 * position, h260)
      ..lineTo(w85 * position, h270)
      ..cubicTo(w130 * position, h220, w150 * position, h330,
          w65 * position, h290)
      ..lineTo(w65 * position, h297)
      ..lineTo(w45 * position, h297)
      ..conicTo(w30 * position, h240, w65 * position, h265, 0.5)
      ..close();

    // Draw shoe fill once most stroke is there.
    if (shoeProgress > 0.75) {
      canvas.drawPath(shoePath, _outlinePaint..style = PaintingStyle.fill);
    }

    // Shoe highlight pops in at the end.
    if (shoeProgress > 0.9) {
      canvas.drawOval(
        Rect.fromPoints(
            Offset(w100 * position, h265), Offset(w115 * position, h270)),
        Paint()..color = Colors.white,
      );
    }
  }

  Paint get _outlinePaint => Paint()
    ..color = Colors.black
    ..strokeWidth = w6
    ..style = PaintingStyle.stroke;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

