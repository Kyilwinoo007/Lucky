import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(size.width / 4, 160, size.width / 2, 175);
    path.quadraticBezierTo(3 / 4 * size.width, 190, size.width, 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
class CurveClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 4 * size.height /5);
    Offset curvePoint1 = Offset(size.width/4, size.height);
    Offset centralPoint = Offset(size.width/2,4 * size.height /5);
    path.quadraticBezierTo(curvePoint1.dx, curvePoint1.dy, centralPoint.dx, centralPoint.dy);
    Offset curvePoint2 = Offset(3 * size.width/4, 3 * size.height /5);
    Offset endPoint = Offset(size.width, 4 * size.height /5);
    path.quadraticBezierTo(curvePoint2.dx, curvePoint2.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}