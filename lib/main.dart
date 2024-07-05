import 'package:flutter/material.dart';
import 'package:todo_application/screens/todo_list_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true
      ),
      home: const TodoListScreen(),
    );
  }

}