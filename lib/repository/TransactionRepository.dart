


import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../Utils/appUtil.dart';
import '../models/response/AccountVerificationResponse.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/Bank.dart';
import '../models/response/FinEdgeBankVerification.dart';
import '../models/response/SimpleApiResponse.dart';
import '../models/response/TransferResponse.dart';
import 'AuthRepo.dart';

@Injectable()
class TransactionRepository extends AuthRepo {
  Future<Object> getBanks() async {
    var response = await postRequest(null, AppUrls.getBankList, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
       try {
         List<Bank> res = bankFromJson(json.encode(r.result?.data));
         return res;
       }
       catch(e){
         handleErrorResponse(response);
         return errorResponse!;
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
  Future<Object> performTransaction(request) async {
    var response = await postRequest(request, AppUrls.performTransaction, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        TransactionResponse res = transactionResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> saveBeneficiary(request) async {
    var response = await postRequest(request, AppUrls.saveBeneficiary, true, HttpMethods.post);
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
  Future<Object> getAccountVerification(request) async {
    var response = await postRequest(request, AppUrls.accountVerification, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        try {
          FinedgeBankVerification sameBank = finedgeBankVerificationFromJson(json.encode(r.result?.data));
          OtherBankVerification otherBankVerification = otherBankVerificationFromJson(
              json.encode(r.result?.otherBanks));
          return AccountVerificationResponse(finedgeBankVerification: sameBank, otherBankVerification: otherBankVerification);
        }catch (e){
          AppUtils.debug("exception: $e");
          handleErrorResponse(response);
          return errorResponse!;
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
}