import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_with_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class ToDoListManager extends StateNotifier<List<ToDoModel>> {
  ToDoListManager([List<ToDoModel>? initialToDos]) : super(initialToDos ?? []);

  void addToDo(String description) {
    var newToDos = ToDoModel(id: const Uuid().v4(), description: description);
    state = [...state, newToDos];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          ToDoModel(
            id: todo.id,
            description: todo.description,
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          ToDoModel(
              id: todo.id,
              description: newDescription,
              completed: todo.completed)
        else
          todo,
    ];
  }

  void remove(ToDoModel todoToDelete) {
    state = state.where((element) => element.id != todoToDelete.id).toList();
  }

  int unCompletedToDo() {
    return state.where((element) => !element.completed).length;
  }
}
