import 'package:capusle_rewards/api/base_provider.dart';
import 'package:capusle_rewards/api/result.dart';
import 'package:capusle_rewards/models/models.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';

class ApiProvider extends BaseProvider {
  ApiProvider() {
    allowAutoSignedCert = true;
  }

  Future<Either<ApiError, Response>> firebaseLogin(
      String path, String idToken) async {
    return await postRequest(path, body: {'id_token': idToken});
  }

  Future<Either<ApiError, Response>> postRequest(String path,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      printInfo(info: "Request: $body");
      final response = await super.post(path, body, headers: headers);
      return Right(response);
    } catch (e) {
      return Left(ApiError(error: e.toString()));
    }
  }

  Future<Either<ApiError, Response>> getRequest(String path,
      {Map<String, String>? headers}) async {
    try {
      final response = await super.get(path, headers: headers);
      return Right(response);
    } catch (e) {
      return Left(ApiError(error: e.toString()));
    }
  }

  Future<Either<ApiError, Response>> putRequest(
      String path, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await super.put(path, body, headers: headers);
      return Right(response);
    } catch (e) {
      return Left(ApiError(error: e.toString()));
    }
  }

  Future<Either<ApiError, Response>> deleteRequest(String path,
      {Map<String, String>? headers}) async {
    try {
      final response = await super.delete(path, headers: headers);
      return Right(response);
    } catch (e) {
      return Left(ApiError(error: e.toString()));
    }
  }
}
