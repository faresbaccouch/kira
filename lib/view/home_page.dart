import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/create_players.dart';
import 'package:kira/view/in_game_view/characters.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/game_Screen.png"), fit: BoxFit.fill),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: mysize.height * 0.05,
          child: SizedBox(
            width: mysize.width,
            child: Text(
              "I am Kira",
              style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "kira",
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          top: mysize.height * 0.1,
          child: SizedBox(
            width: mysize.width,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const CreateUser()));
                },
                child: Text(
                  "Start",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "kira",
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
        Positioned(
          top: mysize.height * 0.20,
          child: SizedBox(
            width: mysize.width,
            child: TextButton(
                onPressed: () {
                  Provider.of<GameController>(context, listen: false)
                      .NewDayOrGame();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => CharactersGame()));
                },
                child: Text(
                  "How To Use",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "kira",
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ]),
    );
  }
}
