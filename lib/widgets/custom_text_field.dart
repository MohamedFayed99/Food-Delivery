import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function onClicked;
  final maxLines;
  final Function onChanged;
  final TextInputType keyboardType;
  final hintStyle;
  CustomTextField(
      {this.hint,
      this.onClicked,
      this.maxLines,
      this.onChanged,
      this.keyboardType,
      this.hintStyle});

  String errorMessage(String hintText) {
    switch (hint) {
      case 'user name':
        return 'Name is empty !';
      case "اسم صاحب المطعم/البقالة":
        return 'Name is empty !';
      case 'e-mail or phone':
        return 'Enter email or phone !';
      case 'password':
        return 'Password is empty !';
      case 'confirm password':
        return 'Please confirm the password !';
      case 'e-mail':
        return 'Please Enter Email !';
      case 'phone number':
        return 'Please enter your phone number';
      case 'رقم التليفون':
        return 'ادخل رقم الموبايل';
      case 'restaurant name?':
        return 'Please enter Restaurant Name';
      case 'Restaurant Address':
        return 'Please enter Restaurant Address';
      case 'nature of food?':
        return 'Please enter the nature of food';
//      case 'Product Description' : return 'Please Enter Product Description !';
//      case 'Product Category' : return 'Please Enter Product Category !';
//      case 'Product Image Path' : return 'Please enter Product Image Path !';
      case 'Enter your Address':
        return 'Please Enter the Address';
      case 'ادخل العنوان':
        return 'ادخل العنوان';
      case 'Enter your Name':
        return 'Please Enter your name';
      case 'ادخل اسمك':
        return 'ادخل اسمك';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25), //Change this value to custom as you like
        hintText: hint,
        hintStyle: hintStyle ?? TextStyle(color: textColor, fontSize: 16),
        fillColor: Colors.transparent,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: textColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xff707070),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xff707070),
            )),
      ),
      obscureText: hint == 'password' ||
              hint == 'confirm password' ||
              hint == translator.translate('password') ||
              hint == translator.translate('confirm password')
          ? true
          : false,
      validator: (value) {
        if (value.isEmpty) {
          return errorMessage(hint);
        }
        // ignore: missing_return
        //return null;
      },
      onSaved: onClicked,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }
}
