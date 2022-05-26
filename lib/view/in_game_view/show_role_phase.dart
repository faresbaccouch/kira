import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/home_page.dart';
import 'package:provider/provider.dart';

class RolePhaseScreen extends StatelessWidget {
  const RolePhaseScreen({Key? key}) : super(key: key);

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
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${data.inGamePLayers.first.name} ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 30,
                            fontFamily: "kira"),
                      ),
                      Text(
                          "Hand the device to this player. Press the button below when you're ready",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10)),
                        onPressed: () {},
                        child: Text(
                          "SHOW",
                          style: Theme.of(context).textTheme.headline1,
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const HomePage(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
