import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget okButton(void Function() function) {
  return MaterialButton(
    onPressed: function,
    child: const Text(
      'ok',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ).tr(),
  );
}

Widget textWithButtomPad(String text) {
  return Column(
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 32),
    ],
  );
}
