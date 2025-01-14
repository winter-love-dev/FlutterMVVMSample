import 'package:dio/dio.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/core/exceptions/exceptions.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/model/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;
  static const BASE_URL = 'https://api.example.com'; // 예시 URL

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await dio.get('$BASE_URL/todos');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    try {
      final response = await dio.post(
        '$BASE_URL/todos',
        data: todo.toJson(),
      );

      if (response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      final response = await dio.put(
        '$BASE_URL/todos/${todo.id}',
        data: todo.toJson(),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}