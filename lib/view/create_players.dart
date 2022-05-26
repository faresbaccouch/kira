// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/module/module.dart';
import 'package:kira/view/first_screen_game.dart';
import 'package:kira/widget/player.dart';
import 'package:provider/provider.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _name = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    var playerCount = Provider.of<GameController>(context).players;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        backgroundColor: Colors.black,
        titleSpacing: 0,
        title: Text(
          "Players",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<GameController>(context, listen: false).clearPlayer();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Clear",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/home_screen.jpg"),
                  fit: BoxFit.fill)),
          height: mysize.height,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Consumer<GameController>(
                      builder: (ctx, data, child) => SizedBox(
                        height: mysize.height * 0.1,
                        width: mysize.width,
                        child: TextButton(
                          onPressed: () {
                            if (playerCount.length >= 12) {
                              Fluttertoast.showToast(msg: "max 12 player");
                            } else {
                              _showMyDialog(
                                context,
                                _name,
                              );
                            }
                          },
                          child: playerCount.length >= 12
                              ? Text("You Can't Add More",
                                  style: Theme.of(context).textTheme.headline5)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Add Player ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    Icon(
                                      Icons.add,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    players(),
                  ],
                ),
              ),
              SizedBox(
                height: mysize.height * 0.055,
                child: playerCount.length < 4
                    ? Text(
                        "not enough players",
                        style: Theme.of(context).textTheme.headline5,
                      )
                    : MaterialButton(
                        minWidth: mysize.width * 0.4,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Provider.of<GameController>(context, listen: false)
                              .AddRandomRoles();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const FirstScreenGame()));
                        },
                        color: Colors.red,
                        child: Text(
                          "Next",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_showMyDialog(context, TextEditingController _name) async {
  GlobalKey<FormState> _fromstat = GlobalKey<FormState>();
  List<Player> listofplayer =
      Provider.of<GameController>(context, listen: false).players;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Write The Player Name',
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _fromstat,
            child: TextFormField(
              maxLength: 12,
              autofocus: true,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter name !";
                }
              },
              controller: _name,
            ),
          ),
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
                  Navigator.of(context).pop();
                  _name.clear();
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  if (listofplayer
                      .any((element) => element.name == _name.text)) {
                    Fluttertoast.showToast(
                        msg: "this name already exists", textColor: Colors.red);
                    return;
                  }
                  if (_fromstat.currentState!.validate()) {
                    Provider.of<GameController>(context, listen: false)
                        .createPlayer(_name.text);

                    _name.clear();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
