import 'package:my_movies_app/models/movie.dart';

class RelatedMovieResponse {
  List<Movie> relatedMovies = [];

  RelatedMovieResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((movie) => relatedMovies.add(Movie.fromJson(movie)));
  }
} //end of response
