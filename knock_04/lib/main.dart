import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  // 時間、分、秒のそれぞれのテキストフィールドの値管理用
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  late DateTime _timerValue;
  late double _percentage = 1;

  @override
  void initState() {
    // よくわからんがタイマー初期化
    super.initState();
    _timerValue = DateTime(0, 0, 0, 0, 0, 0); // 年、月、日、時、分、秒
  }

  // スタートボタンが押された時の処理
  // 毎秒カウントダウンする処理も入ってる
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
            int hours = int.parse(_hoursController.text);
            int minutes = int.parse(_minutesController.text);
            int seconds = int.parse(_secondsController.text);

            log("$hours: $minutes: $seconds  ${_timerValue.hour}: ${_timerValue.minute}: ${_timerValue.second}");
            // ミリ秒表示してパーセンテージを計算
            int startTime = hours * 60 * 60 + minutes * 60 + seconds;
            int nowTime = _timerValue.hour * 60 * 60 +
                _timerValue.minute * 60 +
                _timerValue.second;
            _percentage = nowTime / startTime;
            log("%: $_percentage");
          }
        });
      }
    });
  }

  // リセットボタンが押された時の処理
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

  // 入力欄からタイマーをセットする`
  void _setTimer() {
    setState(() {
      int hours = int.parse(_hoursController.text);
      int minutes = int.parse(_minutesController.text);
      int seconds = int.parse(_secondsController.text);
      _timerValue = DateTime(0, 0, 0, hours, minutes, seconds);
      _isRunning = true;
      Navigator.pop(context);
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
                  // モーダルウィンド表示
                  onPressed: () => showDialog(
                      context: context,
                      builder: (content) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 時、分、秒の入力欄
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
                                    onPressed: _setTimer,
                                    child: const Text('完了'))
                              ],
                            ),
                          )),
                  // タイムを表示
                  child: Text(
                    "${_timerValue.hour}:${_timerValue.minute}:${_timerValue.second}",
                  ),
                ),
                // ボタン3つ横並び（スタート、一時停止、リセット）
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
                // 円形のカウントダウンバー表示
                CustomPaint(
                  size: const Size(0, 100),
                  painter: _CirclePainter(_percentage), // percentageは 0~1 の間
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 円形描画
class _CirclePainter extends CustomPainter {
  final double percentage;
  _CirclePainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 20.0;
    const double radius = 100;
    final Offset center = Offset(size.width / 2, size.height / 2);

    Paint arcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.5, // 開始角度（0時の方向）
      2 * math.pi * percentage, // 描画する弧の長さ
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
