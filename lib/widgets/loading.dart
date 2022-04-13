import 'dart:async';

import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({this.text = ''});
  final String text;

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  bool timeout = false;
  int timeoutCounter = 0;
  late Timer timerFunc;

  @override
  void initState() {
    timerFunc = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeoutCounter = timeoutCounter + 1;
      });
      if (timeoutCounter > 10) {
        setState(() {
          timeout = true;
          timerFunc.cancel();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timerFunc.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var displayedText = widget.text;
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              _getText(displayedText),
              _getTimeout(timeout, timeoutCounter)
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          'Lütfen Bekleyin...',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Widget _getProgressbar(int timeoutcounter) {
    return CupertinoProgressBar(
      value: (timeoutcounter / 10).clamp(0, 1).toDouble(),
    );
  }

  Widget _getTimeout(bool timeoutStatus, int timeoutcounter) {
    if (timeoutStatus) {
      return TextButton(onPressed: () => close(), child: _getText("İptal et"));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getProgressbar(timeoutcounter),
      );
    }
  }

  void close() {
    Navigator.of(context).pop();
  }
}
