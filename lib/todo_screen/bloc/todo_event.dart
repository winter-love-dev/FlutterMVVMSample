
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  AddTodoEvent(this.title);
}

class ToggleTodoEvent extends TodoEvent {
  final String id;
  ToggleTodoEvent(this.id);
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  DeleteTodoEvent(this.id);
}

class EditTodoEvent extends TodoEvent {
  final String id;
  final String title;
  EditTodoEvent(
      this.id,
      this.title
    );
}