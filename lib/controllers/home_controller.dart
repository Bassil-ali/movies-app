import 'package:get/get.dart';
import 'package:my_movies_app/models/movie.dart';
import 'package:my_movies_app/responses/movie_response.dart';
import 'package:my_movies_app/services/api.dart';

class HomeController extends GetxController {
  var isLoadingNowPlaying = true.obs;
  var isLoadingUpcoming = true.obs;
  var isLoadingPopular = true.obs;

  var nowPlayingMovies = <Movie>[];
  var popularMovies = <Movie>[];
  var upcomingMovies = <Movie>[];

  @override
  void onInit() {
    getNowPlayingMovies();
    getPopularMovies();
    getUpcomingMovies();
    super.onInit();
  } //end of on init

  Future<void> getNowPlayingMovies() async {
    isLoadingNowPlaying.value = true;

    nowPlayingMovies.clear();
    var response = await Api.getMovies(type: 'now_playing');
    var movieResponse = MovieResponse.fromJson(response.data);

    nowPlayingMovies.addAll(movieResponse.movies);
    isLoadingNowPlaying.value = false;
  } //end of getNowPlayingMovies

  Future<void> getPopularMovies() async {
    isLoadingPopular.value = true;

    popularMovies.clear();
    var response = await Api.getMovies(type: 'popular');
    var movieResponse = MovieResponse.fromJson(response.data);

    popularMovies.addAll(movieResponse.movies);
    isLoadingPopular.value = false;
  } //end of getTrendingMovies

  Future<void> getUpcomingMovies() async {
    isLoadingUpcoming.value = true;

    upcomingMovies.clear();
    var response = await Api.getMovies(type: 'upcoming');
    var movieResponse = MovieResponse.fromJson(response.data);

    upcomingMovies.addAll(movieResponse.movies);
    isLoadingUpcoming.value = false;
  } //end of getTrendingMovies
} //end of controller
