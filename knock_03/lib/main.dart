import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';

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
  final textFieldValue = TextEditingController();
  // 全てのtodoの内容と完了状況を保持する辞書型、API未実装
  // keyがDBのid、valueが[todo内容, 達成状況]っていう想定
  Map<int, List> todoInfo = {
    1: ["todo1", false],
    2: ["todo2", true],
    3: ["todo3", false],
    4: ["todo4", false],
    5: ["todo5", false],
  };

  // todoが完了した時の処理（チェックボックス）
  void _toggleAchievement(int key) {
    setState(() {
      // チェックボックスが押された時、todoInfoのvalue(配列になってる)の1番目を変更する
      todoInfo[key]![1] = !todoInfo[key]![1];
    });
  }

  // todo追加
  void _addTodo(String taskName) {
    setState(() {
      final int newKey = todoInfo.keys.isEmpty
          ? 1
          : todoInfo.keys.reduce(
                  (value, element) => value > element ? value : element) +
              1;
      todoInfo[newKey] = [taskName, false];
      log("taskName");
      log(taskName);
    });
  }

  // todo削除
  void _deleteTodo(int key) {
    setState(() {
      todoInfo.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        // todo一覧を表示
        child: ListView.builder(
            itemCount: todoInfo.length,
            itemBuilder: (_, i) {
              final key = todoInfo.keys.elementAt(i);
              final value = todoInfo[key];
              return ListTile(
                leading: Checkbox(
                  value: value?[1],
                  onChanged: (bool? newValue) {
                    _toggleAchievement(key);
                  },
                ),
                title: Text('${value?[0]}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTodo(key),
                ),
              );
            }),
      )),
      floatingActionButton: TextButton(
        // ボタンクリックでモーダルウィンド表示
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('新規登録')],
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'タスク名', // placeholder
                        ),
                        controller: textFieldValue,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              _addTodo(textFieldValue.text);
                              textFieldValue.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("保存")),
                        TextButton(
                            onPressed: () => (Navigator.pop(context)),
                            child: const Text("キャンセル"))
                      ],
                    ),
                  ]),
                )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
