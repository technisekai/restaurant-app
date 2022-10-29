import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.sentiment_neutral,
          color: Colors.grey,
          size: 150,
        ),
        DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'DM Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          child: Text("Yah, tidak ada data yang ditampilkan"),
        ),
      ],
    );
  }
}
