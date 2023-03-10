import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_with_riverpod/providers/providers.dart';
import 'package:todo_app_with_riverpod/widgets/todo_list_item_widget.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unCompletedToDoCount = ref.watch(unCompletedToDoCountProvider);
    final _currentFilter = ref.watch(toDoListFilterProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            unCompletedToDoCount == 0
                ? "Görev yok"
                : "Tamamlanmayan: $unCompletedToDoCount",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(
              onPressed: () {
                ref.read(toDoListFilterProvider.notifier).state =
                    ToDoListFilter.all;
              },
              child: const Text(
                style: TextStyle(color: Colors.black),
                "All",
              )),
        ),
        Tooltip(
          message: "Only Uncompleted Todos",
          child: TextButton(
              onPressed: () {
                ref.read(toDoListFilterProvider.notifier).state =
                    ToDoListFilter.active;
              },
              child:
                  const Text(style: TextStyle(color: Colors.black), "Active")),
        ),
        Tooltip(
          message: "All Completed Todos",
          child: TextButton(
              onPressed: () {
                ref.read(toDoListFilterProvider.notifier).state =
                    ToDoListFilter.completed;
              },
              child: const Text(
                  style: TextStyle(color: Colors.black), "Completed")),
        ),
      ],
    );
  }
}
