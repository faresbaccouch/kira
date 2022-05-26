// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kira/controller/game_controller.dart';
import 'package:kira/module/module.dart';
import 'package:provider/provider.dart';

class players extends StatelessWidget {
  players({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return SizedBox(
        height: mysize.height * 0.7,
        child: Consumer<GameController>(
          builder: (context, player, child) => GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: mysize.height * 0.18,
                mainAxisExtent: mysize.height * 0.18,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: player.players.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(player.players[index].name);
                  },
                  onLongPress: () {
                    _changeName(context, index);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: mysize.height * 0.13,
                        height: mysize.height * 0.13,
                        child: CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/wall_paper.png")),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          player.players[index].name.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: "popins"),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}

_changeName(context, index) async {
  GlobalKey<FormState> _fromstat = GlobalKey<FormState>();
  List<Player> listofplayer =
      Provider.of<GameController>(context, listen: false).players;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      var name = "";
      return AlertDialog(
        title: const Text(
          'Write new Name',
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _fromstat,
            child: TextFormField(
              initialValue: listofplayer[index].name,
              maxLength: 12,
              autofocus: true,
              onSaved: (val) {
                name = val!;
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter name !";
                }
              },
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
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  _fromstat.currentState!.save();
                  if (listofplayer.any((element) => element.name == name)) {
                    Fluttertoast.showToast(
                      msg: "this name already exists",
                    );
                    name = "";
                    return;
                  }
                  if (_fromstat.currentState!.validate()) {
                    Provider.of<GameController>(context, listen: false)
                        .players[index]
                        .name = name;

                    Navigator.of(context).pop();
                    name = "";
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
