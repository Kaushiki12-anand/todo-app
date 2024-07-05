import 'package:flutter/material.dart';
import 'package:todo_application/api_services/api_services.dart';
import 'package:todo_application/models/get_all_todos.dart';
import 'package:todo_application/screens/todo_list_screen.dart';
import 'package:todo_application/utils/common_toast.dart';

class AddAndUpdateTodoScreen extends StatefulWidget {
  final Items? items;
  const AddAndUpdateTodoScreen({super.key, this.items});

  @override
  State<AddAndUpdateTodoScreen> createState() => _AddAndUpdateTodoScreenState();
}

class _AddAndUpdateTodoScreenState extends State<AddAndUpdateTodoScreen> {
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  bool isComplete=false;
  bool isLoading=false;

  @override
  void initState() {
    if(widget.items != null){
      title.text = widget.items?.title??"";
      description.text = widget.items?.description??"";
      isComplete = widget.items?.isCompleted??false;
      setState(() {});
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.items == null?'Add Todo':"Update Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: title,
              autofocus: widget.items == null? true:false,
              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none
              ),
            ),
            TextFormField(
              controller: description,
              style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
              decoration: const InputDecoration(
                  hintText: 'Description',
                  border: InputBorder.none
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Complete',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                Switch(
                    value: isComplete,
                    activeColor: Colors.cyan,
                    onChanged: (bool value){
                      setState(() {
                        isComplete = value;
                      });
                    }
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(title.text.isEmpty){
            commonToast(context, 'Please enter title');
          } else if(description.text.isEmpty){
            commonToast(context, 'Please enter description');
          } else{
            setState(() {isLoading = true;});
            if(widget.items == null){
              ApiServices().addTodo(title.text.toString(), description.text.toString(), isComplete).then((value){
                setState(() {isLoading = false;});
                Navigator.pop( context, true);
              }).onError((error,stackTrace){
                debugPrint(error.toString());
                setState(() {isLoading = false;});
                commonToast(context, 'Something went wrong');
              });
            }
            else{
              ApiServices().updateTodo(widget.items!.sId!, title.text.toString(), description.text.toString(), isComplete).then((value){
                setState(() {isLoading = false;});
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const TodoListScreen()));
              }).onError((error,stackTrace){
                debugPrint(error.toString());
                setState(() {isLoading = false;});
                commonToast(context, 'Something went wrong');
              });
            }
          }
        },
        child: isLoading? const CircularProgressIndicator(): const Icon(Icons.done),
      ),
    );
  }
}