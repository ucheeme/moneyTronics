
import 'dart:convert';

import 'package:moneytronic/ApiService/ApiService.dart';
import 'package:moneytronic/repository/apiRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../../ApiService/ApiUrl.dart';
import '../../cubits/loginCubit/loginFormValidation.dart';
import '../../models/response/AccountNumberResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/LoginResponse.dart';

class LoginRepository extends ApiRepository{
  Future<Object> createUser(request) async {
    var response = await postRequest(request, AppUrls.createUser, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        AccountNumberResponse res = accountNumberResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> login(request) async {
    var response = await postRequest(request, AppUrls.loginUser, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        try {
          LoginResponse res = loginResponseFromJson(json.encode(r.result?.data));
          res.token = r.result?.token?.accessToken ?? "";
          return res;
        }catch (e){
          print("error $e");
          return r;
        }
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> verifyRegistration(request) async {
    var response = await postRequest(request, AppUrls.verifyRegistration, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        AccountNumberResponse res = accountNumberResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}

