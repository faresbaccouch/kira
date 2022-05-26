// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class Near extends StatelessWidget {
  const Near({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    var LExist = Provider.of<GameController>(context, listen: false)
        .inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "L");
    return WillPopScope(
      onWillPop: () async {
        showMyDialog(context);
        throw () {
          return "fares";
        };
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: mysize.height,
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
                                      image: AssetImage("images/Near.png")),
                                )),
                              ),
                            ),
                          ),
                          const Text(
                            'Near ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 30,
                                fontFamily: "popins"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                "If L is dead, You can see Players roles",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ],
                      ),
                    ),
                    LExist != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: mysize.height * 0.4,
                              ),
                              MaterialButton(
                                minWidth: mysize.width * 0.4,
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  var mydata = Provider.of<GameController>(
                                      context,
                                      listen: false);
                                  mydata.WhoNext();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              mydata.gameConrtolleWithDays()),
                                      (Route<dynamic> route) => false);
                                },
                                color: Colors.red,
                                child: Text(
                                  "Start",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: mysize.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Consumer<GameController>(
                                  builder: (ctx, data, child) => data.viewRole
                                      ? SizedBox(
                                          height: mysize.height * 0.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${data.ShowPlayerName} Is",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                              Text("   ${data.ShowPlayerRole}",
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: "popins",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          width: mysize.width * 0.95,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: mysize.height * 0.3,
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent:
                                                                mysize.height *
                                                                    0.16,
                                                            mainAxisExtent:
                                                                mysize.height *
                                                                    0.16,
                                                            crossAxisSpacing:
                                                                5),
                                                    itemCount: data
                                                            .inGamePLayersMnathmin
                                                            .length -
                                                        1,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var peopleIKill = data
                                                          .inGamePLayersMnathmin
                                                          .where((element) =>
                                                              element.roles !=
                                                              "L")
                                                          .toList();
                                                      return InkWell(
                                                        onTap: () {
                                                          data.LColors(
                                                              peopleIKill[index]
                                                                  .name);
                                                          data.SaveLUserData(
                                                              peopleIKill[index]
                                                                  .name,
                                                              peopleIKill[index]
                                                                  .roles);
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: mysize
                                                                      .height *
                                                                  0.12,
                                                              height: mysize
                                                                      .height *
                                                                  0.12,
                                                              child:
                                                                  CircleAvatar(
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image: AssetImage((data.LColorsController.isNotEmpty && data.LColorsController.first == peopleIKill[index].name)
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
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "popins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: data
                                                                            .LColorsController.contains(peopleIKill[
                                                                                index]
                                                                            .name)
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .white)),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                                Consumer<GameController>(
                                  builder: (ctx, btnData, child) => SizedBox(
                                    width: mysize.width * 0.4,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              btnData.LColorsController.isEmpty
                                                  ? Colors.grey
                                                  : Colors.red),
                                      onPressed: () {
                                        if (btnData.LColorsController.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "pick Player");
                                        } else if (btnData.viewRole == true) {
                                          btnData.WhoNext();
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) => btnData
                                                      .gameConrtolleWithDays()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          btnData.PickPlayerToSHowRole();
                                        }
                                      },
                                      child: Text(
                                        btnData.viewRole ? "Done" : "pick",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
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
    );
  }
}
