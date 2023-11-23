import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResonse2.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/BillsResponse/BillMakeBillsPaymentResponse.dart';
import '../models/response/BillsResponse/BillerGroupsDetailsResponse.dart';
import '../models/response/BillsResponse/BillerGroupsResponse.dart';
import '../models/response/BillsResponse/BillerPackageResponse.dart';
import '../models/response/BillsResponse/BillsCustomerLookUpResponse.dart';
import '../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../models/response/SimpleApiResponse.dart';
import 'apiRepository.dart';




@Injectable()
class BillRepository extends ApiRepository {
  Future<Object> getNetworkProviders() async {
    var response = await postRequest(null, AppUrls.networkPlans, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        NetworkPlansResponse res = networkPlansResponseFromJson(json.encode(r.result?.data));
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
  Future<Object> vend(request) async {
    var response = await postRequest(request, AppUrls.airtimeVend, true, HttpMethods.post);
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
  Future<Object> getBillerGroups() async {
    var response = await postRequest2(null, AppUrls.billerGroupsUrl, true, HttpMethods.get);
    var r = handleSuccessResponse2(response);
    if (r is ApiResponse2) {
      if (r.success == true) {
        List<BillerGroupsResponse> res = billerGroupsResponseFromJson(json.encode(r.result?.responseData));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse2(response);
      return errorResponse2!;
    }
  }
  Future<Object> getBillerGroupsDetails(int billerId) async {
    var response = await postRequest2(null, AppUrls.billerGroupsDetailsUrl+billerId.toString(), true, HttpMethods.get);
    var r = handleSuccessResponse2(response);
    if (r is ApiResponse2) {
      if (r.success == true) {
        List<BillerGroupsDetailsResponse> res = billerGroupsDetailsResponseFromJson(json.encode(r.result?.responseData));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse2(response);
      return errorResponse2!;
    }
  }
  Future<Object> getBillerPackage(String categorySlug) async {
    var response = await postRequest2(null, AppUrls.billerPackageUrl+categorySlug, true, HttpMethods.get);
    var r = handleSuccessResponse2(response);
    if (r is ApiResponse2) {
      if (r.success == true) {
        List<BillerPackageResponse> res = billerPackageResponseFromJson(json.encode(r.result?.responseData));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse2(response);
      return errorResponse2!;
    }
  }
  Future<Object> getBillerCustomerLookUp(request) async {
    var response = await postRequest2(request,AppUrls.billerCustomerLookUpUrl,true,HttpMethods.post);
    var r = handleSuccessResponse2(response);
    if (r is ApiResponse2) {
      if (r.success == true) {
        BillsCustomerLookUpResponse res = billsCustomerLookUpResponseFromJson(json.encode(r.result?.responseData));
        return res;
      } else {
        handleErrorResponse(response as ApiResponse);
        return errorResponse!;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> postMakeBillPayment(request) async {
    var response = await postRequest2(request,AppUrls.billerMakePaymentUrl,true,HttpMethods.post);
    var r = handleSuccessResponse2(response);
    if (r is ApiResponse2) {
      if (r.success == true) {
        BillMakeBillsPaymentResponse res = billMakeBillsPaymentResponseFromJson(json.encode(r.result?.responseData));
        return res;
      } else {
        handleErrorResponse(response as ApiResponse);
        return errorResponse!;
       // return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}