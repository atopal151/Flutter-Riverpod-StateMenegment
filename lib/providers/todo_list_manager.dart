import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpos_statemenegment/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var addedTodo = TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, addedTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: todo.description,
              complate: !todo.complate)
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id, description: newDescription, complate: todo.complate)
        else
          todo
    ];
  }

  void remove(TodoModel deletedTodo) {
    state = state.where((element) => element.id != deletedTodo.id).toList();
  }

  int onComplatedTodoCount() {
    return state.where((element) => !element.complate).length;
  }
}
