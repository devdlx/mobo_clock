import 'package:flutter/material.dart';

class DigitBar extends StatelessWidget {
  final bool active;
  final Alignment side;

  final Color color;
  const DigitBar({Key key, this.active = false, this.side, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(color);
    return LayoutBuilder(
      builder: (context, size) {
        var _shape;
        var _height = size.maxHeight;
        var _width = size.maxWidth;

        var _size = (_height / 2) - 10;
        var _thickness = _height / 10;

        print('thickness ${_height / 2}');

        if (this.side == Alignment.bottomCenter) {
          _width = _size;
          _height = _thickness;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.bottomLeft) {
          _width = _thickness;
          _height = _size;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.bottomRight) {
          _width = _thickness;
          _height = _size;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.topLeft) {
          _width = _thickness;
          _height = _size;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.topCenter) {
          _width = _size;
          _height = _thickness;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.topRight) {
          _width = _thickness;
          _height = _size;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          );
        }

        if (this.side == Alignment.center) {
          _width = _size;
          _height = _thickness;
          _shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          );
        }
        // print('size $size');
        return Container(
          width: _width,
          height: _height,
          // margin: EdgeInsets.all(1),
          // color: Colors.redAccent,
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            shape: _shape,
            // elevation: 8,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: this.active ? color : Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}

// https://jsfiddle.net/amyseqmedia/8cPa8/
