import 'package:flutter/material.dart';

class CustomIconViewPaint extends CustomPainter {
  final double firstAnimationValue;
  final double secondAnimationValue;
  final double widgetSize;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  Path _path;

  CustomIconViewPaint({
    @required this.firstAnimationValue,
    @required this.secondAnimationValue,
    @required this.widgetSize,
    @required this.color,
    @required this.strokeColor,
    this.strokeWidth = 5.0,
  });

  double get zero => strokeWidth / 2;

  double get step => 0.2;

  double get rectSize => widgetSize * 0.37;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size(widgetSize, widgetSize);

    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = color ?? Colors.black;

    final Paint paintStroke = Paint()
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = strokeColor ?? Colors.black;
    _drawPath(canvas, paint, paintStroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawPath(Canvas canvas, Paint paint, Paint paintStroke) {
    canvas.save();
    _path = Path();
    canvas.restore();

    createCube(
      checkValue: step * 2,
    );
    createCube(
      checkValue: step,
      x: widgetSize - rectSize,
    );
    createCube(
      checkValue: step * 3,
      y: widgetSize - rectSize,
    );
    createCube(
      checkValue: step * 4,
      x: widgetSize - rectSize,
      y: widgetSize - rectSize,
    );

    canvas.drawPath(_path, paintStroke);
    canvas.drawPath(_path, paint);
  }

  void createCube({
    double x = 0,
    double y = 0,
    double checkValue = 0,
  }) {
    final double reverseSecondValue = (1 - firstAnimationValue);
    final double halfRectSize = widgetSize / 2;

    final double volume = reverseSecondValue * 0.7 + 0.3;
    final double dynamicSize = rectSize * volume;

    // x actions
    final double valueX = x == 0 ? x + zero : x - zero;
    final double moveXValue = reverseSecondValue * valueX;
    final double moveXAdditionalPadding = moveXValue < zero ? zero - moveXValue : 0;
    final double moveX = moveXValue + moveXAdditionalPadding;

    //y actions
    final double valueY = y == 0 ? y + zero : y - zero;
    final double getUnderMiddleSizeY = valueY + firstAnimationValue * (halfRectSize - dynamicSize * (x == 0 ? 1.8 : 3.8));
    final double getUpperMiddleSizeY = valueY - firstAnimationValue * (halfRectSize - (halfRectSize - dynamicSize * (x == 0 ? 0.4 : -1.6)));
    final double newValueY = valueY > halfRectSize ? getUpperMiddleSizeY : getUnderMiddleSizeY;

    _path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(moveX, newValueY),
          Offset(moveX + dynamicSize, newValueY + dynamicSize),
        ),
        Radius.circular(1.0),
      ),
    );

    if (firstAnimationValue == 1 && secondAnimationValue >= checkValue) {

      double animatedValue = (secondAnimationValue - checkValue) / step ;
      animatedValue = animatedValue > 1 ? 1 : animatedValue;

      createRect(
        x: moveX + (dynamicSize * 2) * animatedValue,
        y: newValueY,
        height: dynamicSize,
        width: dynamicSize * 6.4 * animatedValue,
      );
    }
  }

  void createRect({
    @required double x,
    @required double y,
    @required double height,
    @required double width,
  }) {
    _path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(x, y),
          Offset(x + width, y + height),
        ),
        Radius.circular(2.0),
      ),
    );
  }
}
