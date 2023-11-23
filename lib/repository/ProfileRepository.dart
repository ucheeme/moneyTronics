import 'dart:convert';


import 'package:injectable/injectable.dart';

import '../ApiService/ApiService.dart';
import '../ApiService/ApiUrl.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/CreateAdditionalAccountResponse.dart';
import '../models/response/FinedgeProduct.dart';
import '../models/response/SimpleApiResponse.dart';
import 'SettingsRepository.dart';

@Injectable()
class ProfileRepository extends SettingsRepository {
  Future<Object> getCustomerDetails() async {
    var response = await postRequest(null, AppUrls.getCustomerDetails, true, HttpMethods.get);
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
  Future<Object> getProduct() async {
    var response = await postRequest(null, AppUrls.getProduct, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        List<FinedgeProduct> res = finedgeProductFromJson(json.encode(r.result?.data));
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
  Future<Object> createAdditionalAccount(request) async {
    var response = await postRequest(request, AppUrls.createAdditionalAccount, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is ApiResponse) {
      if (r.success == true) {
        CreateAdditionalAccountResponse res = createAdditionalAccountResponseFromJson(json.encode(r.result?.data));
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