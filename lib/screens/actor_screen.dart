import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/movie_controller.dart';
import 'package:my_movies_app/models/actor.dart';
import 'package:my_movies_app/widgets/MovieItemWithDescription.dart';

class ActorScreen extends StatefulWidget {
  final Actor actor;

  ActorScreen({required this.actor});

  @override
  _ActorScreenState createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final movieController = Get.find<MovieController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    movieController.getMovies(actorId: widget.actor.id);

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = movieController.isLoadingPagination.value;
      var hasMorePages = movieController.currentPage.value < movieController.lastPage.value;

      if (sControllerOffset > sControllerMax && isLoadingPagination == false && hasMorePages) {
        movieController.isLoadingPagination.value = true;
        movieController.currentPage.value++;

        movieController.getMovies(actorId: widget.actor.id);
      }
    });
    super.initState();
  } //end of init state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(children: <Widget>[
          buildTopBanner(actor: widget.actor),
          SizedBox(height: 10),
          buildMovieList()
        ]);
      }),
    );
  }

  Widget buildTopBanner({required Actor actor}) {
    return Container(
      height: 300,
      child: Stack(
        // alignment: Alignment.bottomLeft,
        children: <Widget>[
          Image.network(
            '${actor.image}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 65,
                      child: null,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('${actor.image}'),
                      radius: 60,
                      child: null,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text('${actor.name}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 1,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  } // end of TopBanner

  Widget buildMovieList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Movies', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          movieController.isLoading.value == true
              ? Container(
                  height: Get.height / 2,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  children: [
                    ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: movieController.movies.length,
                      itemBuilder: (context, index) {
                        return MovieItemWithDescription(movie: movieController.movies[index]);
                      },
                      separatorBuilder: (content, index) {
                        return SizedBox(height: 10);
                      },
                    ),
                    Visibility(
                      visible: movieController.isLoadingPagination.value,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  } // end of MovieList
} //end of widget
