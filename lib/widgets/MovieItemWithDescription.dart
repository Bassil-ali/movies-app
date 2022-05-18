import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/models/movie.dart';
import 'package:my_movies_app/screens/movie_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieItemWithDescription extends StatelessWidget {
  final Movie movie;

  MovieItemWithDescription({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => MovieDetailScreen(movie: movie),
          preventDuplicates: false,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            height: 200,
            child: Stack(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${movie.poster}',
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //movie name
                    Expanded(
                      child: Text(
                        '${movie.title}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    //icon and rating
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text('${movie.vote}', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '${movie.description}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
} //end of widget
