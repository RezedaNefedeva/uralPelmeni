
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    required this.hintcolor,
    required this.helperText,});
  final TextInputType textInputType;
  final String hintText;
  final TextEditingController controller;
  final Color hintcolor;
  final String helperText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _onFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onFocus.addListener(textFieldOnFocus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onFocus.removeListener(textFieldOnFocus);
    _onFocus.dispose();
  }

  void textFieldOnFocus(){
    setState(() {

    });
  }

  Color ifTextFieldOnFocus(){
    return _onFocus.hasFocus || widget.controller.text.isNotEmpty ? Colors.transparent : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          hintText: widget.hintText,
          helperText: widget.helperText,
          helperStyle: TextStyle(color: ifTextFieldOnFocus(), fontSize: 10),
          hintStyle: TextStyle(color: widget.hintcolor),
          fillColor: grey(),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width:1, color: Colors.black87)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width:1, color: yellow())),
        ),
        controller: widget.controller,
        keyboardType: widget.textInputType,
        focusNode: _onFocus,
      );
  }
}

class CustomTextFieldMultiline extends StatefulWidget {
  const CustomTextFieldMultiline({super.key,
    required this.hintText,
    required this.controller,});
  final String hintText;
  final TextEditingController controller;

  @override
  State<CustomTextFieldMultiline> createState() => _CustomTextFieldMultilineState();
}

class _CustomTextFieldMultilineState extends State<CustomTextFieldMultiline> {
  final FocusNode _onFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onFocus.addListener(textFieldOnFocus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onFocus.removeListener(textFieldOnFocus);
    _onFocus.dispose();
  }

  void textFieldOnFocus(){
    setState(() {

    });
  }

  Color ifTextFieldOnFocus(){
    return _onFocus.hasFocus || widget.controller.text.isNotEmpty ? Colors.black87 : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black26),
        fillColor: grey(),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width:1, color: Colors.black87)
            ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width:1, color: yellow())),
      ),
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      focusNode: _onFocus,
    );
  }
}

