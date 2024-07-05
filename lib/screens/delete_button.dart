import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/api_services/api_services.dart';
import 'package:todo_application/screens/todo_list_screen.dart';
import 'package:todo_application/utils/common_toast.dart';

class DeleteButton extends StatefulWidget {
  final String id;
  const DeleteButton({super.key, required this.id});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {isLoading = true;});
        ApiServices().deleteTodos(widget.id).then((value){
          commonToast(context, 'Delete Successfully',bgcolor: Colors.green);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const TodoListScreen()));
          setState(() {isLoading = false;});
        }).onError((error,stackTrace){
          debugPrint(error.toString());
          setState(() {isLoading = false;});
          commonToast(context, 'Something went wrong');
        });
      },
      child: Container(
        height: 40, width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(50)
        ),
        child: isLoading? const SizedBox(
          child: SizedBox(
            height: 30, width: 30,
              child: CircularProgressIndicator()),
        ): const Icon(Icons.delete_outline, color: Colors.red,),
      ),
    );
  }
}