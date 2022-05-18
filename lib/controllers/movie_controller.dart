import 'package:get/get.dart';
import 'package:my_movies_app/models/actor.dart';
import 'package:my_movies_app/models/movie.dart';
import 'package:my_movies_app/responses/actor_response.dart';
import 'package:my_movies_app/responses/movie_response.dart';
import 'package:my_movies_app/responses/related_movie_reponse.dart';
import 'package:my_movies_app/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var isLoadingActors = true.obs;
  var isLoadingRelatedMovies = true.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var movies = <Movie>[];
  var actors = <Actor>[];
  var relatedMovies = <Movie>[];

  Future<void> getMovies({
    int page = 1,
    String? type,
    int? genreId,
    int? actorId,
  }) async {
    if (page == 1) {
      isLoading.value = true;
      currentPage.value = 1;
      movies.clear();
    }

    var response = await Api.getMovies(
      page: page,
      type: type,
      genreId: genreId,
      actorId: actorId,
    );
    var movieResponse = MovieResponse.fromJson(response.data);

    movies.addAll(movieResponse.movies);
    lastPage.value = movieResponse.lastPage;

    isLoading.value = false;
    isLoadingPagination.value = false;
  } //end of getMovies

  Future<void> getActors({required int movieId}) async {
    var response = await Api.getActors(movieId: movieId);
    var actorResponse = ActorResponse.fromJson(response.data);

    actors.clear();

    actors.addAll(actorResponse.actors);

    isLoadingActors.value = false;
  } //end of getActors

  Future<void> getRelatedMovies({required int movieId}) async {
    var response = await Api.getRelatedMovies(movieId: movieId);
    var relatedMovieResponse = RelatedMovieResponse.fromJson(response.data);

    relatedMovies.clear();

    relatedMovies.addAll(relatedMovieResponse.relatedMovies);

    isLoadingRelatedMovies.value = false;
  } //end of getRelatedMovies
} //end of controller
