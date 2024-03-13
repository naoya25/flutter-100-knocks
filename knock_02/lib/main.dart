import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Flutter Counter',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '$_counter',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: _incrementCounter,
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          iconColor: Colors.white,
                          shape: const CircleBorder()),
                      child: const Icon(
                        Icons.add,
                        size: 10,
                      ),
                    ),
                    TextButton(
                      onPressed: _decrementCounter,
                      style: TextButton.styleFrom(
                        iconColor: Colors.blue,
                        shape: const CircleBorder(),
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
