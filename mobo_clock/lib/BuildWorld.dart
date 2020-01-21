import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

Map<String, Color> _modes = {
  'WeatherCondition.cloudy': Color(0xFFF3F3F3),
  'WeatherCondition.foggy': Color(0xFFE2E2E2),
  'WeatherCondition.rainy': Color(0xFF213048),
  'WeatherCondition.snowy': Color(0xFFE8E5E0),
  'WeatherCondition.sunny': Color(0xFFFFAF3B),
  'WeatherCondition.thunderstorm': Color(0xFFFF9000),
  'WeatherCondition.windy': Color(0xFFFF9000),
};

class BuildWorld extends StatefulWidget {
  final ClockModel model;
  BuildWorld(this.model);

  @override
  _BuildWorldState createState() => _BuildWorldState();
}

class _BuildWorldState extends State<BuildWorld> {
  @override
  Widget build(BuildContext context) {
    // print('widget.model.weatherCondition ${widget.model.weatherCondition}');

    var _colorMode = _modes[widget.model.weatherCondition.toString()];

    // print("_colorMode $_colorMode");

    return LayoutBuilder(
      builder: (context, size) {
        var _width = size.maxWidth;
        var _height = size.maxHeight;

        return Stack(
          children: <Widget>[
            /// SceneBackground

            AnimatedContainer(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff176157), Color(0xff176157)])),
              duration: Duration(seconds: 0),
              // color: _colorMode,
              // color: Colors.black54,
              width: _width,
              height: _height,
            ),


            

            /// Sun / Moon
            // Container(
            //   // color: _colorMode,
            //   width: _width,
            //   height: _height,
            //   child: Stack(
            //     children: <Widget>[
            //       Align(
            //         alignment: Alignment.topLeft,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle, color: Colors.amber),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        );
      },
    );
  }
}
