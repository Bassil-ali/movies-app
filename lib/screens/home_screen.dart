import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/home_controller.dart';
import 'package:my_movies_app/models/movie.dart';
import 'package:my_movies_app/screens/movie_detail_screen.dart';
import 'package:my_movies_app/screens/movies_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildLandscapeMovieList(
                    title: 'Now playing',
                    isLoading: homeController.isLoadingNowPlaying.value,
                    movies: homeController.nowPlayingMovies,
                  ),
                  SizedBox(height: 20),
                  buildPortraitMovieList(
                    title: 'Popular',
                    type: 'popular',
                    isLoading: homeController.isLoadingPopular.value,
                    movies: homeController.popularMovies,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildPortraitMovieList(
                    title: 'Upcoming',
                    type: 'upcoming',
                    isLoading: homeController.isLoadingUpcoming.value,
                    movies: homeController.upcomingMovies,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildLandscapeMovieList({
    required String title,
    required bool isLoading,
    required List<Movie> movies,
  }) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${title}', style: TextStyle(fontSize: 20)),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(title: '${title}', type: 'now_playing'),
                  preventDuplicates: false,
                );
              },
              child: Text(
                'Show All...',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 260,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return buildLandscapeMovieCard(movie: movies[index]);
                  },
                  separatorBuilder: (content, index) {
                    return SizedBox(width: 10);
                  },
                ),
        ),
      ],
    );
  } // end of buildLandscapeMovieList

  Widget buildLandscapeMovieCard({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(
          () => MovieDetailScreen(movie: movie),
          preventDuplicates: false,
        );
      },
      child: Container(
        height: double.infinity, //260
        width: 340,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200, //255 - 55 = 200
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '${movie.banner}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${movie.title}',
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 22,
                        ),
                        Text(
                          '${movie.vote}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // end of buildLandscapeMovieCard

  Widget buildPortraitMovieList({
    required String title,
    required String type,
    required bool isLoading,
    required List<Movie> movies,
  }) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${title}', style: TextStyle(fontSize: 20)),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(title: title, type: type),
                  preventDuplicates: false,
                );
              },
              child: Text(
                'Show All...',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 250,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return buildPortraitMovieCard(movie: movies[index]);
                  },
                  separatorBuilder: (content, index) {
                    return SizedBox(width: 10);
                  },
                ),
        ),
      ],
    );
  } // end of buildLandscapeMovieList

  Widget buildPortraitMovieCard({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(
          () => MovieDetailScreen(movie: movie),
          preventDuplicates: false,
        );
      },
      child: Container(
        height: double.infinity, //255
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 210, //255 - 55 = 200
              child: Stack(
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${movie.poster}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Text(
              '${movie.title}',
              style: TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  } // end of buildLandscapeMovieCard

} //end of class
