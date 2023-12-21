import 'dart:convert';


import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/FDCalculatorResponse.dart';
import '../models/response/FDLiquidationResponse.dart';
import '../models/response/FDProducts.dart';
import '../models/response/FdLiquidationSummaryResponse.dart';
import '../models/response/FixedDepositListResponse.dart';
import '../models/response/FixedDepositResponse.dart';
import 'DashboardRepository.dart';

class FDRepository extends DashboardRepository {

  Future<Object> getFDProducts() async {
    var response = await postRequest(null, AppUrls.fixedDepositProducts, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<FdProducts> res = fdProductsFromJson(json.encode(r.result?.data));
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
  Future<Object> getFDList() async {
    var response = await postRequest(null, AppUrls.getFixedDeposit, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<FixedDepositListResponse> res = fixedDepositListResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> fdInvest(request) async {
    var response = await postRequest(request, AppUrls.fixedDepositInvest, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        FixedDepositResponse res = fixedDepositResponseFromJson(json.encode(r.result?.data));
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

  Future<Object> fdCalculator(request) async {
    var response = await postRequest(request, AppUrls.fixedDepositCalculator, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        FdCalculatorResponse res = fdCalculatorResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> fdLiquidateSummary(accountNumber) async {
    var response = await postRequest(null, AppUrls.fixedDepositLiquidationSummary+accountNumber, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        FixedDepositSummaryResponse res = fixedDepositSummaryResponseFromJson(json.encode(r.result?.data));
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

  Future<Object> fdLiquidate(request) async {
    var response = await postRequest(request, AppUrls.fixedDepositLiquidation, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        FdLiquidationResponse res = fdLiquidationResponseFromJson(json.encode(r.result?.data));
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