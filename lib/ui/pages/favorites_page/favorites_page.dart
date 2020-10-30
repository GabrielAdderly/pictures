import 'package:flutter/material.dart';
import 'package:pictures_view/pic_main_lib.dart';
import 'package:pictures_view/ui/layouts/appbars/empty_appbar.dart';

class FavoritesPage extends PageWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  PreferredSizeWidget buildAppBar(Dictionary dictionary) {
    return EmptyAppbar();
  }

  @override
  Widget buildBody(BuildContext context, CustomTheme theme, Dictionary dictionary) {
    return Center(
      child: CustomPaint(
        child: SizedBox(
          height: 200.0,
          width: 200.0,
        ),
        painter: TearPainter(),
      ),
    );
  }
}

class TearPainter extends CustomPainter {
  Path _path;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    final Paint paintStroke = Paint()
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..color = AppColors.kBlue;
    _path = Path();

    _path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: 40.0,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}