import 'package:my_movies_app/models/user.dart';

class UserResponse {
  late User user;
  late String? token;

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['data']['user']);
    token = json['data']['token'];
  }
} //end of response
