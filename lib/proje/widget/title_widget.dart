import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Todo App",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.orange, fontSize: 60, fontWeight: FontWeight.w100,),
    );
  }
}
