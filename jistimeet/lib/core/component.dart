import 'package:flutter/material.dart';

commonText(
    {String? text,
    double? top,
    TextAlign? textAlign,
    double? fontSize,
    FontWeight? fontWeight}) {
  return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      child: Text(
        textAlign: textAlign,
        text ?? 'Display Name',
        style: TextStyle(
            color: Colors.black,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w400),
      ));
}

commonTextFiled(
    {TextEditingController? controller,
    String? hint,
    double? top,
    String? Function(String?)? validator}) {
  return Container(
    margin: EdgeInsets.only(top: top ?? 0),
    child: TextFormField(
      validator: validator,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      controller: controller,
      decoration: InputDecoration(
        //  labelText: hint??"Room Name",
        filled: true,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
        hintText: hint,
        // <-- add filled
        fillColor: Colors.white,
        // <--- and this

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.20),
            width: 1,
          ),
        ),
      ),
    ),
  );
}
