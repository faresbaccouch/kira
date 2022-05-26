import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:provider/provider.dart';
import '../game_phase.dart';

class FakeName extends StatelessWidget {
  const FakeName({Key? key}) : super(key: key);

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
                                      image: AssetImage("images/fakeName.png")),
                                )),
                              ),
                            ),
                          ),
                          const Text(
                            'Fake Name ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 30,
                                fontFamily: "popins"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                "You are an undercover investigator with a false name. Kira can't kill you",
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
                          child: MaterialButton(
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
                                      builder: (context) =>
                                          Provider.of<GameController>(context)
                                              .gameConrtolleWithDays()),
                                  (Route<dynamic> route) => false);
                            },
                            color: Colors.red,
                            child: Text(
                              "Done",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
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
