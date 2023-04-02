import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KAppBar extends StatelessWidget {
  const KAppBar(
    this.title, {
    Key? key,
    this.actions,
    this.centerTitle = true,
  }) : super(key: key);
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
      child: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(title.tr),
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }
}
