import 'package:flutter/material.dart';

class CustomPageTransition extends StatelessWidget {
  final Widget child;
  final bool isSwipingLeft;
  final Animation<double> animation;
  final Key key;

  const CustomPageTransition({
    required this.child,
    required this.isSwipingLeft,
    required this.animation,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final begin = isSwipingLeft
        ? Offset(0.0, -1.0) // Swipe left, move up
        : Offset(0.0, 1.0); // Swipe right, move down
    final end = Offset.zero;
    final curve = Curves.easeOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
