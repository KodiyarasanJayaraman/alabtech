import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.inputType,
    this.controller,
    this.hintStyle,
    this.prefixIcon,
    this.contentPadding,
    this.focusedBorder,
    this.border,
    this.hintText,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.filled,
    this.fillColor,
    this.readOnly,
    this.edgeInsets,
    this.focusNode,
    this.padding,
    this.maxlines,
    this.obscureText,
    this.interPadding,
    this.suffixIcon,
    this.onFieldSubmit,
    this.validator,
    this.onEditComplete,
    this.customErrorText,
    this.textAlign,
    this.isCollapsed,
    this.isDense,
    this.maxLength,
  });

  final TextInputType inputType;
  final TextEditingController? controller;
  void Function(String)? onFieldSubmit;
  String? Function(String?)? validator;
  void Function()? onEditComplete;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  InputBorder? border;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? focusedErrorBorder;
  InputBorder? errorBorder;
  String? hintText;
  String? customErrorText;
  bool? filled;
  bool? obscureText;
  Color? fillColor;
  bool? readOnly;
  EdgeInsets? edgeInsets;
  FocusNode? focusNode;
  EdgeInsets? padding;
  int? maxlines;
  bool? interPadding;
  Widget? suffixIcon;
  TextAlign? textAlign;
  bool? isCollapsed;
  bool? isDense;
  int? maxLength;

  EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 10,
          ),
      child: TextFormField(
        inputFormatters: [
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
        textAlign: textAlign ?? TextAlign.center,
        obscureText: obscureText ?? false,
        maxLines: maxlines ?? 1,
        focusNode: focusNode,
        onChanged: onFieldSubmit,
        keyboardType: inputType,
        autofocus: false,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
            isCollapsed: isCollapsed ?? false,
            isDense: isDense ?? false,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 55, minWidth: 35),
            suffixIconConstraints:
                const BoxConstraints(maxWidth: 50, minWidth: 45),
            // constraints: const BoxConstraints(maxHeight: 35),
            suffixIcon: suffixIcon,
            border: border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide()),
            focusColor: Colors.white,
            enabledBorder: enabledBorder ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1),
                ),
            focusedBorder: focusedBorder ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(width: 1),
                ),
            // focusedErrorBorder: focusedBorder ??
            //     OutlineInputBorder(
            //       borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            //       borderSide: BorderSide(color: AppColor.blue900),
            //     ),
            // errorBorder: errorBorder ??
            //     OutlineInputBorder(
            //       borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            //       borderSide: BorderSide(color: AppColor.red),
            //     ),
            hintText: hintText,
            filled: filled ?? true,
            fillColor: fillColor ?? Colors.white.withOpacity(.7),
            hintStyle: hintStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
            prefixIcon: prefixIcon),
        onEditingComplete: onEditComplete,
        controller: controller,
        maxLength: maxLength,
        readOnly: readOnly ??
                (inputType == TextInputType.streetAddress ||
                    hintText == "Pincode")
            ? true
            : false,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter $customErrorText';
              } else {
                if (inputType == TextInputType.emailAddress) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (emailValid == false) {
                    return 'Please Enter Valid Email';
                  } else {
                    return null;
                  }
                } else if (inputType == TextInputType.text) {
                  if (value.isEmpty) {
                    return 'Please Enter Valid $customErrorText';
                  } else {
                    return null;
                  }
                }
              }
              return null;
            },
      ),
    );
  }
}
