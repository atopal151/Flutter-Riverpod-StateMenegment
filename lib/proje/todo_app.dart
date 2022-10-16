import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpos_statemenegment/proje/widget/title_widget.dart';
import 'package:flutter_riverpos_statemenegment/providers/all_provider.dart';
import 'widget/future_provider_example.dart';
import 'widget/todlist_item_widget.dart';
import 'widget/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);
  final newtodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filterTodoList);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: newtodoController,
            decoration: const InputDecoration(
              label: Text("What is your task today ?"),
            ),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolbarWidget(),
          allTodos.length == 0 ? Center(child: Text('No Task')) : SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i])
                ], child: TodoListItemWidget())),
          ElevatedButton(
            style:  ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FutureProviderExample()));
              },
              child: const Text("Future Provider Example"))
        ],
      ),
    );
  }
}
