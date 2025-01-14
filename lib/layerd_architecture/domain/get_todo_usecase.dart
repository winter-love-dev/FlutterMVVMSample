
import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/core/usecase/failure.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/core/usecase/usecase.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/data/repsitory/api/todo_repository.dart';
import 'package:flutter_mvvm_sample/layerd_architecture/domain/model/todo_domain_model.dart';

class GetTodos implements UseCase<List<TodoDomainModel>, NoParams> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<TodoDomainModel>>> call(NoParams params) {
    return repository.getTodos();
  }
}
