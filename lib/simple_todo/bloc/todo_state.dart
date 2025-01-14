
class TodoState {
  final List<TodoUiModel> todos;

  TodoState({required this.todos});

  TodoState copyWith({List<TodoUiModel>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }
}

class TodoUiModel {
  final String id;
  final String title;
  bool isCompleted;

  TodoUiModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}