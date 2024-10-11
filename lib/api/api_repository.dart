import 'dart:async';

import 'package:capusle_rewards/api/result.dart';
import 'package:capusle_rewards/models/models.dart';
import 'package:capusle_rewards/models/response/activity_response.dart';
import 'package:capusle_rewards/models/response/firebase_login_response.dart';
import 'package:capusle_rewards/models/response/projects_response.dart';
import 'package:capusle_rewards/models/response/users_response.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<Either<ApiError, FirebaseLoginResponse>> firebaseLogin(
      String idToken) async {
    final result = await apiProvider.firebaseLogin(
        ApiConstants.FIREBASE_LOGIN_ENDPOINT, idToken);

    return result.fold(
      (error) {
        printError(info: error.error);
        return Left(error);
      },
      (res) {
        printInfo(info: res.body.toString());
        return Right(FirebaseLoginResponse.fromJson(res.body));
      },
    );
  }

  Future<Either<ApiError, void>> logout() async {
    final result = await apiProvider.postRequest(ApiConstants.LOGOUT);

    return result.fold(
      (error) => Left(error),
      (res) => Right(res.body),
    );
  }

  Future<Either<ApiError, User>> getMe() async {
    final result = await apiProvider.getRequest(ApiConstants.GET_ME);
    return result.fold(
      (error) => Left(error),
      (res) => Right(User.fromJson(res.body)),
    );
  }

  //Join project with slug
  Future<Either<ApiError, void>> joinProject(
      String slug, String timezone) async {
    final result = await apiProvider.getRequest(
      ApiConstants.JOIN_PROJECT.replaceAll("{slug}", slug) +
          "?timezone=" +
          timezone,
    );
    return result.fold(
      (error) => Left(error),
      (res) => Right(res.body),
    );
  }

  Future<Either<ApiError, void>> joinActivity(
      String id, String timezone) async {
    final result = await apiProvider.getRequest(
      ApiConstants.JOIN_PROJECT_ACTIVITY.replaceAll("{pk}", id) +
          "?timezone=" +
          timezone,
    );
    return result.fold(
      (error) => Left(error),
      (res) => Right(res.body),
    );
  }

  //leave project with slug
  Future<Either<ApiError, void>> leaveProject(String slug) async {
    final result = await apiProvider.getRequest(
      ApiConstants.LEAVE_PROJECT.replaceAll("{slug}", slug),
    );
    return result.fold(
      (error) => Left(error),
      (res) => Right(res.body),
    );
  }

  Future<Either<ApiError, ProjectsResponse>> getProjects() async {
    final result = await apiProvider.getRequest(ApiConstants.GET_PROJECTS);
    return result.fold(
      (error) => Left(error),
      (res) => Right(ProjectsResponse.fromJson(res.body)),
    );
  }

  Future<Either<ApiError, ActivityResponse>> getProjectActivities(
      String slug) async {
    final result = await apiProvider.getRequest(
        ApiConstants.GET_PROJECTS_ACTIVITUES.replaceAll("{slug}", slug));
    return result.fold(
      (error) => Left(error),
      (res) => Right(ActivityResponse.fromJson(res.body)),
    );
  }

  Future<Either<ApiError, ActivityResponse>> getUserActivities() async {
    final result =
        await apiProvider.getRequest(ApiConstants.GET_USER_ACTIVITIES);
    return result.fold(
      (error) => Left(error),
      (res) => Right(ActivityResponse.fromJson(res.body)),
    );
  }

  Future<Either<ApiError, dynamic>> deleteAccount() async {
    final result = await apiProvider.deleteRequest(ApiConstants.GET_ME);
    return result.fold(
      (error) => Left(error),
      (res) => Right(res.body),
    );
  }
}
