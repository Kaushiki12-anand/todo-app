import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_application/screens/delete_button.dart';

import '../models/get_all_todos.dart';
import 'add_and_update_todo.dart';

class TodosScreen extends StatelessWidget {
  final List<Items> todoList;
  const TodosScreen({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty?
        const Center(child: Text("Todo not found!",textScaleFactor: 2,),):
      ListView.separated(
        itemCount: todoList.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        separatorBuilder: (context, i) => const SizedBox(height: 10,),
         itemBuilder: (context, index){
          final item = todoList[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAndUpdateTodoScreen(items: item,)));
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(item.title??"", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)),
                        DeleteButton(id: item.sId??""),
                      ],
                    ),
                    Text(item.description??"",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(item.isCompleted == true?'Complete':'Incomplete',style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    )
                  ],
                ),
              ),
            ),
          );
         }
        );
  }
}
