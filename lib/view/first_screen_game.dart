import 'package:flutter/material.dart';
import '../controller/game_controller.dart';
import 'package:provider/provider.dart';

class FirstScreenGame extends StatelessWidget {
  const FirstScreenGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    // ignore: non_constant_identifier_names
    var PlayerMaster = Provider.of<GameController>(context).players;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mysize.height * 0.08,
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
                  RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${PlayerMaster.first.name} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 25,
                              fontFamily: "popins"),
                        ),
                        const TextSpan(
                            text: 'is the game Master',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: "popins")),
                      ],
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "All players have to sit in a small circle  facing each other, the first player is the master of the game, he will get the device at the beginning of each day and read the instructions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "popins",
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Do not trust anyone",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "popins",
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
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
                Provider.of<GameController>(context, listen: false)
                    .addRoleToplayer();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => Provider.of<GameController>(
                              context,
                            ).gameConrtolleWithDays()),
                    (Route<dynamic> route) => false);
              },
              color: Colors.red,
              child: Text(
                "Start",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
