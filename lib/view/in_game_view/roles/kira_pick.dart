import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:provider/provider.dart';

import '../game_phase.dart';

class KiraKillOrGive extends StatelessWidget {
  const KiraKillOrGive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                  "Write the player's name in the note to kill him,",
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
                                        itemCount:
                                            data.inGamePLayersMnathmin.length -
                                                1,
                                        itemBuilder: (context, index) {
                                          var peopleIKill = data
                                              .inGamePLayersMnathmin
                                              .where((element) =>
                                                  element.roles != "kira")
                                              .toList();
                                          return InkWell(
                                            onTap: () {
                                              data.colorToggle(
                                                  peopleIKill[index].name);
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: mysize.height * 0.12,
                                                  height: mysize.height * 0.12,
                                                  child: CircleAvatar(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage((peopleIKill[
                                                                            index]
                                                                        .roles ==
                                                                    "Misa")
                                                                ? "images/Misa.png"
                                                                : (data.mcheynyek
                                                                            .isNotEmpty &&
                                                                        data.mcheynyek.first ==
                                                                            peopleIKill[index].name)
                                                                    ? "images/wallpaper.jpg"
                                                                    : "images/wall_paper.png")),
                                                      )),
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
                                                        color: data.mcheynyek
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  minWidth: mysize.width * 0.4,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    if (data.mcheynyek.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "pick Player");
                                    } else {
                                      data.killThePlayer();
                                      data.WhoNext();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  data.gameConrtolleWithDays()),
                                          (Route<dynamic> route) => false);
                                    }
                                  },
                                  color: data.mcheynyek.isEmpty
                                      ? Colors.grey
                                      : Colors.red,
                                  child: Text(
                                    "Kill",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: mysize.width * 0.4,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    data.WhoNext();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const KiraPage()),
                                        (Route<dynamic> route) => false);
                                  },
                                  color: data.mcheynyek.isEmpty
                                      ? Colors.grey
                                      : Colors.red,
                                  child: Text(
                                    "Hide",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ],
                            )
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
