import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/show_action.dart';
import 'package:provider/provider.dart';

class BeforeAction extends StatelessWidget {
  const BeforeAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.black,
      height: mysize.height,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: mysize.height * 0.1,
          ),
          SizedBox(
            height: mysize.height * 0.4,
            width: mysize.height * 0.4,
            child: Image.asset("images/Start_apple.png"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: mysize.height * 0.3,
            child: Text(
              "Put the phone in the middle for all to see, then press the button to find out what happened today",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          MaterialButton(
            minWidth: mysize.width * 0.4,
            height: 40,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Provider.of<GameController>(context, listen: false).kiraKills();
              Provider.of<GameController>(context, listen: false)
                  .kiraLOverKills();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ShowAction()),
                  (Route<dynamic> route) => false);
            },
            color: Colors.red,
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    ));
  }
}
