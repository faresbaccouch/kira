import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/after_vote_screen.dart';
import 'package:provider/provider.dart';

import 'game_phase.dart';

class VotePhase extends StatelessWidget {
  const VotePhase({Key? key}) : super(key: key);

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
          body: Container(
        height: mysize.height * 1,
        width: double.infinity,
        color: Colors.black,
        child: Consumer<GameController>(builder: (context, data, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: mysize.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: mysize.height * 0.05,
                    ),
                    SizedBox(
                      width: mysize.width * 0.93,
                      child: Text(
                        (data.peopleInPrison.isNotEmpty &&
                                data.inGamePLayersMnathmin[data.myvote].name ==
                                    data.peopleInPrison.first)
                            ? "${data.inGamePLayersMnathmin[data.myvote].name} This player has been blocked from voting"
                            : " ${data.inGamePLayersMnathmin[data.myvote].name} is Voting",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
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
                                image: AssetImage("images/Start_apple.png")),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mysize.height * 0.4,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: mysize.height * 0.15,
                      mainAxisExtent: mysize.height * 0.15,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: data.inGamePLayersMnathmin.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (data.peopleInPrison.isNotEmpty &&
                              data.inGamePLayersMnathmin[data.myvote].name ==
                                  data.peopleInPrison.first) {
                            return;
                          } else {
                            data.colorController(
                                data.inGamePLayersMnathmin[index].name);
                          }
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: mysize.height * 0.11,
                                  height: mysize.height * 0.11,
                                  child: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage((data
                                                          .voteForThisPlayer
                                                          .isNotEmpty &&
                                                      data.voteForThisPlayer
                                                              .first ==
                                                          data
                                                              .inGamePLayersMnathmin[
                                                                  index]
                                                              .name)
                                                  ? "images/wallpaper.jpg"
                                                  : "images/wall_paper.png")),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                data.voteCount[index].voteNum == 0
                                    ? Container()
                                    : Positioned(
                                        child: SizedBox(
                                          height: mysize.height * 0.04,
                                          width: mysize.height * 0.04,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: Text(
                                                "${data.voteCount[index].voteNum}"),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Text("${data.inGamePLayersMnathmin[index].name}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: (data.voteForThisPlayer.isNotEmpty &&
                                            data.voteForThisPlayer.first ==
                                                data
                                                    .inGamePLayersMnathmin[
                                                        index]
                                                    .name)
                                        ? Colors.red
                                        : Colors.white)),
                          ],
                        ),
                      );
                    }),
              ),
              MaterialButton(
                minWidth: mysize.width * 0.4,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if (data.voteForThisPlayer.isEmpty) {
                    if (data.myvote == data.inGamePLayersMnathmin.length - 1) {
                      data.voteForThisPlayer.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AfterVoteScreen()));
                    } else {
                      data.nextPlayerVote();
                    }
                  } else {
                    if (data.myvote == data.inGamePLayersMnathmin.length - 1) {
                      data.VoteForThisPlayer();
                      data.voteForThisPlayer.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AfterVoteScreen()));
                    } else {
                      data.VoteForThisPlayer();
                      data.nextPlayerVote();
                      data.voteForThisPlayer.clear();
                    }
                  }
                },
                color:
                    data.voteForThisPlayer.isEmpty ? Colors.grey : Colors.red,
                child: Text(
                  data.voteForThisPlayer.isEmpty ? "pass" : "Vote",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          );
        }),
      )),
    );
  }
}
