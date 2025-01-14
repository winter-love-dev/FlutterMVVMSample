
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/model/todo_model.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/todo_repository.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/domain/model/todo_domain_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<TodoModel>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<void> addTodo(TodoModel todo) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}

