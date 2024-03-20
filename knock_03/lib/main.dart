import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';
import 'package:knock_03/todo.dart';

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
  final List<ToDo> todoInfo = [];

  // todo追加
  void _addTodo(String taskName) {
    setState(() {
      final newTodo = ToDo(title: taskName);
      todoInfo.add(newTodo);
      log("taskName: $taskName");
    });
  }

  // todo削除
  void _deleteTodo(ToDo todo) {
    setState(() {
      todoInfo.remove(todo);
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
              return ListTile(
                leading: Checkbox(
                  value: todoInfo[i].isDone,
                  onChanged: (bool? newValue) {
                    setState(() {
                      todoInfo[i].toggleDone();
                    });
                  },
                ),
                title: Text(todoInfo[i].title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todoInfo[i]),
                ),
              );
            }),
      )),
      floatingActionButton: FloatingActionButton(
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
