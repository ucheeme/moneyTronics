import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/BeneficiaryResponse.dart';
import '../models/response/SimpleApiResponse.dart';
import '../models/response/TransactionHistory.dart';
import '../models/response/UserAccountResponse.dart';
import 'AuthRepo.dart';

@Injectable()
class DashboardRepository extends AuthRepo {
  Future<Object> getUsersAccount() async {
    var response = await postRequest(null, AppUrls.getUserAccount, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<UserAccount> res = userAccountFromJson(json.encode(r.result?.data));
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
  Future<Object> setTransactionPin(request) async {
    var response = await postRequest(request, AppUrls.setTransactionPin, true, HttpMethods.post);
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
  Future<Object> getTransactionHistory(request) async {
    var response = await postRequest(request, AppUrls.transactionHistory, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<TransactionHistoryResponse> res = transactionHistoryResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> getBeneficiary() async {
    var response = await postRequest(null, AppUrls.getBeneficiary, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<Beneficiary> res = beneficiaryFromJson(json.encode(r.result?.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> delBeneficiary(request) async {
    var response = await postRequest(request, AppUrls.deleteBeneficiary, true, HttpMethods.delete);
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
  Future<Object> requestStatement(request) async {
    var response = await postRequest(request, AppUrls.statementRequestUrl, true, HttpMethods.post);
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
  }///


}