import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';

Widget forceLogin(BuildContext context) {
  return Column(
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      const SizedBox(
        height: 50,
      ),
      const Icon(
        Icons.dangerous,
        size: 100,
        color: Colors.redAccent,
      ),
      const Text(
        "Required Login",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      const SizedBox(
        height: 50,
      ),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => {GeneralWidgets.showModalLogin(context)},
              child: const Text("Login")))
    ],
  );
}
