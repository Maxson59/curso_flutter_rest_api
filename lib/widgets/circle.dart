import 'package:flutter/material.dart';


class Circle extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const Circle({
    super.key,
    required this.size,
    required this.colors
  }):assert(size > 0),
  assert(colors.length>=2);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.orange,
        shape:  BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );
  }
}