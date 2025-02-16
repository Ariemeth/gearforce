import 'package:flutter/material.dart';

class DisplayLayoutConstraints extends StatelessWidget {
  const DisplayLayoutConstraints({
    super.key,
    required this.minScreenWidth,
    required this.maxScreenWidth,
    required this.minScreenHeight,
    required this.maxScreenHeight,
    this.padding = const EdgeInsets.all(8.0),
  });

  final double minScreenWidth;
  final double maxScreenWidth;
  final double minScreenHeight;
  final double maxScreenHeight;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text('W:$minScreenWidth/$maxScreenWidth'),
          ),
          Center(
            child: Text('H:$minScreenHeight/$maxScreenHeight'),
          ),
        ],
      ),
    );
  }
}
