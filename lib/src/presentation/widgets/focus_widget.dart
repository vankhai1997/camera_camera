import 'package:flutter/material.dart';

class CameraFocus {
  CameraFocus._();

  static Widget square(
          {required Color color,
          required double width,
          required double height,
          required double hPaint,
          required final String title,
          required final String desc}) =>
      _FocusSquare(
        color: color,
        width: width,
        height: height,
        hPaint: hPaint,
        desc: desc,
        title: title,
      );
}

class _FocusSquare extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final double hPaint;
  final String title;
  final String desc;

  const _FocusSquare(
      {Key? key,
      required this.color,
      required this.width,
      required this.height,
      required this.hPaint,
      required this.desc,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        child: Container(width: width, height: height),
        painter: _SquareModePhoto(
            color: color,
            width: width,
            height: height,
            hPaint: hPaint,
            des: desc,
            title: title),
      ),
    );
  }
}

class _SquareModePhoto extends CustomPainter {
  final Color color;
  final double width;
  final double height;
  final double hPaint;
  final String title;
  final String des;

  _SquareModePhoto(
      {required this.color,
      required this.width,
      required this.height,
      required this.title,
      required this.des,
      required this.hPaint});

  @override
  void paint(Canvas canvas, Size size) {
    //draw focus
    var path = Path();
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(16, size.height / 4.5, size.width - 32, 240),
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    );

    path.fillType = PathFillType.evenOdd;
    path.close();
    final paint = Paint()
      ..color = (color)
      ..strokeWidth = 4;
    canvas.drawPath(path, paint);

    //draw border
    var path2 = Path();
    path2.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(16, size.height / 4.5, size.width - 32, hPaint),
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    );
    Paint paint2 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawPath(path2, paint2);

    //draw des
    final TextPainter desPainter =
        TextPainter(textDirection: TextDirection.ltr);
    desPainter.text = TextSpan(
      text: des,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
    desPainter.textAlign = TextAlign.center;
    desPainter.layout();
    desPainter.paint(
        canvas,
        Offset(
            width / 2 - desPainter.width / 2, size.height / 4.5 + hPaint + 20));
    //draw des
    final TextPainter titlePainter =
        TextPainter(textDirection: TextDirection.ltr);
    titlePainter.text = TextSpan(
      text: title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
    titlePainter.textAlign = TextAlign.center;
    titlePainter.layout();

    titlePainter.paint(canvas,
        Offset(width / 2 - titlePainter.width / 2, size.height / 4.5 - 50));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
