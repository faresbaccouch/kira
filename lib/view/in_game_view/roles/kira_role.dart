import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:kira/view/in_game_view/roles/kira_pick.dart';
import 'package:provider/provider.dart';

class KiraTimeToPlay extends StatelessWidget {
  const KiraTimeToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    var kira = Provider.of<GameController>(context)
        .inGamePLayersMnathmin
        .firstWhere((element) => element.roles == "kira");
    var hasTheNote = Provider.of<GameController>(context)
        .inGamePLayersMnathmin
        .firstWhere((element) => element.hasTheDeathNote == true);
    return WillPopScope(
      onWillPop: () async {
        showMyDialog(context);
        throw () {
          return "fares";
        };
      },
      child: Scaffold(
        body: Consumer<GameController>(
          builder: (ctx, data, child) => Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(
                  height: mysize.height * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: mysize.height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: mysize.height * 0.1),
                            SizedBox(
                              width: mysize.height * 0.2,
                              height: mysize.height * 0.2,
                              child: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("images/kira.png")),
                                  )),
                                ),
                              ),
                            ),
                            const Text(
                              'KIRA ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 30,
                                  fontFamily: "kira"),
                            ),
                          ],
                        ),
                      ),
                      (hasTheNote.hasTheDeathNote == true &&
                              hasTheNote.roles == "kira")
                          ? SizedBox(
                              height: mysize.height * 0.4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                    "Write the player's name in the note to kill him, \n OR \n You can hide the Death Note by handing it over to someone, and when that person dies you get the Death Note back",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                            )
                          : SizedBox(
                              height: mysize.height * 0.4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                    "You don't have the Death Note now. When ${hasTheNote.name} dies, you get it back",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                            ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: mysize.width * 0.4,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    if (kira.hasTheDeathNote == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const KiraKillOrGive()),
                          (Route<dynamic> route) => false);
                    } else {
                      data.WhoNext();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  data.gameConrtolleWithDays()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    "Next",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
