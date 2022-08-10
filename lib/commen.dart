import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// parsonal information

// App Bar

final myAppBar=AppBar(
  centerTitle: true,
  title:Text("Mashaal Marketing"),
);
InputDecoration my_decoration({my_label}){
  return InputDecoration(
      label:  Text(my_label),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
      )
  );
}
// Form field



















