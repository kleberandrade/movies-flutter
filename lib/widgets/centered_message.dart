import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final Color color;
  final double iconSize;
  final IconData icon;
  final double space;
  final EdgeInsets padding;

  const CenteredMessage({
    Key key,
    @required this.message,
    this.color = Colors.white24,
    this.iconSize = 64.0,
    this.icon = Icons.warning,
    this.space = 10.0,
    this.padding = const EdgeInsets.all(20.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildIcon(),
          SizedBox(height: space),
          _buidlText(),
        ],
      ),
    );
  }

  _buildIcon() {
    return Icon(
      icon,
      color: color,
      size: iconSize,
    );
  }

  _buidlText() {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
    );
  }
}
