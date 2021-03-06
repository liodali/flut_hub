import 'package:flutter/material.dart';

/// SearchTextRepo
/// this widget is responsible to manage search input of the use in appbar
/// when user change text input , if the text has more or equal 4 letter will make new call to get new repositories
///  with [onChange] callback, we always get new input user,
///  [textController] we used to get value inside callback of JobTimer (check Widget when SearchTextRepo Called)
/// [onTap] callback,help us to make specific logic like we show cancel button , to remove focus from TextField
class SearchTextRepo extends StatelessWidget {
  final TextEditingController textController;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Function()? onTap;
  final Widget? suffixIcon;
  final String hint;
  final double radius;

  const SearchTextRepo({
    Key? key,
    required this.textController,
    this.onSubmit,
    this.onChange,
    this.onEditingComplete,
    this.onTap,
    this.hint = "search",
    this.radius = 16.0,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      expands: false,
      scrollPadding: EdgeInsets.zero,
      controller: textController,
      maxLines: 1,
      onChanged: onChange,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmit,
      onTap: onTap,
      cursorColor: Colors.black45,
      cursorWidth: 3.0,
      decoration: InputDecoration(
        fillColor: Colors.grey[400],
        hintText: hint,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
          color: Colors.black38,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
      ),
    );
  }
}
