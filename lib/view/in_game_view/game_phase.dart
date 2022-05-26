import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/home_page.dart';
import 'package:provider/provider.dart';

class KiraPage extends StatefulWidget {
  const KiraPage({Key? key}) : super(key: key);

  @override
  _KiraPageState createState() => _KiraPageState();
}

class _KiraPageState extends State<KiraPage> {
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
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: mysize.height * 0.1,
                ),
                SizedBox(
                  height: mysize.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                  image: AssetImage("images/wallpaper.jpg")),
                            )),
                          ),
                        ),
                      ),
                      Text(
                        '${data.inGamePLayersMnathmin[data.yourTurn - 1].name} ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 30,
                            fontFamily: "popins"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            "Hand the device to this player. Press the button below when you're ready",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      MaterialButton(
                        minWidth: mysize.width * 0.4,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => data.getYourRole()),
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
                ),
                SizedBox(
                  height: mysize.height * 0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'are you sure you want to exit the game ? ',
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Exit'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
