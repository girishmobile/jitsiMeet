import 'package:flutter/material.dart';
import 'package:jistimeet/core/constants/num_constants.dart';
import 'package:jistimeet/core/string_utils.dart';

commonText(
    {String? text,
    double? top,
    Color ? color,
    TextAlign? textAlign,
    double? fontSize,
    FontWeight? fontWeight}) {
  return Container(
      margin: EdgeInsets.only(top: top ?? zero),
      child: Text(
        textAlign: textAlign,
        text ?? displayName,
        style: TextStyle(
            //color: color??Colors.black,
            fontSize: fontSize ?? fourteen,
            fontWeight: fontWeight ?? FontWeight.w400),
      ));
}

commonTextFiled(
    {TextEditingController? controller,
    String? hint,
    double? top,
void Function(String)? onChanged,
    String? Function(String?)? validator}) {
  return Container(
    margin: EdgeInsets.only(top: top ?? zero),
    child: TextFormField(
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(

          color: Colors.black, fontSize: fourteen, fontWeight: FontWeight.w400),
      controller: controller,
      decoration: InputDecoration(
        //  labelText: hint??"Room Name",
        filled: true,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: fourteen, fontWeight: FontWeight.w400),
        hintText: hint,
        // <-- add filled
      //  fillColor: Colors.white,
        // <--- and this

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ten),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(zero20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ten),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(zero20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ten),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(zero20),
            width: 1,
          ),
        ),
      ),
    ),
  );
}
