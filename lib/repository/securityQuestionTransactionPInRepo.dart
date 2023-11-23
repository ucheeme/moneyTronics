
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/SecurityQuestionsResponse.dart';
import '../models/response/SimpleApiResponse.dart';
import 'apiRepository.dart';

@Injectable()
class SecurityQuestionTransactionPinRepository extends ApiRepository {
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
  Future<Object> setSecurityQuestion(request) async {
    var response = await postRequest(request, AppUrls.setSecurityQuestion, true, HttpMethods.post);
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
}