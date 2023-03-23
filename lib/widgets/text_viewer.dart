
import 'dart:io';

import 'package:flutter/material.dart';

class TextViewer extends StatelessWidget {
  const TextViewer(this.path, {Key? key}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: File(path).readAsString(),
      builder: (context, snap) {
        final text = snap.data;
        if (snap.hasError) {
          return Center(
            child: Text(
              '(${snap.error}) :حدث خطأ ما',
            ),
          );
        }
        if (snap.hasData) {
          return TextField(
            maxLines: 15,
            minLines: 10,
            expands: false,
            controller: TextEditingController(text: text),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
