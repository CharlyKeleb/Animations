import 'dart:math' as maths;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_project/spongebob/size_config.dart';

class SpongeBob extends CustomPainter with SizesHelper, Mathshelper {
  final double eyeValue;
  final double frownMouthValue;

  SpongeBob({
    required this.eyeValue,
    required this.frownMouthValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    initSize(size);

    canvas.drawPaint(Paint()..color = Colors.yellow[300]!);

    canvas.translate(size.width / 2, size.height / 2);

    _drawFace(canvas, size);

    _drawHands(canvas);

    _drawBody(size, canvas);

    _drawLegs(canvas);
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

    canvas.drawPath(
        Path()
          ..moveTo(-distanceBetweenPupils, -h10)
          ..lineTo(
            w6 - distanceBetweenPupils,
            -computeRangeMinMax(eyeValue, h50, h60),
          ),
        outlinePaint);

    canvas.drawPath(
        Path()
          ..moveTo(-w10 - distanceBetweenPupils, -h10)
          ..lineTo(
            -w35 - distanceBetweenPupils,
            -computeRangeMinMax(eyeValue, h40, h50),
          ),
        outlinePaint);

    canvas.drawPath(
        Path()
          ..moveTo(w20 - distanceBetweenPupils, -h10)
          ..lineTo(
            w46 - distanceBetweenPupils,
            -computeRangeMinMax(eyeValue, h35, h45),
          ),
        outlinePaint);

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

      canvas.drawPath(
        Path()
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
          ),
        _outlinePaint
          ..color = const Color(0xff333333)
              .withOpacity(computeRangeMinMax(eyeValue, 1, 0))
          ..strokeCap = StrokeCap.round
          ..strokeWidth = w4,
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

      canvas.drawPath(
        Path()
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
          ),
        _outlinePaint
          ..color = const Color(0xff333333)
              .withOpacity(computeRangeMinMax(eyeValue, 1, 0))
          ..strokeCap = StrokeCap.round
          ..strokeWidth = w4,
      );
    }
  }

  void _drawNose(Canvas canvas) {
    Path _nosePathInner = Path()
      ..moveTo(w3, h15)
      ..arcToPoint(
        Offset(w7, h60),
        radius: Radius.elliptical(w25, h25),
      );

    canvas.drawPath(
      _nosePathInner,
      _outlinePaint
        ..strokeWidth = w5
        ..color = Colors.yellow[300]!
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
    Path _nosePath = Path()
      ..moveTo(-w5, h50)
      ..quadraticBezierTo(-w10, h20, w10, h15)
      ..moveTo(w10, h15)
      ..arcToPoint(Offset(w7, h60), radius: Radius.elliptical(w30, h25));

    canvas.drawPath(
      _nosePath,
      _outlinePaint
        ..strokeWidth = w5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
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

    canvas.drawPath(
      _mouthPath,
      _outlinePaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(x1, y1)
        ..quadraticBezierTo(x2, y2Open, x3, y3),
      _outlinePaint,
    );

    for (int i = fillupCount - 1; i > 1; i--) {
      canvas.drawPath(
        Path()
          ..moveTo(-w100, h55)
          ..quadraticBezierTo(w5, closedLipDx + (i * w6), w100, h55),
        _outlinePaint..color = const Color(0xff550015),
      );
    }

    final smilePaint = _outlinePaint
      ..strokeWidth = w4
      ..color =
          Colors.black.withOpacity(computeRangeMinMax(frownMouthValue, 1, 0));

    canvas.drawPath(
      Path()
        ..moveTo(-w80, h55)
        ..arcToPoint(
          Offset(-w100, h70),
          radius: Radius.elliptical(w12, h10),
          clockwise: false,
        ),
      smilePaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(w80, h55)
        ..arcToPoint(
          Offset(w100, h70),
          radius: Radius.elliptical(w12, h10),
          clockwise: true,
        ),
      smilePaint,
    );
  }

  void _drawLeftCheek(Canvas canvas) {
    final _cheekInner = Path()
      ..moveTo(-w130, h20)
      ..conicTo(w70, h40, -w80, h55, 0.1);
    canvas.drawPath(
      _cheekInner,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w13
        ..color = Colors.yellow[300]!
            .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0)),
    );

    _drawCheek(canvas, position: -1);

    _drawDotsOnCheek(canvas, position: -1);
  }

  void _drawRightCheek(Canvas canvas) {
    final _cheekInner = Path()
      ..moveTo(w120, h30)
      ..conicTo(w45, 0, w75, h60, 0.14);
    canvas.drawPath(
      _cheekInner,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w13
        ..color = Colors.yellow[300]!
            .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0)),
    );

    _drawCheek(canvas);

    _drawDotsOnCheek(canvas);
  }

  void _drawCheek(Canvas canvas, {double position = 1}) {
    final _cheeksPaint = Paint()
      ..strokeWidth = w5
      ..color = const Color(0xffA05729)
          .withOpacity(computeRangeMinMax(frownMouthValue, 1, 0))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(
        Path()
          ..moveTo(w70 * position, h50)
          ..cubicTo(w110 * position, -h10, w160 * position, h70,
              w110 * position, h78),
        _cheeksPaint);
  }

  void _drawDotsOnCheek(Canvas canvas, {double position = 1}) {
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
    canvas.drawPath(
      Path()
        ..moveTo(w30 * position, h95)
        ..lineTo(w28 * position, h115)
        ..moveTo(w28 * position, h115)
        ..lineTo(w5 * position, h115)
        ..moveTo(w5 * position, h115)
        ..lineTo(w5 * position, h100)
        ..close(),
      _outlinePaint
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawRect(
        Rect.fromPoints(
            Offset(w27 * position, h98), Offset(w9 * position, h112)),
        Paint()..color = Colors.white);
  }

  void _drawHands(Canvas canvas) {
    _drawHand(canvas);

    _drawHand(canvas, position: -1);
  }

  void _drawHand(Canvas canvas, {double position = 1}) {
    var shirtHandPath = Path()
      ..moveTo(w150 * position, h20)
      ..conicTo(w190 * position, h30, h170 * position, h70, 0.2)
      ..conicTo(w10 * position, h100, w130 * position, h70, 0.1)
      ..conicTo(w90 * position, h70, w150 * position, h20, 0.2);
    canvas.drawPath(shirtHandPath, _outlinePaint..strokeWidth = w7);

    canvas.drawPath(
      shirtHandPath,
      _outlinePaint
        ..strokeWidth = w3
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
        Path()
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
          ..lineTo(w145 * position, h75),
        _outlinePaint..strokeWidth = w4);
  }

  void _drawBody(Size size, Canvas canvas) {
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

    canvas.drawPoints(
      PointMode.points,
      _horizontalSplinePoints.map((e) => e.value.translate(0, h35)).toList(),
      _outlinePaint
        ..strokeWidth = w30
        ..strokeCap = StrokeCap.round
        ..color = Colors.yellow[300]!,
    );

    canvas.drawPoints(
      PointMode.points,
      _horizontalSplinePoints.map((e) => e.value.translate(0, h55)).toList(),
      paint,
    );

    _drawTopWavyLine(topHorizontalPoints, canvas, paint);

    _drawLeftWaveLine(size, canvas, paint);

    _drawRightWaveLine(size, canvas, paint);

    _drawBodyPores(canvas);

    _drawChin(canvas);

    _drawChin(canvas, position: -1);
  }

  void _drawShirt(List<Curve2DSample> _splinePoints, Canvas canvas) {
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
    canvas.drawPath(
      _shirtPath,
      paint,
    );

    canvas.drawRect(
        Rect.fromPoints(first.translate(0, h50), last.translate(0, h110)),
        paint..style = PaintingStyle.fill);

    canvas.drawLine(
      first.translate(-w5, h100),
      last.translate(w5, h115),
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.black
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = w7,
    );

    _drawColar(canvas);

    _drawColar(canvas, position: -1);

    canvas.drawRect(Rect.fromPoints(Offset(-w145, h110), Offset(w148, h165)),
        Paint()..color = const Color(0xffA05729));

    canvas.drawLine(Offset(-w130, h125), Offset(-w80, h125),
        _outlinePaint..strokeWidth = w10);

    canvas.drawLine(Offset(-w70, h125), Offset(w10, h125),
        _outlinePaint..strokeWidth = w10);

    canvas.drawLine(
        Offset(w20, h125), Offset(w70, h125), _outlinePaint..strokeWidth = w10);

    canvas.drawLine(Offset(w80, h125), Offset(w130, h125),
        _outlinePaint..strokeWidth = w10);

    _drawTie(canvas);

    canvas.drawLine(
      Offset(-w145, h65),
      Offset(-w145, h165),
      _outlinePaint
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      Offset(w145, h50),
      Offset(w145, h165),
      _outlinePaint
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      Offset(-w145, h165),
      Offset(w145, h165),
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.black
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = w7,
    );
  }

  void _drawColar(Canvas canvas, {double position = 1}) {
    Path _colarPath = Path()
      ..moveTo((position.isNegative ? w55 : w60) * position,
          position.isNegative ? h65 : h50)
      ..lineTo(w30 * position, h90)
      ..lineTo(0, h55);
    canvas.drawPath(
        _colarPath,
        _outlinePaint
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);
  }

  void _drawTie(Canvas canvas) {
    final tieStrokePaint = _outlinePaint
      ..strokeWidth = w10
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawLine(Offset(-w15, h80), Offset(-w30, h140), tieStrokePaint)
      ..drawLine(Offset(-w30, h140), Offset(0, h160), tieStrokePaint)
      ..drawLine(Offset(w30, h140), Offset(0, h160), tieStrokePaint)
      ..drawLine(Offset(w15, h80), Offset(w30, h140), tieStrokePaint);

    final tiePaint = _outlinePaint
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = Colors.red;

    int index = 1;
    for (int i = 25; i >= 0; i -= 5) {
      final substract = index * w5;
      canvas
        ..drawLine(Offset(-w15 + substract, h80),
            Offset(-w30 + substract, h140), tiePaint)
        ..drawLine(Offset(-w30 + substract, h140), Offset(0, h155), tiePaint)
        ..drawLine(Offset(w30 - substract, h140), Offset(0, h155), tiePaint)
        ..drawLine(Offset(w15 - substract, h80), Offset(w30 - substract, h140),
            tiePaint);
      index++;
    }

    canvas.drawOval(
        Rect.fromPoints(Offset(-w20, h58), Offset(w20, h90)), _outlinePaint);

    canvas.drawOval(Rect.fromPoints(Offset(-w18, h60), Offset(w18, h87)),
        Paint()..color = Colors.red);
  }

  void _drawTopWavyLine(
    List<Offset> topHorizontalPoints,
    Canvas canvas,
    Paint paint,
  ) {
    final topSplinePoint =
        CatmullRomSpline(topHorizontalPoints).generateSamples();

    canvas.drawPoints(
      PointMode.points,
      topSplinePoint.map((e) => e.value.translate(0, -h230)).toList(),
      paint,
    );
  }

  void _drawLeftWaveLine(Size size, Canvas canvas, Paint paint) {
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

    canvas.drawPath(
      verticalWavePath,
      paint,
    );
  }

  void _drawRightWaveLine(Size size, Canvas canvas, Paint paint) {
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

    canvas.drawPath(
      verticalWavePath,
      paint,
    );
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
    canvas.drawLine(
        Offset(w87 * position, h174),
        Offset(w42 * position, h174),
        Paint()
          ..color = const Color(0xffA05729)
          ..strokeWidth = h12);

    canvas.drawPath(
        Path()
          ..moveTo(w90 * position, h165)
          ..lineTo(
            w90 * position,
            h180,
          )
          ..conicTo(w80 * position, h210, w40 * position, h180, 0.1)
          ..lineTo(w40 * position, h165),
        _outlinePaint);

    canvas.drawPath(        
        Path()
          ..moveTo(w60 * position, h185)
          ..conicTo(w30 * position, h200, w60 * position, h260, 0.2)
          ..moveTo(w70 * position, h185)
          ..conicTo(w45 * position, h200, w70 * position, h265, 0.2),
        _outlinePaint
          ..strokeCap = StrokeCap.square
          ..strokeWidth = w4);

    _drawSock(canvas, position);

    _drawShoe(canvas, position: position);
  }

  void _drawSock(Canvas canvas, double position) {
    canvas.drawPath(
        Path()
          ..moveTo(w62 * position, h225)
          ..conicTo(w40 * position, h255, w65 * position, h260, 0.1),
        _outlinePaint
          ..strokeCap = StrokeCap.square
          ..color = Colors.white
          ..strokeWidth = w5);

    canvas.drawLine(Offset(w55 * position, h225), Offset(w65 * position, h225),
        _outlinePaint..strokeWidth = w2_5);

    canvas.drawLine(
        Offset(w57 * position, h235),
        Offset(w65 * position, h235),
        _outlinePaint
          ..strokeWidth = w2_5
          ..color = Colors.blue);

    canvas.drawLine(
        Offset(w57 * position, h245),
        Offset(w65 * position, h245),
        _outlinePaint
          ..strokeWidth = w2_5
          ..color = Colors.red);
  }

  void _drawShoe(Canvas canvas, {required double position}) {
    canvas.drawPath(
        Path()
          ..moveTo(w60 * position, h260)
          ..lineTo(w85 * position, h270)
          ..cubicTo(w130 * position, h220, w150 * position, h330,
              w65 * position, h290)
          ..lineTo(w65 * position, h297)
          ..lineTo(w45 * position, h297)
          ..conicTo(w30 * position, h240, w65 * position, h265, 0.5)
          ..close(),
        _outlinePaint..style = PaintingStyle.fill);

    canvas.drawOval(
        Rect.fromPoints(
            Offset(w100 * position, h265), Offset(w115 * position, h270)),
        Paint()..color = Colors.white);
  }

  Paint get _outlinePaint => Paint()
    ..color = Colors.black
    ..strokeWidth = w6
    ..style = PaintingStyle.stroke;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

