import 'dart:convert';


import 'package:injectable/injectable.dart';
import 'package:moneytronic/repository/DashboardRepository.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/BvnInfoResponse.dart';
import '../models/response/ForgotPasswordOtpResponse.dart';
import '../models/response/SecurityQuestionsResponse.dart';
import '../models/response/SimpleApiResponse.dart';
import 'apiRepository.dart';

@Injectable()
class SettingsRepository extends DashboardRepository {
  Future<Object> getSecurityQuestion() async {
    var response = await postRequest(null, AppUrls.getSecretQuestions, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<SecurityQuestion> res = securityQuestionFromJson(json.encode(r.result?.data));
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
  Future<Object> forgotPassword(request) async {
    var response = await postRequest(request, AppUrls.forgotPasswordOtp, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        ForgotPasswordOtpResponse res = forgotPasswordOtpResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> resetPassword(request) async {
    var response = await postRequest(request, AppUrls.resetPassword, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> changePassword(request) async {
    var response = await postRequest(request, AppUrls.changePassword, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> resetTransactionPin(request) async {
    var response = await postRequest(request, AppUrls.resetTPin, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> uploadDoc(request) async {
    var response = await postRequest(request, AppUrls.docUpload, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> sendOtp(request) async {
    var response = await postRequest(request, AppUrls.sendOtp, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> deviceRegistration(request) async {
    var response = await postRequest(request, AppUrls.deviceRegistration, true, HttpMethods.put);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> bvnInfo() async {
    var response = await postRequest(null, AppUrls.bvnInfo, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        BvnInfoResponse res = bvnInfoResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> accountTierUpgrade(request) async {
    var response = await postRequest(request, AppUrls.accountTierUpgrade, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        SimpleResponse res = simpleResponseFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}