class Actor {
  late int id;
  late String name;
  late String image;

  Actor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
} //end of model
