import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpos_statemenegment/providers/all_provider.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black12;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unComplatedTodo = ref.watch(unComplatedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

    debugPrint("toolbar tetiklendi");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            unComplatedTodo == 0
                ? 'Mission Complated'
                : '${unComplatedTodo.toString()} mission',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.all)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            child: Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only UnComplated Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.active)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            child: Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Complated Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.complated)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.complated;
            },
            child: Text('Complated'),
          ),
        ),
      ],
    );
  }
}
