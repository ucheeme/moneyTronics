import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';
import '../Env/env.dart';
import '../utils/appUtil.dart';
import 'ApiUrl.dart';
import 'api_status.dart';

String accessToken = "";
enum HttpMethods {
  post, put, patch, get, delete
}
@lazySingleton
class ApiService{
  static var client = http.Client();
  static Dio dio = Dio();
  static  void initiateDio( bool requireAccess , {String baseUrl = AppUrls.baseUrl}) {
     dio.options
       ..baseUrl = baseUrl
       ..validateStatus = (int? status) {
         return status != null && status > 0;
       }
       ..headers = header(requireAccess);
     dio.interceptors.add (
       DioLoggingInterceptor(
         level: Level.body,
         compact: false,
       ),
     );
  }
  static Map<String, dynamic> header(bool requireAccess) {
    return  requireAccess ? {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Cedar-Api-Key':  Env.apiKey,
      'Authorization': 'Bearer $accessToken'
    }: {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'X-Cedar-Api-Key':  Env.apiKey,
      'Accept': 'application/json',
    };
  }
  static Future<Object> makeApiCall(request,url,  bool requireAccess,  {bool? isAdmin = false, HttpMethods method =  HttpMethods.post, String baseUrl = AppUrls.baseUrl}) async {
    initiateDio(requireAccess, baseUrl: baseUrl);
    try {
      var body = request != null ? json.encode(request.toJson()) : null;
      Response<String>? response;
      switch (method) {
        case HttpMethods.post:
          response =  await dio.post(url, data: body);;
          AppUtils.debug("method: post");
          break;
        case HttpMethods.put:
          response =  await dio.put(url, data: body);
          AppUtils.debug("method: put");
          break;
        case HttpMethods.patch:
          response =  await dio.patch(url, data: body);
          AppUtils.debug("method: patch");
          break;
        case HttpMethods.get:
          AppUtils.debug("trying a get request");
          if (request == null){
            response =  await dio.get(url);
          }else {
            print("req to send ${request.toJson}");
            response = await dio.get(url, queryParameters: request.toJson());
          }
          AppUtils.debug("method: get");
          break;
        case HttpMethods.delete:
          response =  await dio.delete(url, data: body);
          AppUtils.debug("method: delete");
          break;
      }
      if (response.statusCode != null) {
        if (response.statusCode == ApiResponseCodes.success ) {
          return Success(response.statusCode!,response.data as String);
        }
        if (ApiResponseCodes.error == response.statusCode || ApiResponseCodes.internalServerError == response.statusCode){
          if (response.data is String) {
            return Failure(response.statusCode ?? 400, (apiResponseFromJson( response.data as String)));
          }else {
            return ForbiddenAccess();
          }
        }
        if (ApiResponseCodes.authorizationError == response.statusCode){
          return ForbiddenAccess();
        }
        else{
          return  Failure(response.statusCode!,"Error Occurred");
        }
      }else{
        return  UnExpectedError();
      }
    } on DioError catch (e){
      AppUtils.debug(e.message);
      return  UnExpectedError();
    }
  }


  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  static apiResponseFromJson(String data) {}
}