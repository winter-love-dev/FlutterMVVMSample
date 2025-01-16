
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_sample/todo_screen/bloc/todo_bloc.dart';
import 'package:flutter_mvvm_sample/todo_screen/bloc/todo_event.dart';
import 'package:flutter_mvvm_sample/todo_screen/bloc/todo_state.dart';


class SimpleTodoScreen extends StatelessWidget {

  const SimpleTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return _simpleTodoScreen(context, state);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _simpleTodoScreen(BuildContext rootContext, TodoState state) {

    final TodoBloc bloc = rootContext.read<TodoBloc>();

    return ListView.builder(
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final todo = state.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) {
              bloc.add(ToggleTodoEvent(todo.id));
            },
          ),
          title: GestureDetector(
            onLongPress: () {
              _showEditTodoDialog(rootContext, todo);
            },
            child: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              bloc.add(DeleteTodoEvent(todo.id));
            },
          ),
        );
      },
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final textController = TextEditingController();

    final todoBloc = context.read<TodoBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter todo_screen title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  todoBloc.add(AddTodoEvent(textController.text));
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTodoDialog(BuildContext context, TodoUiModel state) {
    final todoBloc = context.read<TodoBloc>();

    final textController = TextEditingController(
        text: state.title
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter todo_screen title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  todoBloc.add(EditTodoEvent(state.id, textController.text));
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }
}