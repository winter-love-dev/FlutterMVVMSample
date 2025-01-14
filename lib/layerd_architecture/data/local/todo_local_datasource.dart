import 'dart:convert';
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/model/todo_model.dart';
import 'package:shared_preferences.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const CACHED_TODOS_KEY = 'CACHED_TODOS';

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getTodos() async {
    final jsonString = sharedPreferences.getStringList(CACHED_TODOS_KEY);
    if (jsonString != null) {
      return jsonString
          .map((todo) => TodoModel.fromJson(json.decode(todo)))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    final List<String> jsonTodos = todos
        .map((todo) => json.encode(todo.toJson()))
        .toList();
    await sharedPreferences.setStringList(CACHED_TODOS_KEY, jsonTodos);
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await cacheTodos(todos);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await cacheTodos(todos);
    }
  }
}
