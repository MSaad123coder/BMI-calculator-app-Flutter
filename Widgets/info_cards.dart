import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCards extends StatelessWidget {
  final Widget child;
  final double width, height;

  const InfoCards({
    required this.height,
    required this.width,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
