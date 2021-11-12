import 'package:flutter/material.dart';

class TextFieldFlut extends StatelessWidget {
  final TextEditingController textController;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Function()? onTap;
  final String hint;
  final String label;
  final double radius;
  final TextInputType typeKeyboard;
  final EdgeInsets padding;
  final String? error;

  const TextFieldFlut({
    Key? key,
    required this.textController,
    this.onSubmit,
    this.onChange,
    this.onEditingComplete,
    this.onTap,
    this.hint = "",
    this.label = "",
    this.error,
    this.padding = const EdgeInsets.all(0.0),
    this.radius = 16.0,
    this.typeKeyboard = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        enabled: true,
        expands: false,
        scrollPadding: EdgeInsets.zero,
        controller: textController,
        maxLines: 1,
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmit,
        onTap: onTap,
        cursorWidth: 1.0,
        keyboardType: typeKeyboard,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.background,
          hintText: hint,
          labelText: label,
          errorText: error,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              width: 0.2,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        ),
      ),
    );
  }
}
