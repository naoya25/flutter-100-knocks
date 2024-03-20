import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  bool _isRunning = false;
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  late DateTime _timerValue;

  @override
  void initState() {
    // よくわからんがタイマー初期化
    super.initState();
    _timerValue = DateTime(0, 0, 0, 0, 0, 0); // 年、月、日、時、分、秒
  }

  // スタートボタンが押された時の処理
  void _startTimer() {
    // 毎秒処理する
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          if (_timerValue.hour == 0 &&
              _timerValue.minute == 0 &&
              _timerValue.second == 0) {
            _isRunning = false;
            _timer.cancel();
          } else {
            // -1秒する
            _timerValue = _timerValue.subtract(const Duration(seconds: 1));
          }
        });
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
      _timerValue = DateTime(0, 0, 0, 0, 0, 0);
      _hoursController.clear();
      _minutesController.clear();
      _secondsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  // 数字部分をクリックするとタイマー編集用のモーダルウィンド表示
                  onPressed: () => showDialog(
                      context: context,
                      builder: (content) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          labelText: '時',
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _hoursController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 70,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          labelText: '分',
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _minutesController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 70,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          labelText: '秒',
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _secondsController,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        int hours =
                                            int.parse(_hoursController.text);
                                        int minutes =
                                            int.parse(_minutesController.text);
                                        int seconds =
                                            int.parse(_secondsController.text);
                                        _timerValue = DateTime(
                                            0, 0, 0, hours, minutes, seconds);
                                        _isRunning = true;
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text('完了'))
                              ],
                            ),
                          )),
                  // タイムを表示
                  child: Text(
                    "${_timerValue.hour}:${_timerValue.minute}:${_timerValue.second}",
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _startTimer();
                        });
                      },
                      child: const Text("スタート"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isRunning = false;
                        });
                      },
                      child: const Text("一時停止"),
                    ),
                    TextButton(
                      onPressed: _resetTimer,
                      child: const Text("リセット"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
