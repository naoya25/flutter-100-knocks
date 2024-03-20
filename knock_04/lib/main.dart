import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 60;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _counter--;
          if (_counter == 0) {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _counter = 60;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ここにタイマー表示',
              ),
              Text("$_timer"),
              Text("$_counter"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: _startTimer, child: const Text("スタート")),
                  TextButton(onPressed: _pauseTimer, child: const Text("一時停止")),
                  TextButton(onPressed: _resetTimer, child: const Text("リセット")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
