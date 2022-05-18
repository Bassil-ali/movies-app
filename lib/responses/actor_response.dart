import 'package:my_movies_app/models/actor.dart';

class ActorResponse {
  late List<Actor> actors = [];

  ActorResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((actor) => actors.add(Actor.fromJson(actor)));
  }
} //end of response
