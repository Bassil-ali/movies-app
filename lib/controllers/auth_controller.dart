import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_movies_app/controllers/base_controller.dart';
import 'package:my_movies_app/controllers/genre_controller.dart';
import 'package:my_movies_app/models/user.dart';
import 'package:my_movies_app/responses/user_response.dart';
import 'package:my_movies_app/screens/welcome_screen.dart';
import 'package:my_movies_app/services/api.dart';

class AuthController extends GetxController with BaseController {
  final genreController = Get.put(GenreController());
  var user = User().obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() async {
    await genreController.getGenres();
    redirect();
    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');

    if (token != null) {
      getUser();
    }

    Get.off(() => WelcomeScreen());
  } //end of redirect

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showLoading();
    var response = await Api.login(loginData: loginData);
    var userResponse = UserResponse.fromJson(response.data);

    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;

    hideLoading();

    Get.offAll(() => WelcomeScreen());
  } //end of login

  Future<void> register({required Map<String, dynamic> registerData}) async {
    showLoading();
    var response = await Api.register(registerData: registerData);
    var userResponse = UserResponse.fromJson(response.data);

    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;

    hideLoading();

    Get.offAll(() => WelcomeScreen());
  } //end of login

  Future<void> logout() async {
    await GetStorage().remove('login_token');
    isLoggedIn.value = false;
    Get.offAll(() => WelcomeScreen());
  } //end of logout

  Future<void> getUser() async {
    var response = await Api.getUser();
    var userResponse = UserResponse.fromJson(response.data);
    user.value = userResponse.user;
    isLoggedIn.value = true;
  } //end of getUser
} //end of controller
