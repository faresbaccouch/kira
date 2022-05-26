// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/end_game.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:provider/provider.dart';

import 'game_phase.dart';

class PlayerThatKicked extends StatelessWidget {
  const PlayerThatKicked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    var istherePlayer = Provider.of<GameController>(context).playerWeKick;
    return WillPopScope(
      onWillPop: () async {
        showMyDialog(context);
        throw () {
          return "fares";
        };
      },
      child: Scaffold(
        body: istherePlayer.isNotEmpty
            ? Container(
                alignment: Alignment.center,
                color: Colors.black,
                width: mysize.width,
                height: mysize.height,
                child: Consumer<GameController>(
                  builder: (ctx, data, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("This player has been killed : ",
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: mysize.height * 0.05,
                      ),
                      SizedBox(
                        width: mysize.height * 0.25,
                        height: mysize.height * 0.25,
                        child: CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "images/${data.playerWeKick.first.roles}.png")),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.playerWeKick.first.name}  ",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "popins",
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "${data.playerWeKick.first.roles}",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "popins",
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        minWidth: mysize.width * 0.4,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          data.GameOverFunction();
                          if (data.GameOver == true) {
                            Navigator.pushReplacement(ctx,
                                MaterialPageRoute(builder: (ctx) => EndGame()));
                          } else {
                            data.NewDayOrGame();
                            Navigator.pushReplacement(
                                ctx,
                                MaterialPageRoute(
                                    builder: (ctx) => KiraPage()));
                          }
                        },
                        color: Colors.red,
                        child: Text(
                          "Next Day",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ))
            : Container(
                alignment: Alignment.center,
                color: Colors.black,
                width: mysize.width,
                height: mysize.height,
                child: Consumer<GameController>(
                  builder: (ctx, data, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No one was killed by voting",
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: mysize.height * 0.05,
                      ),
                      SizedBox(
                        width: mysize.height * 0.25,
                        height: mysize.height * 0.25,
                        child: CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("images/Start_apple.png")),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mysize.height * 0.1,
                      ),
                      MaterialButton(
                        minWidth: mysize.width * 0.4,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          data.GameOverFunction();
                          if (data.GameOver == true) {
                            Navigator.pushReplacement(ctx,
                                MaterialPageRoute(builder: (ctx) => EndGame()));
                          } else {
                            data.NewDayOrGame();
                            Navigator.pushReplacement(
                                ctx,
                                MaterialPageRoute(
                                    builder: (ctx) => KiraPage()));
                          }
                        },
                        color: Colors.red,
                        child: Text(
                          "Next Day",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
