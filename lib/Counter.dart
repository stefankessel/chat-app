import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  final Color buttonColor;
  const MyCounter({Key? key, required this.buttonColor}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _count = 0;

  setCount() {
    setState(() {
      _count++;
    });
    print(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setCount();
        },
        backgroundColor: widget.buttonColor,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          "$_count",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
