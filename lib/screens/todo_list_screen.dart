import 'package:flutter/material.dart';
import 'package:todo_application/api_services/api_services.dart';
import 'package:todo_application/models/get_all_todos.dart';
import 'package:todo_application/screens/add_and_update_todo.dart';
import 'package:todo_application/screens/todos_screen.dart';

class TodoListScreen extends StatefulWidget{
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen>{
  GetAllTodosModel getAllTodosModel = GetAllTodosModel();
  List<Items> inCompleteTodos = [];
  List<Items> completeTodos = [];
  bool isLoading = false;
  getAllTodos()async{
    setState(() {
      isLoading = true;
      getAllTodosModel.items?.clear();
      inCompleteTodos.clear();
      completeTodos.clear();
    });
    await ApiServices().getAllTodos().then((value){
      getAllTodosModel = value;
      for(var todo in value.items!){
        if(todo.isCompleted == true){
          completeTodos.add(todo);
        } else{
          inCompleteTodos.add(todo);
        }
        isLoading = false;
        setState(() {});
      }
      setState(() {});
    }).onError((error, stackTrace){
      debugPrint(error.toString());
    });
  }

  @override
  void initState() {
    getAllTodos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Todo List'),
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            labelStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            tabs: [
              Text('All'),
              Text('Incomplete'),
              Text('Complete')
            ],
          ),
        ),
        body: isLoading? const Center(child: CircularProgressIndicator(),):
        TabBarView(
          children: [
            TodosScreen(todoList: getAllTodosModel.items?? []),
            TodosScreen(todoList: inCompleteTodos),
            TodosScreen(todoList: completeTodos)
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            bool loading = await Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddAndUpdateTodoScreen()));
            if(loading == true){
              getAllTodos();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}