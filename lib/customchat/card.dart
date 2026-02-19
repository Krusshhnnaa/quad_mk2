import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 25), // CircleAvatar
      title: Text(
        "Saved contact",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ), // TextStyle
      ), // Text
      subtitle: Row(
        children: [
          Icon(Icons.done_all),
          SizedBox(width: 3), // SizedBox
          Text(
            "Hi ",
            style: TextStyle(fontSize: 13), // TextStyle
          ), // Text
        ],
      ), // Row
      trailing: Text("18:04"),
    ); // ListTile
  }
}
