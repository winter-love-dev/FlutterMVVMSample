import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todos: [])) {
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<EditTodoEvent>(_onEditTodo);
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final TodoUiModel newTodo = TodoUiModel(
      id: DateTime.now().toString(),
      title: event.title,
    );
    emit(state.copyWith(todos: [...state.todos, newTodo]));
  }

  void _onToggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final List<TodoUiModel> updatedTodos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return TodoUiModel(
          id: todo.id,
          title: todo.title,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final List<TodoUiModel> updatedTodos = state.todos.where((todo) => todo.id != event.id).toList();
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    final List<TodoUiModel> updatedTodos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return TodoUiModel(
          id: todo.id,
          title: event.title,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: updatedTodos));
  }
}