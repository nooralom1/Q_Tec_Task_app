import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? image;
  const Background({super.key, required this.child,
    this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image??"assets/images/background_1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
