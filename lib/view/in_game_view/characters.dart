import 'package:flutter/material.dart';
import 'package:kira/widget/char_info.dart';

class CharactersGame extends StatelessWidget {
  const CharactersGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Characters",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: mysize.width,
          color: Colors.black,
          child: Column(
            children: [
              CharInfo(
                mysize,
                "images/kira.png",
                context,
                "Write the player's name in the book to kill him, You can also hide the Death book by handing it over to someone, and when that person dies you get the Death book back",
                "Kira",
              ),
              CharInfo(
                mysize,
                "images/L.png",
                context,
                "You can choose a character to see his role",
                "L",
              ),
              CharInfo(
                mysize,
                "images/detective.png",
                context,
                "Choose players to see if they have a Death book",
                "Detective",
              ),
              CharInfo(
                mysize,
                "images/Commander.png",
                context,
                "Your vote counts as a value of two",
                "Commander",
              ),
              CharInfo(
                mysize,
                "images/fakeName.png",
                context,
                "You are an undercover investigator with a false name. Kira can't kill you",
                "Fake Name ",
              ),
              CharInfo(
                mysize,
                "images/FBI.png",
                context,
                "You must help the detectives catch Kira",
                "FBI",
              ),
              CharInfo(
                mysize,
                "images/Misa.png",
                context,
                "You don't have the Death book but you do have a paper of it, help Kira",
                "Misa",
              ),
              CharInfo(
                mysize,
                "images/Near.png",
                context,
                "If L is dead, You can see Players roles",
                "Near",
              ),
              CharInfo(
                mysize,
                "images/policman.png",
                context,
                "Choose a player to put him in jail for a day (can't vote)",
                "Policeman",
              ),
              CharInfo(
                mysize,
                "images/shinigamiEye.png",
                context,
                "You have 20 percent to see the Shinigami behind Kira",
                "shinigami Eye",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
