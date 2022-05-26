import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/show_playervoted.dart';
import 'package:provider/provider.dart';

import 'game_phase.dart';

class AfterVoteScreen extends StatelessWidget {
  const AfterVoteScreen({Key? key}) : super(key: key);

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
          height: mysize.height,
          width: mysize.width,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("images/home_screen.jpg"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Put the phone in the middle of the group so they can see and press the button",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center),
              SizedBox(
                height: mysize.height * 0.4,
              ),
              MaterialButton(
                minWidth: mysize.width * 0.4,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Provider.of<GameController>(context, listen: false)
                      .TheGroupKickThis();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const PlayerThatKicked()));
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
    );
  }
}
