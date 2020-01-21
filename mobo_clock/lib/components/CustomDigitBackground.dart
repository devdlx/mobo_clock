import 'package:flutter/material.dart';

class CustomDigitBackground extends StatefulWidget {
  final int value;
  final Color color;
  final double thickness;

  CustomDigitBackground({
    Key key,
    this.value,
    this.color = Colors.black45,
    this.thickness = 8.0,
  }) : super(key: key);

  @override
  _CustomDigitBackgroundState createState() => _CustomDigitBackgroundState();
}

class _CustomDigitBackgroundState extends State<CustomDigitBackground> {
  @override
  Widget build(BuildContext context) {
    // print('widget.value ${widget.value}');
    // var _color = Colors.amber;

    var _color = widget.color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: _color),
                  // color: _color,
                  width: widget.thickness,
                  height: widget.thickness,
                ),
                Container(
                  color: _color,
                  width: widget.thickness,
                  height: widget.thickness,
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: _color,
                width: widget.thickness,
                height: widget.thickness,
              )),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                // color: _color,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: _color),

                width: widget.thickness,
                height: widget.thickness,
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                // color: _color,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: _color),

                width: widget.thickness,
                height: widget.thickness,
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: _color,
                width: widget.thickness,
                height: widget.thickness,
              )),
        ],
      ),
    );
  }
}
