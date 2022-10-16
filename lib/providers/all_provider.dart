import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpos_statemenegment/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

enum TodoListFilter { all, active, complated }

final todoListFilter = StateProvider((ref) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Flutter'),
    TodoModel(id: const Uuid().v4(), description: 'PHP'),
    TodoModel(id: const Uuid().v4(), description: 'Dart'),
    TodoModel(id: const Uuid().v4(), description: 'Python'),
  ]);
});

final filterTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);
  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.complated:
      return todoList.where((element) => element.complate).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.complate).toList();
  }
});

final unComplatedTodoCount = Provider((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.complate).length;

  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
