import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeumorConverter extends StatelessWidget {
  const NeumorConverter({
    Key? key,
    required this.principalColor,
    this.isButton = false,
    required this.child,
    this.padding = 50,
  })  : assert(principalColor != null),
        assert(isButton != null),
        super(key: key);
  final MaterialColor principalColor;
  final bool isButton;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: principalColor[300],
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]),
    );
  }
}
