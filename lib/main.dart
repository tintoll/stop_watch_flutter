import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  Timer _timer;   // 타이머
  var _time = 0;  // 0.01초 마다 1씩 증가시킬 정수형 변수
  var _isRunning = false; // 현재 시작 상태를 알려줄 변수

  List<String> _lapTimes = [];

  @override
  void dispose() {
    _timer?.cancel(); // _timer를 한번도 동작시키지 않았을때(null인상태) 안전하게 동작을 취소하려고 ?. 연산자를 활용
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스톱 워치'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clickButton();
        },
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _stop();
    }

  }

  Widget _buildBody() {
    var sec = _time ~/ 100; // 초
    var hundredth = '${_time % 100}'.padLeft(2,'0'); // 1/100초 0으로 왼쪽 빈곳 채우기

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$sec',
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '$hundredth'
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 200,
                child: ListView(
                  children: _lapTimes.map((time) => Text(time)).toList(),
                ),
              ),
            ]),
            Positioned(
              child: FloatingActionButton(
                onPressed: _reset,
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.rotate_left),
              ),
              left: 10,
              bottom: 10,
            ),
            Positioned(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: Text('랩타임'),
              ),
              right: 10,
              bottom: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _recordLapTime(String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
  }

  void _reset() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _lapTimes.clear();
      _time = 0;
    });
  }
  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }
}
