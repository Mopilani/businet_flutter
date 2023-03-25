import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget okButton(void Function() function) {
  return MaterialButton(
    onPressed: function,
    child:  Text(
      'ok'.tr,
      style:const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
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
