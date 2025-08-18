import 'package:flutter/material.dart';

class DisplayLayoutConstraints extends StatelessWidget {
  const DisplayLayoutConstraints({
    super.key,
    required this.maxScreenWidth,
    required this.maxScreenHeight,
    this.padding = const EdgeInsets.all(8.0),
  });

  final double maxScreenWidth;
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
            child: Text(
                'W:${maxScreenWidth.floor()} | H:${maxScreenHeight.floor()}'),
          ),
        ],
      ),
    );
  }
}
