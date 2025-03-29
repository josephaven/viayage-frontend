import 'package:flutter/material.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: TopCurveClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: const Color(0xFF1E2D3F),
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 40);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
