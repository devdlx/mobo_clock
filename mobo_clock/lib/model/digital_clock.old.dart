// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digi_clock/BuildWorld.dart';
import 'package:digi_clock/components/CustomDigit.dart';
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

      // print('_dateTime.hour ${_dateTime.hour}');

      var hour = _dateTime.hour;
      var minute = _dateTime.minute;
      var second = _dateTime.second;

      digitH1 = 1; //(hour / 10).floor();
      digitH2 = 2;
      digitM1 = (minute / 10).floor();
      digitM2 =
          minute < 10 ? minute : int.parse(minute.toString().substring(1));
      digitS1 = (second / 10).floor();
      digitS2 =
          second < 10 ? second : int.parse(second.toString().substring(1));
      // print('digitS2 $digitS2');

      print(digitS2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    // final fontSize = MediaQuery.of(context).size.width / 3.5;
    final fontSize = MediaQuery.of(context).size.width / 10.5;
    final offset = -fontSize / 7;

    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'PressStart2P',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 8,
          color: colors[_Element.shadow],
          offset: Offset(10, 4),
        ),
      ],
    );

    return LayoutBuilder(builder: (context, size) {
      return SizedBox(
        height: size.maxHeight,
        width: size.maxWidth,
        child: Stack(
          children: <Widget>[
            BuildWorld(widget.model),
            Container(
              // height: fontSize + 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: fontSize,
                      height: 200,
                      child: new CustomDigit(
                        value: digitH1,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: fontSize,
                        height: 200,
                        child: new CustomDigit(
                          value: digitH2,
                        ),
                      )),
                  Container(
                    // width: 46,
                    // height: 1000,
                    margin: EdgeInsets.only(right: 16, left: 6),
                    // color: Colors.teal,
                    child: DefaultTextStyle(
                      style: defaultStyle,
                      child: Text(':'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: new SizedBox(
                        width: fontSize,
                        height: 200,
                        child: new CustomDigit(
                          value: digitM1,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: new SizedBox(
                        width: fontSize,
                        height: 200,
                        child: new CustomDigit(
                          value: digitM2,
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // width: 100,
                        // height: 200,
                        // margin: EdgeInsets.only(right: 32),
                        // color: Colors.redAccent,
                        child: DefaultTextStyle(
                          style: defaultStyle.copyWith(fontSize: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('PM'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // width: 90,
                        // height: 200,
                        // margin: EdgeInsets.only(right: 32),
                        // color: Colors.redAccent,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                              height: 80,
                              child: new CustomDigit(
                                value: digitS1,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 24,
                              height: 80,
                              child: new CustomDigit(
                                value: digitS2,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
