import 'package:digi_clock/components/DigitBar.dart';
import 'package:flutter/material.dart';

var digitBarsArray = [
  [1, 1, 1, 0, 1, 1, 1],
  [0, 0, 1, 0, 0, 1, 0],
  [1, 0, 1, 1, 1, 0, 1],
  [1, 0, 1, 1, 0, 1, 1],
  [0, 1, 1, 1, 0, 1, 0],
  [1, 1, 0, 1, 0, 1, 1],
  [1, 1, 0, 1, 1, 1, 1],
  [1, 0, 1, 0, 0, 1, 0],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 0, 1, 1]
];

class CustomDigit extends StatefulWidget {
  final int value;
  final Color color;
  final double thickness;
  CustomDigit({
    Key key,
    this.value,
    this.color = Colors.black45,
    this.thickness = 8,
  }) : super(key: key);

  @override
  _CustomDigitState createState() => _CustomDigitState();
}

class _CustomDigitState extends State<CustomDigit> {
  bool _topLeft;
  bool _topCenter;
  bool _topRight;
  bool _center;
  bool _bottomLeft;
  bool _bottomCenter;
  bool _bottomRight;

  bool intToBool(int _value) {
    return _value == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    _topCenter = intToBool(digitBarsArray[widget.value][0]);
    _topLeft = intToBool(digitBarsArray[widget.value][1]);
    _topRight = intToBool(digitBarsArray[widget.value][2]);
    _center = intToBool(digitBarsArray[widget.value][3]);
    _bottomLeft = intToBool(digitBarsArray[widget.value][4]);
    _bottomRight = intToBool(digitBarsArray[widget.value][5]);

    _bottomCenter = intToBool(digitBarsArray[widget.value][6]);

    // print('widget.value ${widget.value}');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: new DigitBar(
              active: _bottomCenter,
              side: Alignment.bottomCenter,
              color: widget.color,
              thickness : widget.thickness,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: new DigitBar(
              active: _topCenter,
              side: Alignment.topCenter,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: new DigitBar(
              active: _topLeft,
              side: Alignment.topLeft,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: new DigitBar(
              active: _topRight,
              side: Alignment.topRight,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: new DigitBar(
              active: _center,
              side: Alignment.center,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: new DigitBar(
              active: _bottomLeft,
              side: Alignment.bottomLeft,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: new DigitBar(
              active: _bottomRight,
              side: Alignment.bottomRight,
              thickness : widget.thickness,
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
