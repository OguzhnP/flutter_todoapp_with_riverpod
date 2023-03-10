import 'package:todo_app_with_riverpod/models/todo_model.dart';
import 'package:todo_app_with_riverpod/providers/todo_list_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_with_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';

enum ToDoListFilter {
  all,
  active,
  completed,
}

final toDoListFilterProvider =
    StateProvider<ToDoListFilter>((ref) => ToDoListFilter.all);

final todoListProvider =
    StateNotifierProvider<ToDoListManager, List<ToDoModel>>((ref) {
  return ToDoListManager([
    ToDoModel(id: const Uuid().v4(), description: "Spora git."),
    ToDoModel(id: const Uuid().v4(), description: "Alışverişe git."),
    ToDoModel(id: const Uuid().v4(), description: "Ders çalış.")
  ]);
});

final filteredToDoListProvider = Provider<List<ToDoModel>>((ref) { 
  final filter = ref.watch(toDoListFilterProvider);
  final toDoList = ref.watch(todoListProvider);
  switch (filter) {
    case ToDoListFilter.all:
      return toDoList;
    case ToDoListFilter.completed:
      return toDoList.where((element) => element.completed).toList();
    case ToDoListFilter.active:
      return toDoList.where((element) => !element.completed).toList();
  }
});

final unCompletedToDoCountProvider = Provider((ref) {
  final allToDo = ref.watch(todoListProvider);
  final count = allToDo.where((element) => !element.completed).length;
  return count;
});

final currentToDoProvider = Provider<ToDoModel>((ref) {
  throw UnimplementedError();
});
