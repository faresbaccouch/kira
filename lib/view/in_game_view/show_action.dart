import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/vote_phase.dart';
import 'package:provider/provider.dart';

import 'game_phase.dart';

class ShowAction extends StatelessWidget {
  const ShowAction({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today's victims",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: mysize.height * 0.65,
              child: Consumer<GameController>(
                builder: (ctx, mydata, child) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 20,
                      mainAxisExtent: mysize.height * 0.3),
                  itemCount: mydata.DeadBody.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var photos = mydata.inGamePLayers
                        .firstWhere(
                            (element) => element.name == mydata.DeadBody[index])
                        .roles;
                    return Align(
                      child: Column(
                        children: [
                          SizedBox(
                            width: mysize.height * 0.2,
                            height: mysize.height * 0.2,
                            child: CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/$photos.png")),
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${mydata.DeadBody[index]}   ",
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "popins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                photos!,
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "popins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Text(
              "The victim is not allowed to speak until the end of the match",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: mysize.width * 0.4,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Provider.of<GameController>(context, listen: false)
                    .PlayerIvote();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const VotePhase()),
                );
              },
              color: Colors.red,
              child: Text(
                "Vote",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
