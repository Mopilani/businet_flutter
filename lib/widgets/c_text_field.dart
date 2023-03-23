import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  const CTextField(
    this.cont, {
    Key? key,
    this.label,
    this.node,
    this.nxtNode,
    this.af = false,
    this.hint,
    this.error,
    this.onSubmitted,
    this.textDirection = TextDirection.rtl,
  }) : super(key: key);
  final TextEditingController? cont;
  final String? label;
  final String? hint;
  final String? error;
  final FocusNode? node;
  final FocusNode? nxtNode;
  final bool af;
  final TextDirection? textDirection;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: cont,
          focusNode: node,
          autofocus: af,
          // onTap: () {
          //   // cont!.selection;
          // },
          onSubmitted: (text) {
            // print(nxtNode);
            if (nxtNode != null) {
              nxtNode!.requestFocus();
            }
            if (onSubmitted != null) {
              onSubmitted!(text);
            }
          },
          textDirection: textDirection,
          // textAlign: TextAlign.end,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            errorText: error,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
