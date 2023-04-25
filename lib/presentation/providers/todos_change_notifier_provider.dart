import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

const _uuId = Uuid();

final todosChangeNotifierProvider = ChangeNotifierProvider<TodosChangeNotifier>((ref) {
  return TodosChangeNotifier();
});

class TodosChangeNotifier extends ChangeNotifier{

  List<Todo> todos = <Todo>[
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
  ];

  void addToDo() {
    todos = [
      ...todos,
      Todo(id: _uuId.v4(), description: RandomGenerator.getRandomName(), completedAt: null)
    ];
    notifyListeners();
  }

  void toggleToDo(String id){
    todos = todos.map((todo){
      if(todo.id != id) return todo;
      if(todo.done) return todo.copyWith(completedAt: null);
      return todo.copyWith(completedAt: DateTime.now());
    }).toList();
    notifyListeners();
  }
}