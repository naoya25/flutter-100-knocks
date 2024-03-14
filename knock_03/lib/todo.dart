class ToDo{
  String title;
  bool isDone;

  ToDo({
    required this.title,
    this.isDone = false,
  });

  void toggleDone(){
    isDone = !isDone;
  }
}
