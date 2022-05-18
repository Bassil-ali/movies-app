import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: welcomeController.screens[welcomeController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: welcomeController.currentIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Genres',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            welcomeController.currentIndex.value = index;
          },
        ),
      );
    });
  }
}
