import 'package:flutter/material.dart';
import 'package:quizzy/classes/quizz.dart';

import '../main.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  static int score = 0;
  static List<Quizz> liste = <Quizz>[
    Quizz("images/img1.jpeg",
        "L'agrégation est un concept de l'orienté objet !", false),
    Quizz("images/img2.png",
        "Le langage de programmation python est un langage interpreté", true),
    Quizz("images/img3.png",
        "Le langage de programmation Java est un langage interpreté", false),
    Quizz("images/img4.png", "Delphi est un langage orienté objet", false),
    Quizz("images/img5.jpg", "Blaise Pascal est un philosophe", true),
    Quizz("images/img6.jpg", "Paris est la capital de la France", false)
  ];
  static int total = liste.length;
  static int numero = 1;
  static late Quizz quizz = liste[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Le Quizz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Question numéro $numero"),
            Text("Score: $score/$total"),
            SizedBox(
              height: 300,
              width: 300,
              child: Card(
                elevation: 20,
                child: Image(image: Image.asset(quizz.image).image),
              ),
            ),
            Text(
              quizz.question,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: repondVrai,
                  child: const Text(
                    "Vrai",
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 20)),
                ),
                ElevatedButton(
                  onPressed: repondFaux,
                  child: const Text(
                    "Faux",
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 20)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void repondVrai() {
    if (quizz.reponse == true) {
      dialog("Bravo !", "Excellent, vous avez trouvé la bonne reponse",
          "images/win.jpg", true, boutonContinue());
      setState(() {
        score++;
      });
    } else {
      dialog("Oups !", "Faites plus attention, vous y étiez presque",
          "images/lose.jpg", false, boutonContinue());
    }
  }

  void repondFaux() {
    if (quizz.reponse == false) {
      dialog("Bravo !", "Excellent, vous avez trouvé la bonne reponse",
          "images/win.jpg", true, boutonContinue());
      setState(() {
        score++;
      });
    } else {
      dialog("Oups !", "Faites plus attention, vous y étiez presque",
          "images/lose.jpg", false, boutonContinue());
    }
  }

  void suivant() {
    if (numero == total) {
      setState(() {
        numero = 1;
        quizz = liste[0];
      });
      dialog(
          "C'est fini !",
          "Le combat a été rude, ton score final est de $score/$total",
          "images/fin.jfif",
          true,
          boutonFini());
      setState(() {
        score = 0;
      });
    } else {
      setState(() {
        numero++;
        quizz = liste[numero - 1];
      });
      Navigator.pop(context);
    }
  }

  Future<void> dialog(String title, String description, String image,
      bool trouver, ElevatedButton bouton) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(title),
            contentPadding: const EdgeInsets.all(10),
            children: <Widget>[
              SizedBox(
                height: 300,
                width: 300,
                child: Image(image: Image.asset(image).image),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: (trouver) ? Colors.green : Colors.red),
              ),
              bouton,
            ],
          );
        });
  }

  ElevatedButton boutonFini() {
    return ElevatedButton(
      onPressed: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext builder) {
        return const MyHomePage(title: 'Quizzy [Vrai/Faux]');
      }), (route) => false),
      child: const Text("Acceuil"),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.blue),
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white)),
    );
  }

  ElevatedButton boutonContinue() {
    return ElevatedButton(
      onPressed: suivant,
      child: const Text("Suivant"),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.green),
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white)),
    );
  }
}
