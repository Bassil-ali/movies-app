class User {
  late int id;
  late String name;
  late String email;
  late String image;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }
} //end of model
