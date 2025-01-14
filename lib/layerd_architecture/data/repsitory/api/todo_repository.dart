
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
}
