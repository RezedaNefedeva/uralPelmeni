
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class TextFieldAuto extends StatefulWidget {
   TextFieldAuto({super.key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    required this.hintcolor,
    required this.helperText,
  required this.userData,
  required this.userDataText});
  final TextInputType textInputType;
  final String hintText;
  final TextEditingController controller;
  final Color hintcolor;
  final String helperText;
  late  String userData;
  final String userDataText;

  @override
  State<TextFieldAuto> createState() => _TextFieldAutoState();
}

class _TextFieldAutoState extends State<TextFieldAuto> {
  final FocusNode _onFocus = FocusNode();

  bool text_field = false;

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
        text_field = true;
    });
  }

  labeText() {
    if(!text_field){
      widget.userData;
      widget.controller.text = widget.userData;
    }
  }

  Color ifTextFieldOnFocus(){
    return _onFocus.hasFocus || widget.controller.text.isNotEmpty ? Colors.transparent : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    _changeName(String text){
      setState(() => widget.userData = text);
    }
    return TextField(
      decoration: InputDecoration(
        labelText: labeText(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        hintText: widget.hintText,
        helperText: widget.helperText,
        helperStyle: TextStyle(color: ifTextFieldOnFocus(), fontSize: 10),
        hintStyle: TextStyle(color: widget.hintcolor),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width:2, color: yellow())),
      ),
      autofillHints: [widget.userDataText],
      controller: widget.controller,
      keyboardType: widget.textInputType,
      focusNode: _onFocus,
      onChanged: (text) {
        _changeName;
      },
    );
  }
}

