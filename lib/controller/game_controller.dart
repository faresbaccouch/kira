// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kira/module/module.dart';
import 'package:kira/view/in_game_view/before_action.dart';
import 'package:kira/view/in_game_view/game_phase.dart';
import 'package:kira/view/in_game_view/roles/Game_news.dart';
import 'package:kira/view/in_game_view/roles/commander.dart';
import 'package:kira/view/in_game_view/roles/detective.dart';
import 'package:kira/view/in_game_view/roles/fake_name.dart';
import 'package:kira/view/in_game_view/roles/fbi_agent.dart';
import 'package:kira/view/in_game_view/roles/kira_follower.dart';
import 'package:kira/view/in_game_view/roles/kira_news.dart';
import 'package:kira/view/in_game_view/roles/kira_role.dart';
import 'package:kira/view/in_game_view/roles/l_player.dart';
import 'package:kira/view/in_game_view/roles/near_.dart';
import 'package:kira/view/in_game_view/roles/policeman.dart';
import 'package:kira/view/in_game_view/roles/shinigami_eyes.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends ChangeNotifier {
  List<Player> players = [];
  List<Player> inGamePLayers = [];
  List<Player> inGamePLayersMnathmin = [];
  List roles = [
    "kira",
    "L",
  ];
  List myRoles = [
    "kiraNews",
    "gameNews",
    "FBI",
    "FBI",
    "policman",
    "Commander",
    "detective",
    "detective",
    "shinigamiEye",
    "fakeName",
    "fakeName",
    "Near",
  ];

  AddRandomRoles() {
    roles = [
      "kira",
      "L",
    ];

    var rng = Random();
    if (players.length > 6) {
      roles.add("Misa");
      notifyListeners();
    }
    for (var i = 0; i < players.length; i++) {
      if (roles.length == players.length) {
        print(roles.length);
        print(players.length);
        notifyListeners();
        return;
      }
      var randomplayer = rng.nextInt(myRoles.length);
      roles.add(myRoles[randomplayer]);
      myRoles.removeAt(randomplayer);
      print(roles[i + 2]);
    }
  }

  addRoleToplayer() {
    inGamePLayers.clear();
    inGamePLayersMnathmin.clear();
    var rng = Random();

    List<Player> PlayerInGame = [];
    //  جبت الاعبين الكل في هذي بش الي نخترله رول نحه من اللوب
    for (var element in players) {
      PlayerInGame.add(element);
    }
    var playerNUM = PlayerInGame.length;
    //  نزيد الاعبين ب الرول متاعهم كل مره واحد
    for (var i = 0; i < playerNUM; i++) {
      var randomplayer = rng.nextInt(PlayerInGame.length);

      inGamePLayers.add(Player(
          id: PlayerInGame[randomplayer].id,
          name: PlayerInGame[randomplayer].name,
          roles: roles[i],
          hasTheDeathNote: i == 0 ? true : false,
          KiraCanKills: roles[i] == "fakeName" ? false : true));

      PlayerInGame.removeAt(randomplayer);
    }
    for (var i = 0; i < playerNUM; i++) {
      var playerMnatham =
          inGamePLayers.firstWhere((element) => element.id == players[i].id);
      inGamePLayersMnathmin.add(playerMnatham);
    }

    notifyListeners();
  }

  createPlayer(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Player newPlayer = Player(
      id: players.length + 1,
      name: name,
    );
    players.add(newPlayer);

    notifyListeners();

    String newPlayerJson = jsonEncode(newPlayer);
    prefs.setString("${players.length}", newPlayerJson);
    prefs.setInt("number", players.length);
  }

  getplayerFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? mylenth = prefs.getInt("number");
    if (mylenth != null) {
      for (var i = 1; i <= mylenth; i++) {
        String? playersSpawn = prefs.getString(i.toString());
        dynamic end = jsonDecode(playersSpawn!);
        players.add(
          Player(id: end["id"], name: end["name"]),
        );
      }
    }
  }

  clearPlayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    players.clear();
    prefs.clear();
    notifyListeners();
  }

  ///
  /// // this one is for kira to kill or pass
  List mcheynyek = [];
  bool? Kill = false;
  colorToggle(name) {
    if (inGamePLayersMnathmin
            .firstWhere((element) => element.name == name)
            .roles ==
        "Misa") {
      return;
    }
    if (mcheynyek.isEmpty) {
      mcheynyek.add(name);
    } else if (mcheynyek.first != name) {
      mcheynyek.clear();
      mcheynyek.add(name);
    } else {
      mcheynyek.clear();
    }
    notifyListeners();
  }

  // if kill is true u kill the player if not u give the death note
  killThePlayer() {
    Kill = true;
    notifyListeners();
  }

  //////////////////////// kira lover role play //////////////////////////////////
  List kiraLoverNika7 = [];
  pickmyVictim(name) {
    if (inGamePLayersMnathmin
            .firstWhere((element) => element.name == name)
            .roles ==
        "kira") {
      return;
    }
    if (kiraLoverNika7.isEmpty) {
      kiraLoverNika7.add(name);
    } else if (kiraLoverNika7.first != name) {
      kiraLoverNika7.clear();
      kiraLoverNika7.add(name);
    } else {
      kiraLoverNika7.clear();
    }
    notifyListeners();
  }

  //////////////////////// kira lover role play //////////////////////////////////
  // this one for show to L the player role
  List LColorsController = [];
  LColors(name) {
    if (LColorsController.isEmpty) {
      LColorsController.add(name);
    } else if (LColorsController.first != name) {
      LColorsController.clear();
      LColorsController.add(name);
    } else {
      LColorsController.clear();
    }
    notifyListeners();
  }

  bool viewRole = false;
  String? ShowPlayerName;
  String? ShowPlayerRole;
  PickPlayerToSHowRole() {
    viewRole = true;
    notifyListeners();
  }

  SaveLUserData(name, role) {
    ShowPlayerName = name;
    ShowPlayerRole = role;
    notifyListeners();
  }

  //////////////////////// L role play //////////////////////////////////
  ///
  ///detective role ===========================
  List Pick2Players = [];
  var showDetectiv = false;
  detectivePick(name) {
    if (Pick2Players.isEmpty) {
      Pick2Players.add(name);
    } else if (Pick2Players.length == 1) {
      if (Pick2Players.contains(name)) {
        Pick2Players.remove(name);
      } else {
        Pick2Players.add(name);
      }
    } else if (Pick2Players.length == 2) {
      if (Pick2Players.contains(name)) {
        Pick2Players.remove(name);
      }
    }
    notifyListeners();
  }

  showResult() {
    showDetectiv = true;
    notifyListeners();
  }

  hideResult() {
    showDetectiv = false;
    notifyListeners();
  }

  ///detective role ===========================
  ///news guys role ===========================
  String? newsGuyMessage = "";
  List<Player> myplayerList = [];
  List random = [];
  bool showKiraNewMessage = false;
  showKiraNews() {
    var rng = Random();
    var kiraPlayer = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "kira");
    if (kiraPlayer != null) {
      var randomplayer = rng.nextInt(2);
      if (randomplayer == 0) {
        // kira is between 3 player
        for (var value in inGamePLayersMnathmin.where(
            (element) => element.roles != "kira" && element.roles != "Misa")) {
          myplayerList.add(value);
        }
        String? firstPlayer = "";
        String? secondPlayer = "";

        for (var i = 0; i <= 2; i++) {
          var randomNUMBER = rng.nextInt(myplayerList.length);
          if (firstPlayer!.isEmpty) {
            firstPlayer = myplayerList[randomNUMBER].name;
            myplayerList.removeAt(randomNUMBER);
          } else {
            secondPlayer = myplayerList[randomNUMBER].name;
            myplayerList.removeAt(randomNUMBER);
          }
        }
        int hmech = 3;
        var randomNUMBER = rng.nextInt(hmech);
        if (randomNUMBER == 0) {
          random.add(kiraPlayer.name);
          random.add(firstPlayer);
          random.add(secondPlayer);
        } else if (randomNUMBER == 1) {
          random.add(secondPlayer);
          random.add(kiraPlayer.name);
          random.add(firstPlayer);
        } else if (randomNUMBER == 2) {
          random.add(secondPlayer);
          random.add(firstPlayer);
          random.add(kiraPlayer.name);
        }
        newsGuyMessage =
            "one of them is kira :   \n ${random[0]} \n ${random[1]}  \n ${random[2]} ";
        random.clear();
      }
      if (randomplayer == 1) {
        // kira still have the death note
        if (kiraPlayer.hasTheDeathNote == true) {
          newsGuyMessage = "Kira still has the Death book";
        } else {
          newsGuyMessage = "Kira does not have the Death Book";
        }
      }
    } else {
      newsGuyMessage = "Kira is Dead Help Them Catch misa";
    }
    showKiraNewMessage = true;
    notifyListeners();
  }

  String? gameNewsMessage = "";
  bool showMessage = false;
  showGameNews() {
    List roletelmawjoda = [
      "kiraNews",
      "FBI",
      "policman",
      "Commander",
      "detective",
      "shinigamiEye",
      "fakeName",
      "Near",
    ];
    var rng = Random();

    // there is only "num" "role" in this game
    var randomNUMBER = rng.nextInt(roletelmawjoda.length);
    var rolepicked = roletelmawjoda[randomNUMBER];
    var thisRoleExist = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == rolepicked);
    if (thisRoleExist == null) {
      gameNewsMessage = "There is no ${rolepicked} in this game ";
    } else {
      var gadechMawjodaElROle = inGamePLayersMnathmin
          .where((element) => element.roles == rolepicked)
          .length;
      gameNewsMessage =
          "There is ${gadechMawjodaElROle}  ${rolepicked} in this game ";
    }

    showMessage = true;
    notifyListeners();
  }

  ///news guys role ===========================
  ///policeman role ===========================
  List peopleInPrison = [];
  putPlayerInPrison(name) {
    if (peopleInPrison.isEmpty) {
      peopleInPrison.add(name);
    } else if (peopleInPrison.length == 1) {
      if (peopleInPrison.first == name) {
        peopleInPrison.clear();
      } else {
        peopleInPrison.clear();
        peopleInPrison.add(name);
      }
    }
    notifyListeners();
  }

  ///policeman role ===========================

  ///Real Owner ===================================
  List kira = [];
  RealOwnerLook() {
    var rng = Random();
    var randomNum = rng.nextInt(4);
    var kiraISHERE = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "kira");

    if (randomNum == 0 && kiraISHERE != null) {
      kira.add(kiraISHERE.name);
    } else {
      kira.add("WWWWWDDDDSAAA");
    }
    notifyListeners();
  }

  ///Real Owner ===================================
  /// show Action =================
  List DeadBody = [];
  // here we put the kill  or action

  kiraLOverKills() {
    if (kiraLoverNika7.isNotEmpty &&
        inGamePLayersMnathmin
                .firstWhere((element) => element.name == kiraLoverNika7.first)
                .KiraCanKills ==
            true) {
      // kill wa7ed 3adi
      DeadBody.add(kiraLoverNika7.first);
      inGamePLayersMnathmin
          .removeWhere((element) => element.name == kiraLoverNika7.first);
    }
  }

  kiraKills() {
    // kira role
    if (Kill == true &&
        inGamePLayersMnathmin
                .firstWhere((element) => element.name == mcheynyek.first)
                .KiraCanKills ==
            true) {
      if (kiraLoverNika7.isNotEmpty &&
          kiraLoverNika7.first == mcheynyek.first) {
        return;
      }
      DeadBody.add(mcheynyek.first);
      inGamePLayersMnathmin
          .removeWhere((element) => element.name == mcheynyek.first);
    }
    notifyListeners();
  }

  /// show Action =================
  /// vota phase
  List<VoteForME> voteCount = [];
  List voteForThisPlayer = [];
  var myvote = 0;
  clearListOfVote() {
    voteCount.clear();
    myvote = 0;
    voteForThisPlayer.clear();
    notifyListeners();
  }

  PlayerIvote() {
    for (var i = 0; i < inGamePLayersMnathmin.length; i++) {
      voteCount.add(
        VoteForME(name: inGamePLayersMnathmin[i].name, voteNum: 0),
      );
    }
    notifyListeners();
  }

  nextPlayerVote() {
    myvote++;

    notifyListeners();
  }

  VoteForThisPlayer() {
    int index = voteCount
        .indexWhere((element) => element.name == voteForThisPlayer.first);
    if (inGamePLayersMnathmin[myvote].roles == "Commander") {
      voteCount[index].voteNum = voteCount[index].voteNum! + 2;
    } else {
      voteCount[index].voteNum = voteCount[index].voteNum! + 1;
    }
  }

  colorController(name) {
    if (voteForThisPlayer.isEmpty) {
      voteForThisPlayer.add(name);
    } else if (voteForThisPlayer.first != name) {
      voteForThisPlayer.clear();
      voteForThisPlayer.add(name);
    } else {
      voteForThisPlayer.clear();
    }
    notifyListeners();
  }

  List<Player> playerWeKick = [];
  TheGroupKickThis() {
    var max_vote = -1;
    var max_repete = 0;
    for (var player in voteCount) {
      if (player.voteNum! > max_vote) {
        max_vote = player.voteNum!;
        max_repete = 1;
      } else if (player.voteNum! == max_vote) {
        max_repete++;
      }
    }
    if (max_repete >= 2) {
      return;
    } else {
      var theplayerwekik =
          voteCount.firstWhere((element) => element.voteNum == max_vote).name;
      var playerkiked = inGamePLayersMnathmin
          .firstWhere((element) => element.name == theplayerwekik);
      playerWeKick.add(
        Player(
          name: playerkiked.name,
          hasTheDeathNote: playerkiked.hasTheDeathNote,
          id: playerkiked.id,
          roles: playerkiked.roles,
        ),
      );
      inGamePLayersMnathmin
          .removeWhere((element) => element.name == theplayerwekik);
    }
    notifyListeners();
  }

  /// vota phase
  ///  control The real game here =======================
  int yourTurn = 1;
  WhoNext() {
    yourTurn++;
    notifyListeners();
  }

  getYourRole() {
    var thisplayer = inGamePLayersMnathmin[yourTurn - 1].roles;
    switch (thisplayer) {
      case "kira":
        {
          return const KiraTimeToPlay();
        }

      case "L":
        {
          return const Lplayer();
        }
      case "fakeName":
        {
          return const FakeName();
        }

      case "Commander":
        {
          return const Agent();
        }
      case "detective":
        {
          return const DetectivRole();
        }
      case "Misa":
        {
          return const KiraFollowes();
        }
      case "policman":
        {
          return const PoliceMan();
        }

      case "shinigamiEye":
        {
          return const RealOwner();
        }
      case "FBI":
        {
          return const FBIagent();
        }
      case "Near":
        {
          return const Near();
        }
      case "kiraNews":
        {
          return const kiraNews();
        }
      case "gameNews":
        {
          return const GameNews();
        }
    }
  }

  gameConrtolleWithDays() {
    if (yourTurn > inGamePLayersMnathmin.length) {
      return const BeforeAction();
    } else {
      return const KiraPage();
    }
  }

  bool GameOver = false;
  GameOverFunction() {
    var KiraExist = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "kira");
    var MisaExist = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "Misa");
    var MoreThen2PlayerExist = inGamePLayersMnathmin
        .where((element) => element.roles != "kira" && element.roles != "Misa")
        .toList();
    if (KiraExist == null && MisaExist == null) {
      GameOver = true;
    } else if (MoreThen2PlayerExist.length == 2 ||
        MoreThen2PlayerExist.length == 1 ||
        MoreThen2PlayerExist.isEmpty) {
      GameOver = true;
    }
    notifyListeners();
  }

  NewDayOrGame() {
    // if kira give the deathnote ..
    var kiraData = inGamePLayersMnathmin
        .firstWhereOrNull((element) => element.roles == "kira");
    if (Kill == false && kiraData != null && mcheynyek.isNotEmpty) {
      var playerGetDeathNote = inGamePLayersMnathmin
          .firstWhereOrNull((element) => element.name == mcheynyek.first);
      if (playerGetDeathNote != null) {
        playerGetDeathNote.hasTheDeathNote = true;
        kiraData.hasTheDeathNote = false;
      }
    } else if (mcheynyek.isEmpty && kiraData != null) {
      var playerHaveTheDeathNote = inGamePLayersMnathmin
          .firstWhereOrNull((element) => element.hasTheDeathNote == true);
      if (playerHaveTheDeathNote == null) {
        kiraData.hasTheDeathNote = true;
      }
    }

    /* chinigami clair */ kira.clear();
    /* player misa or kira kill  */ DeadBody.clear();
    /* player picked to vote */ voteForThisPlayer.clear();
    /* vote count*/ voteCount.clear();
    /* turn vote */ myvote = 0;
    /* Your turn in game */ yourTurn = 1;
    /* the player we kill by vote */ playerWeKick.clear();
    /* player in prison */ peopleInPrison.clear();
    /* detective hide data */ showDetectiv = false;
    /* detective player picked */ Pick2Players = [];
    /* hide data for L player */ viewRole = false;
    /* Colors controller L player */ LColorsController = [];
    /* Misa player picked to kill */ kiraLoverNika7 = [];
    /* Kira player picked to kill */ mcheynyek = [];
    /* Kira player kill / hide */ Kill = false;
    /* restart kira new message*/ GameOver = false;
    /* restart kira new message*/ newsGuyMessage = "";
    /* restart kira new message */ myplayerList = [];
    /* restart kira new message*/ random = [];
    /* restart kira new message */ showKiraNewMessage = false;
    /* restart game new message */ gameNewsMessage = "";
    /* restart game new message */ showMessage = false;

    notifyListeners();
  }

  ///control The real game here =======================

}
