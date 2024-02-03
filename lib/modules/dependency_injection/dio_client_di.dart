import 'package:dio/dio.dart';
import 'package:modney_flutter_boilerplate/features/app/models/env_model.dart';
import 'package:modney_flutter_boilerplate/modules/dio/dio_client.dart';
import 'package:modney_flutter_boilerplate/modules/token_refresh/dio_token_refresh.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioInjection {
  Dio dio(EnvModel env, DioTokenRefresh dioTokenRefresh) =>
      initDioClient(env, dioTokenRefresh);
}
