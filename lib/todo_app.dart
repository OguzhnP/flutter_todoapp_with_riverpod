import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_app_with_riverpod/models/todo_model.dart';
import 'package:todo_app_with_riverpod/providers/providers.dart';
import 'package:todo_app_with_riverpod/widgets/title_widget.dart';
import 'package:todo_app_with_riverpod/widgets/todo_list_item_widget.dart';
import 'package:todo_app_with_riverpod/widgets/toolbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ToDoApp extends ConsumerWidget {
  ToDoApp({super.key});
  final newToDoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allToDos = ref.watch(filteredToDoListProvider);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newToDoController,
            onSubmitted: (newToDo) {
              ref.read(todoListProvider.notifier).addToDo(newToDo);
            },
            decoration: const InputDecoration(
              labelText: 'Neler yapacaksın bugün?',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ToolBarWidget(),
          allToDos.isEmpty
              ? const Center(
                  child: Text(" Bu şartlarda herhangi bir görev yok"),
                )
              : const SizedBox(),
          for (var i = 0; i < allToDos.length; i++)
            Dismissible(
              onDismissed: (direction) {
                ref.read(todoListProvider.notifier).remove(allToDos[i]);
              },
              key: ValueKey(allToDos[i].id),
              child: ProviderScope(
                overrides: [currentToDoProvider.overrideWithValue(allToDos[i])],
                child: const ToDoListItemWidget(),
              ),
            )
        ],
      ),
    );
  }
}
