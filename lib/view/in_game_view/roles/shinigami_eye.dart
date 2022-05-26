import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:provider/provider.dart';

import '../game_phase.dart';

class ShinigamiEye extends StatelessWidget {
  const ShinigamiEye({Key? key}) : super(key: key);

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
                                      image: AssetImage(
                                          "images/shinigamiEye.png")),
                                )),
                              ),
                            ),
                          ),
                          const Text(
                            'shinigami   Eyes ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 25,
                                fontFamily: "popins"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                "You can see everything written in the notebook",
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
                          Consumer(
                            builder: (ctx, data, child) => Container(
                              child: Text("fares"),
                            ),
                          ),
                          MaterialButton(
                            minWidth: mysize.width * 0.4,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              Provider.of<GameController>(context,
                                      listen: false)
                                  .WhoNext();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => KiraPage()),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
