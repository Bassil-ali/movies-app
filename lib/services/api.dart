import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies.app.bassilali.com',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = await GetStorage().read('login_token');

        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        };

        request.headers.addAll(headers);
        print('${request.method} ${request.path}');
        print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        print('${response.data}');
        if (response.data['error'] == 1) throw response.data['message'];

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        if (GET.Get.isDialogOpen == true) {
          GET.Get.back();
        }

        GET.Get.snackbar(
          'error'.tr,
          '${error.message}',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> getGenres() async {
    return dio.get('/api/genres');
  } //end of getGenres

  static Future<Response> getMovies({
    int page = 1,
    String? type,
    int? genreId,
    int? actorId,
  }) async {
    return dio.get('/api/movies', queryParameters: {
      'page': page,
      'type': type,
      'genre_id': genreId,
      'actor_id': actorId,
    });
  } //end of getMovies

  static Future<Response> getActors({required int movieId}) async {
    return dio.get('/api/movies/${movieId}/actors');
  } //end of actors

  static Future<Response> getRelatedMovies({required int movieId}) async {
    return dio.get('/api/movies/${movieId}/related_movies');
  } //end of actors

  static Future<Response> login({required Map<String, dynamic> loginData}) async {
    FormData formData = FormData.fromMap(loginData);
    return dio.post('/api/login', data: loginData);
  } //end of login

  static Future<Response> register({required Map<String, dynamic> registerData}) async {
    FormData formData = FormData.fromMap(registerData);
    return dio.post('/api/register', data: formData);
  } //end of register

  static Future<Response> getUser() async {
    return dio.get('/api/user');
  } //end of getUser

} //end of api
