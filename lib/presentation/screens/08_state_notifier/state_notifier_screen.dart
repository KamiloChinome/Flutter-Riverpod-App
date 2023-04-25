import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/todos_state_notifier_provider.dart';
import '../../providers/providers.dart';


class StateNotifierScreen extends ConsumerWidget {
  const StateNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: const _ToDosView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(todosStateNotifierProvider.notifier).addToDo();
        },
      ),
    );
  }
}

class _ToDosView extends ConsumerWidget {
  const _ToDosView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final todos = ref.watch(todosStateNotifierProvider);
    final todos = ref.watch(filteredGuestProvider);
    final currentFilter = ref.watch(todoFilterProvider);
    return Column(
      children: [
        const ListTile(
          title: Text('Listado de invitados'),
          subtitle: Text('Estas son las personas a invitar a la fiesta'),
        ),
        SegmentedButton(
          segments: const[
            ButtonSegment(value: TodoFilter.all, icon: Text('Todos')),
            ButtonSegment(value: TodoFilter.completed, icon: Text('Invitados')),
            ButtonSegment(value: TodoFilter.pending, icon: Text('No invitados')),
          ], 
          selected: <TodoFilter>{ currentFilter },
          onSelectionChanged: (value) {
            ref.read(todoFilterProvider.notifier).state = value.first;
          },
        ),
        const SizedBox( height: 5 ),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return SwitchListTile(
                title: Text(todo.description),
                value: todo.done, 
                onChanged: ( value ) {
                  ref.read(todosStateNotifierProvider.notifier)
                  .toggleToDo(todo.id);
                }
              );
            },
          ),
        )
      ],
    );
  }
}