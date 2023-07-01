import 'package:flutter/material.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/Utils/inputValidator.dart';

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    super.key, required this.hintText,required this.textEditingController,required this.isObscure,required this.textFieldType
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscure;
  final String textFieldType;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16,vertical: height*0.009),
          child: TextFormField(
            style: const TextStyle(fontSize: 18),
            controller: textEditingController,
            obscureText: isObscure,
            decoration:  InputDecoration(             
              contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
              fillColor: Colors.white,
                enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  borderSide: const BorderSide(color: kPrimaryLightColor)
                ),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  borderSide: const BorderSide(color: kPrimaryLightColor)
                ),       
                hintText: hintText,
                hintStyle:
                    const TextStyle(height:1,fontStyle: FontStyle.normal,fontSize: 16,color: Color.fromARGB(132, 166, 166, 166)) ,), 
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your $textFieldType';
                  }
                  if (textFieldType == "Email" && !validateEmail(value)) {
                    return 'Please Enter Valid Email';
                  }
                  if(textFieldType == 'Password' && value.length<5){
                    return 'Password should have at least 5 characters';
                  }
                  if(textFieldType == 'Username' && value.length<5){
                    return 'Username should have at least 5 characters';
                  }
                  return null;
                  },
          ),
    );
  }
}