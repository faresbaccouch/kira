import 'package:flutter/material.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:provider/provider.dart';

class kiraNews extends StatelessWidget {
  const kiraNews({Key? key}) : super(key: key);

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
                            'Kira News',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 30,
                                fontFamily: "popins"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                "You will receive messages that help you detect Kira",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mysize.height * 0.5,
                      child: Consumer<GameController>(
                        builder: (ctx, data, child) => Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: mysize.height * 0.35,
                                child: data.showKiraNewMessage
                                    ? Text(
                                        "${data.newsGuyMessage}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      )
                                    : Container()),
                            SizedBox(
                              child: MaterialButton(
                                minWidth: mysize.width * 0.4,
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  if (data.showKiraNewMessage) {
                                    data.WhoNext();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                data.gameConrtolleWithDays()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    Provider.of<GameController>(context,
                                            listen: false)
                                        .showKiraNews();
                                  }
                                },
                                color: Colors.red,
                                child: Text(
                                  "Done",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
