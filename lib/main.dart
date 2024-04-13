import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_tracker/themes/theme_provider.dart';
import './screens/home.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final themeProvider =
      ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider).themeData,
      home: Home(ref, themeProvider),
    );
  }
}
