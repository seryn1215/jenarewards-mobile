import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';

import '../../shared/storage/storage_util.dart';

FutureOr<Request> authInterceptor(request) async {
  final token = StorageUtil.get('token');

  print("TOKEN: $token");

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  request.headers['Authorization'] = 'Token $token';

  return request;
}
