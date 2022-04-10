import 'package:flutter/material.dart';
import 'package:quizzy/views/quizz_page.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 300,
            width: 300,
            child: Card(
              elevation: 20,
              child: Image(image: Image.asset("images/home.webp").image),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) => const QuizzPage())),
              child: const Text("Commencer le quizz"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blue),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white)))
        ],
      ),
    );
  }
}
