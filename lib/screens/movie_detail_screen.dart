import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/movie_controller.dart';
import 'package:my_movies_app/models/actor.dart';
import 'package:my_movies_app/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

import 'actor_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final movieController = Get.find<MovieController>();

  @override
  void initState() {
    movieController.getActors(movieId: widget.movie.id);
    movieController.getRelatedMovies(movieId: widget.movie.id);
    super.initState();
  } //end of init state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 280,
            backgroundColor: Colors.amber,
            flexibleSpace: FlexibleSpaceBar(
              background: buildTopBanner(movie: widget.movie),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              return Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildDetails(movie: widget.movie),
                    SizedBox(height: 18),
                    buildActors(),
                    SizedBox(height: 18),
                    buildRelatedMovies(),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget buildTopBanner({required Movie movie}) {
    return Stack(
      children: <Widget>[
        Image.network(
          '${movie.banner}',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: null,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Chip(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.amber,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.black),
                    Text('${movie.vote}', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              Text(
                '${movie.title}',
                style: TextStyle(fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Wrap(
                spacing: 5,
                runSpacing: -8,
                children: [
                  ...movie.genres.map((genre) {
                    return Chip(
                      label: Text('${genre.name}', style: TextStyle(fontSize: 11)),
                    );
                  })
                ],
              ),
            ],
          ),
        )
      ],
    );
  } // end of TopBanner

  Widget buildDetails({required Movie movie}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Details',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          '${movie.description}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            height: 1.3,
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Container(
              width: 120,
              child: Text(
                'Release date:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text('${movie.releaseDate}', style: TextStyle(color: Colors.grey[400])),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              width: 120,
              child: Text(
                'Vote count:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              '${movie.voteCount}',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ],
    );
  } // end of Details

  Widget buildActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actors',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: movieController.isLoadingActors.value
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: movieController.actors.length,
                  itemBuilder: (context, index) {
                    return buildActorItem(actor: movieController.actors[index]);
                  },
                  separatorBuilder: (content, index) {
                    return SizedBox(width: 15);
                  },
                ),
        ),
      ],
    );
  } // end of Actors

  Widget buildActorItem({required Actor actor}) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ActorScreen(actor: actor),
          preventDuplicates: false,
        );
      },
      child: Container(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 150,
              height: 200,
              child: Stack(
                // alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${actor.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${actor.name}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  } // end of Actor

  Widget buildRelatedMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Related movies',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 370,
          child: movieController.isLoadingRelatedMovies.value
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: movieController.relatedMovies.length ~/ 2,
                  itemBuilder: (context, index) {
                    int relatedMoviesLength = movieController.relatedMovies.length ~/ 2;
                    return Column(
                      children: <Widget>[
                        //0 .. 4
                        buildRelatedMovieItem(movie: movieController.relatedMovies[index]),
                        SizedBox(height: 20),
                        //5 .. 9
                        buildRelatedMovieItem(
                          movie: movieController.relatedMovies[relatedMoviesLength + index],
                        )
                      ],
                    );
                  },
                  separatorBuilder: (content, index) {
                    return SizedBox(width: 10);
                  },
                ),
        )
      ],
    );
  } // end of RelatedMovie

  Widget buildRelatedMovieItem({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(
          () => MovieDetailScreen(movie: movie),
          preventDuplicates: false,
        );
      },
      child: Container(
        width: 350,
        height: 170,
        child: Row(
          children: <Widget>[
            Container(
              width: 120,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${movie.poster}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${movie.title}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber),
                      Text('${movie.vote}'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${movie.description}',
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Wrap(
                    spacing: 5,
                    runSpacing: -13,
                    children: [
                      ...movie.genres.take(3).map(
                        (genre) {
                          return Chip(
                            label: Text('${genre.name}', style: TextStyle(fontSize: 11)),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  } // end of RelatedMovieItem
} //end of widget
