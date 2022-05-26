import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:provider/provider.dart';

import '../game_phase.dart';

class RealOwner extends StatelessWidget {
  const RealOwner({Key? key}) : super(key: key);

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
                      height: mysize.height * 0.65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: mysize.height * 0.08,
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
                                      image: AssetImage(
                                          "images/shinigamiEye.png")),
                                )),
                              ),
                            ),
                          ),
                          const Text(
                            'shinigami Eye',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 30,
                                fontFamily: "popins"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                "You have 20 percent to see the Shinigami behind Kira",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: mysize.height * 0.1,
                        ),
                        SizedBox(
                          height: mysize.height * 0.1,
                          child: Consumer<GameController>(
                              builder: (ctx, data, child) => data.kira.isEmpty
                                  ? Text(
                                      "",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    )
                                  : data.kira.first == "WWWWWDDDDSAAA"
                                      ? Text(
                                          "There is no Shinigami at the moment ",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "The Shinigami behind ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            Text(data.kira.first,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: "popins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )),
                        ),
                        SizedBox(
                            child: Consumer<GameController>(
                          builder: (ctx, mydata, child) => MaterialButton(
                            minWidth: mysize.width * 0.3,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              if (mydata.kira.isEmpty) {
                                mydata.RealOwnerLook();
                              } else {
                                mydata.WhoNext();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            mydata.gameConrtolleWithDays()),
                                    (Route<dynamic> route) => false);
                              }
                            },
                            color: Colors.red,
                            child: Text(
                              mydata.kira.isEmpty ? "LOOK" : "Done",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        )),
                      ],
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
