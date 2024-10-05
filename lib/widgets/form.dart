import 'package:flutter/material.dart';

class pubTextFormField extends StatelessWidget {

  TextEditingController controller;
  String hintName;
  IconData? icon;
  bool isObscueText;
  TextInputType inputType;
  pubTextFormField(
      {required this.controller,
        required this.hintName,
        this.icon,
        this.isObscueText = false,
        this.inputType = TextInputType.text});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isObscueText,
        keyboardType: inputType,
        // validator: (value){
        //   if (value == null || value.isEmpty){
        //     return 'Please Enter $hintName';
        //   }
        //   if (hintName == "Email" && !validateEmail(value)) {
        //     return 'Please Enter Valid Email';
        //   }
        //   return null;
        // },

        //onSaved: (val) => controller.text = val!,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: Colors.yellow),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}