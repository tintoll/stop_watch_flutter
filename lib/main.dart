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
        child: Icon(
          Icons.play_arrow,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _clickButton() {}

  Widget _buildBody() {
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
                    '0',
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '00'
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 200,
                child: ListView(
                  children: [

                  ],
                ),
              ),
            ]),
            Positioned(
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.rotate_left),
              ),
              left: 10,
              bottom: 10,
            ),
            Positioned(
              child: RaisedButton(
                onPressed: () {},
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
}
