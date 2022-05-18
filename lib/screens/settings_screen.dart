import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/controllers/auth_controller.dart';
import 'package:my_movies_app/screens/favorite_screen.dart';
import 'package:my_movies_app/screens/login_screen.dart';
import 'package:my_movies_app/screens/register_screen.dart';
import 'package:my_movies_app/widgets/primary_button.dart';

class SettingsScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[buildTopBanner(), buildSettingItems()]),
    );
  }

  Widget buildTopBanner() {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Center(
        child: Text('Settings', style: TextStyle(fontSize: 25, color: Colors.black)),
      ),
    );
  } // end of TopBanner

  Widget buildSettingItems() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: authController.isLoggedIn.value == true
            ? Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorite movies'),
                    onTap: () {
                      Get.to(
                        () => FavoriteScreen(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 150,
                            width: 300,
                            child: Column(
                              children: <Widget>[
                                Text('Confirm logout', style: TextStyle(fontSize: 20)),
                                SizedBox(height: 15),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'Yes',
                                        onPress: () {
                                          authController.logout();
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'No',
                                        onPress: () {
                                           Get.back();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      // authController.logout();
                    },
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Login'),
                    onTap: () {
                      Get.to(
                        () => LoginScreen(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Register'),
                    onTap: () {
                      Get.to(
                        () => RegisterScreen(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                ],
              ));
  } // end of SettingItems
} //end of widget
