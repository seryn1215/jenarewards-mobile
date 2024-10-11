import 'dart:async';

import 'package:capusle_rewards/shared/storage/storage_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  final token = await StorageUtil.get('token');

  print("TOKEN: $token");

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  request.headers['Authorization'] = 'Token $token';

  EasyLoading.show(status: 'loading...');
  return request;
}
