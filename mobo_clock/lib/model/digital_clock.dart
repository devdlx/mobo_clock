// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digi_clock/BuildWorld.dart';
import 'package:digi_clock/components/CustomDigit.dart';
import 'package:digi_clock/components/CustomDigitBackground.dart';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black.withOpacity(.2),
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6).withOpacity(.1),
};

Color digitColor = Color(0xff124c45);
Color solderColor = Color(0xff9fa90f);

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  int digitH1 = 0;
  int digitH2 = 0;
  int digitM1 = 0;
  int digitM2 = 0;
  int digitS1 = 0;
  int digitS2 = 0;

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      // Update once per minute. If you want to update every second, use the
      // following code.
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );

      var hour24 = _dateTime.hour.floor();
      var hour12 =
          _dateTime.hour > 12 ? _dateTime.hour - 12 : _dateTime.hour.floor();
      var hour = !widget.model.is24HourFormat ? hour24 : hour12;
      var minute = _dateTime.minute;
      var second = _dateTime.second;
      print('_dateTime.hour ${hour.toString().substring(0, 1)}');

      // hour = widget.model.is24HourFormat ? hour > 12 ?? hour - 12 : 0;

      digitH1 = hour < 10 ? hour : int.parse(hour.toString().substring(0, 1));
      digitH2 = hour < 10 ? hour : int.parse(hour.toString().substring(1));
      digitM1 = (minute / 10).floor();
      digitM2 =
          minute < 10 ? minute : int.parse(minute.toString().substring(1));
      digitS1 = (second / 10).floor();
      digitS2 =
          second < 10 ? second : int.parse(second.toString().substring(1));

      // print('widget.model.is24HourFormat ${widget.model.is24HourFormat}');

      // print(digitS2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    return LayoutBuilder(builder: (context, size) {
      // print(size.maxHeight / 16);

      double padding = size.maxHeight / 20;

      double borderHorizontal = padding;
      double borderVertical = padding * 4;

      var _thickness = padding;
      return Stack(
        children: <Widget>[
          BuildWorld(widget.model),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: borderHorizontal, vertical: borderVertical),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Stack(
                    children: <Widget>[
                      CustomDigit(
                        color: digitColor,
                        value: digitH1,
                        thickness: _thickness,
                      ),
                      Stack(
                        children: <Widget>[
                          // CustomDigit(
                          //   color: Colors.black.withOpacity(.2),
                          //   value: 0,
                          // ),
                          CustomDigitBackground(
                            color: solderColor,
                            thickness: _thickness,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Stack(
                    children: <Widget>[
                      CustomDigit(
                        color: digitColor,
                        value: digitH2,
                        thickness: _thickness,
                      ),
                      Stack(
                        children: <Widget>[
                          // CustomDigit(
                          //   color: Colors.black.withOpacity(.2),
                          //   value: 0,
                          // ),
                          CustomDigitBackground(
                            color: solderColor,
                            thickness: _thickness,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          color: solderColor,
                          height: 20,
                          width: 20,
                        ),
                        Container(
                          color: solderColor,
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Stack(
                    children: <Widget>[
                      CustomDigit(
                        color: digitColor,
                        value: digitM1,
                        thickness: _thickness,
                      ),
                      Stack(
                        children: <Widget>[
                          // CustomDigit(
                          //   color: Colors.black.withOpacity(.2),
                          //   value: 0,
                          // ),
                          CustomDigitBackground(
                            color: solderColor,
                            thickness: _thickness,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Stack(
                    children: <Widget>[
                      CustomDigit(
                        color: digitColor,
                        value: digitM2,
                        thickness: _thickness,
                      ),
                      Stack(
                        children: <Widget>[
                          // CustomDigit(
                          //   color: Colors.black.withOpacity(.2),
                          //   value: 0,
                          // ),
                          CustomDigitBackground(
                            color: solderColor,
                            thickness: _thickness,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
               
                // Flexible(
                //   flex: 3,
                //   child: Container(
                //     color: Colors.transparent,
                //     // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 60),
                //     child: CustomDigit(
                //       color: digitColor,
                //       value: digitS2,
                //       thickness: _thickness,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
