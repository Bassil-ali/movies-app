import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/genre_controller.dart';
import 'package:my_movies_app/screens/movies_screen.dart';

class GenresScreen extends StatelessWidget {
  final genreController = Get.find<GenreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: genreController.genres.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(
                      title: '${genreController.genres[index].name}',
                      genreId: genreController.genres[index].id),
                  preventDuplicates: false,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${genreController.genres[index].name}', style: TextStyle(fontSize: 17)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${genreController.genres[index].moviesCount}',
                        style: TextStyle(fontSize: 19)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
