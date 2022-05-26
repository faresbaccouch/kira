import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/create_players.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:provider/provider.dart';

class EndGame extends StatelessWidget {
  const EndGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kiraExist = Provider.of<GameController>(context, listen: false)
        .inGamePLayersMnathmin
        .firstWhereOrNull(
            (element) => element.roles == "kira" || element.roles == "Misa");
    var mysize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          showMyDialog(context);
          throw () {
            return "fares";
          };
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: InkWell(
              onTap: () {
                Provider.of<GameController>(context, listen: false)
                    .NewDayOrGame();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const CreateUser()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("New Game"),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.restart_alt,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
          body: Container(
            height: mysize.height,
            width: mysize.width,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(
                    kiraExist == null
                        ? "images/L_team_win.png"
                        : "images/kira_team_win.png",
                  ),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: mysize.height * 0.1,
                ),
                kiraExist == null
                    ? Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Team ',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: "popins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              TextSpan(
                                  text: 'L ',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: "kira",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              TextSpan(
                                  text: ' Won',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: "popins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Kira ',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: "kira",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              TextSpan(
                                  text: ' Won',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: "popins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
