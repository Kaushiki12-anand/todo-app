import 'package:flutter/material.dart';

commonToast(BuildContext context, String message,{Color? bgcolor}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: bgcolor ?? Colors.red,));
}