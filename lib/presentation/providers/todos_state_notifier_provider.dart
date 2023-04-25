import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

const _uuId = Uuid();

final filteredGuestProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todosStateNotifierProvider);
  switch(selectedFilter){
    
    case TodoFilter.all:
      return todos;
    case TodoFilter.completed:
      return todos.where((element) => element.done).toList();
    case TodoFilter.pending:
      return todos.where((element) => !element.done).toList();
  }
});
final todosStateNotifierProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

class TodosNotifier extends StateNotifier<List<Todo>> {

  TodosNotifier(): super([
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
  ]);

  void addToDo() {
    state = [
      ...state,
      Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null)
    ];
  }

  void toggleToDo(String id){
    state = state.map((todo){
      if(todo.id != id) return todo;
      if(todo.done) return todo.copyWith(completedAt: null);
      return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }


}