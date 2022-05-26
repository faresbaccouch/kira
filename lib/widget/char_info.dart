import 'package:flutter/material.dart';

Widget CharInfo(mysize, image, context, text, title) {
  return Column(
    children: [
      SizedBox(height: mysize.height * 0.16, child: Image.asset(image)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 23,
              fontFamily: "popins",
              fontWeight: FontWeight.bold,
              color: Colors.red),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}
