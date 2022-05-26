import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../game_phase.dart';

class DetectivRole extends StatefulWidget {
  const DetectivRole({Key? key}) : super(key: key);

  @override
  State<DetectivRole> createState() => _DetectivRoleState();
}

class _DetectivRoleState extends State<DetectivRole> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    var myname = Provider.of<GameController>(context, listen: false).yourTurn;
    var allplayer = Provider.of<GameController>(context, listen: false)
        .inGamePLayersMnathmin;
    var peopleIKill = Provider.of<GameController>(context, listen: false)
        .inGamePLayersMnathmin
        .where((element) => element.name != allplayer[myname - 1].name)
        .toList();
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
                  height: mysize.height * 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: mysize.height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: mysize.height * 0.1,
                            ),
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
                                        image:
                                            AssetImage("images/detective.png")),
                                  )),
                                ),
                              ),
                            ),
                            const Text(
                              'Detective',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 30,
                                  fontFamily: "popins"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                  "Choose players to see if they have a Death Note",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mysize.height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (data.showDetectiv == false) ...[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                width: mysize.width * 0.95,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: mysize.height * 0.3,
                                      child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent:
                                                      mysize.height * 0.16,
                                                  mainAxisExtent:
                                                      mysize.height * 0.16,
                                                  crossAxisSpacing: 5),
                                          itemCount: data.inGamePLayersMnathmin
                                                  .length -
                                              1,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                data.detectivePick(
                                                    peopleIKill[index].name);
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: mysize.height * 0.12,
                                                    height:
                                                        mysize.height * 0.12,
                                                    child: CircleAvatar(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: AssetImage((data
                                                                            .Pick2Players
                                                                            .isNotEmpty &&
                                                                        data.Pick2Players.contains(
                                                                            peopleIKill[index].name))
                                                                    ? "images/wallpaper.jpg"
                                                                    : "images/wall_paper.png")),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      "${peopleIKill[index].name}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: data.Pick2Players
                                                                  .contains(
                                                                      peopleIKill[
                                                                              index]
                                                                          .name)
                                                              ? Colors.red
                                                              : Colors.white)),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              if (peopleIKill.firstWhereOrNull((element) =>
                                          element.hasTheDeathNote == true) !=
                                      null &&
                                  data.Pick2Players.contains(peopleIKill
                                      .firstWhereOrNull((element) =>
                                          element.hasTheDeathNote == true)!
                                      .name)) ...[
                                Text(
                                  "One of them has the death note",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ] else ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "They both don't have the Death Note",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ]
                            ],
                            MaterialButton(
                              minWidth: mysize.width * 0.4,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                if (data.Pick2Players.length == 2) {
                                  if (data.showDetectiv == false) {
                                    data.showResult();
                                  } else {
                                    data.Pick2Players.clear();
                                    data.WhoNext();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                data.gameConrtolleWithDays()),
                                        (Route<dynamic> route) => false);
                                    data.hideResult();
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: "pick 2 Player");
                                }
                              },
                              color: data.Pick2Players.length == 2
                                  ? Colors.red
                                  : Colors.grey,
                              child: Text(
                                data.showDetectiv ? "Done" : "Investigate",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
