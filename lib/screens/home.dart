import 'package:flutter/material.dart';
import 'package:todo_tracker/themes/todo_provider.dart';

import '../model/todo.dart';
import '../widgets/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_tracker/themes/theme_provider.dart';

final todoProvider =
    ChangeNotifierProvider<TodoProvider>((ref) => TodoProvider());

class Home extends ConsumerWidget {
  final WidgetRef ref;
  final ChangeNotifierProvider<ThemeProvider> themeProvider;

  const Home(
    this.ref,
    this.themeProvider, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context, ref, themeProvider),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in ref.watch(todoProvider).todoList)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: (todoo) =>
                              ref.watch(todoProvider).handleToDoChange(todoo),
                          onDeleteItem: ref.read(todoProvider).deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.background,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: ref.read(todoProvider).todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                    cursorColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(todoProvider).addToDoItem(
                        ref.watch(todoProvider).todoController.text);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref,
      ChangeNotifierProvider<ThemeProvider> themeProvider) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.inverseSurface,
          size: 30,
        ),
        (ref.watch(themeProvider).lightTheme) == true
            ? IconButton(
                icon: const Icon(Icons.wb_sunny_outlined),
                color: Theme.of(context).colorScheme.inverseSurface,
                onPressed: () => ref.read(themeProvider).toggleTheme(),
              )
            : IconButton(
                icon: const Icon(Icons.nightlight_round),
                color: Theme.of(context).colorScheme.inverseSurface,
                onPressed: () => ref.read(themeProvider).toggleTheme(),
              ),
      ]),
    );
  }
}
