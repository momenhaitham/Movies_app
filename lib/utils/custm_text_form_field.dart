
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef validator=String? Function(String?)?;
typedef OnChangedValidator=void Function(String)?;

class CustmTextFormField extends StatelessWidget {
  Color? enabledBorderColor;
  Color? foucsedBorderColor;
  String? labelText;
  TextStyle? labelTextStyle;
  String? hintText;
  TextStyle? hintTextStyle;
  Widget? prefix;
  Widget? sufix;
  Widget? prefixIcon;
  Icon? sufixIcon;
  Color? cursorColor;
  TextStyle? FilledTextStyle;
  int? MaxLines;
  TextEditingController? controller;
  validator? validation;
  OnChangedValidator? OnChanged;
  String? initValue;
  TextInputType? keyboardTybe;
  bool? ObscureText;
  Color? fillColor;

  CustmTextFormField({
    this.enabledBorderColor,
    this.foucsedBorderColor,
    this.labelText,
    this.labelTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.prefix,
    this.sufix,
    this.sufixIcon,
    this.prefixIcon,
    this.cursorColor,
    this.FilledTextStyle,
    this.MaxLines,
    this.controller,
    this.validation,
    this.OnChanged,
    this.initValue,
    this.keyboardTybe,
    this.ObscureText,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedErrorBorder:OutlineInputBorder(
          borderSide: BorderSide(width: 2,color:enabledBorderColor??Colors.grey),
          borderRadius: BorderRadius.circular(12),
          
        ) ,
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2,color:enabledBorderColor??Colors.grey),
            borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2,color:foucsedBorderColor??Colors.grey),
            borderRadius:BorderRadius.circular(12),),
        errorBorder:OutlineInputBorder(
          borderSide: BorderSide(width: 2,color:enabledBorderColor??Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        enabled: true,
        labelText: labelText??null,
        labelStyle: labelTextStyle??null,
        hintText: hintText??null,
        hintStyle: hintTextStyle??null,
        prefix: prefix??null,
        suffix: sufix??null,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        fillColor: fillColor??Colors.transparent,
        filled:  true
      ),
      cursorColor:cursorColor??Colors.grey,
      style:FilledTextStyle ,
      maxLines: MaxLines??1,
      controller: controller,
      validator:validation,
      onChanged: OnChanged,
      enabled: true,
      initialValue: initValue,
      keyboardType:keyboardTybe,
      obscureText: ObscureText??false,
      obscuringCharacter: "*",
    );
  }
}
