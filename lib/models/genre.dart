class Genre {
  late int id;
  late String name;
  late int moviesCount;

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moviesCount = json['movies_count'] ?? 0;
  }
} //end of model
