class Player {
  int? id;
  String? name;
  String? roles;
  bool? hasTheDeathNote;
  bool? KiraCanKills;

  Player({
    this.id,
    required this.name,
    this.roles,
    this.hasTheDeathNote,
    this.KiraCanKills,
  });

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}

class VoteForME {
  String? name;
  int? voteNum;
  VoteForME({this.name, this.voteNum});
}
