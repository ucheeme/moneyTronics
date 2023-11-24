import '../ApiService/ApiService.dart';
import '../ApiService/api_status.dart';
import '../models/response/ApiResonse2.dart';
import '../models/response/ApiResponse.dart';
import '../utils/appUtil.dart';

class ApiRepository{
  ApiResponse? _errorResponse;
  ApiResponse? get errorResponse => _errorResponse;
  setErrorResponse(ApiResponse? value) {
    _errorResponse = value;
  }
  ApiResponse2? _errorResponse2;
  ApiResponse2? get errorResponse2 => _errorResponse2;
  setErrorResponse2(ApiResponse2? value) {
    _errorResponse2 = value;
  }
  handleErrorResponse(dynamic response) {
    if (response is Failure) {
      if (response.errorResponse is ApiResponse) {
        try {

          setErrorResponse(response.errorResponse as ApiResponse?);
        }
        catch (e)
        {
          setErrorResponse(AppUtils.defaultErrorResponse());
        }
      }
      else{
        setErrorResponse(AppUtils.defaultErrorResponse());
      }
    }else if(response is ForbiddenAccess){
      setErrorResponse(AppUtils.defaultErrorResponse());
    }else if(response is UnExpectedError){
      setErrorResponse(AppUtils.defaultErrorResponse());
    }else if(response is NetWorkFailure){
      setErrorResponse(AppUtils.defaultErrorResponse());
    }
  }
  handleErrorResponse2(dynamic response) {
    if (response is Failure) {
      if (response.errorResponse is ApiResponse2) {///not recognising as ApiResponse2
        try {
          setErrorResponse2(response.errorResponse as ApiResponse2);
        }
        catch (e) {
          setErrorResponse2(AppUtils.defaultErrorResponse2());
        }
      }else{
        setErrorResponse2(AppUtils.defaultErrorResponse2());
      }
    }else if(response is ForbiddenAccess){
      setErrorResponse2(AppUtils.defaultErrorResponse2());
    }else if(response is UnExpectedError){
      setErrorResponse2(AppUtils.defaultErrorResponse2());
    }else if(response is NetWorkFailure){
      setErrorResponse2(AppUtils.defaultErrorResponse2());
    }
  }
  Object handleSuccessResponse(dynamic response) {
    if (response is ApiResponse) {
      var r = response;//defaultApiResponseFromJson(response.response as String);
      return r;
    }else{
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Object handleSuccessResponse2(dynamic response) {
    if (response is ApiResponse2) {
      var r = response;//defaultApiResponseFromJson(response.response as String);
      return r;
    }else{
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> postRequest(request, url, requiresToken, HttpMethods method) async {
    var response = await ApiService.makeApiCall(request, url, requiresToken, isAdmin : requiresToken, method: method);
    if(response is Success) {
      var r = apiResponseFromJson(response.response as String);
      return r;
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> postRequest2(request, url, requiresToken, HttpMethods method) async {
    var response = await ApiService.makeApiCall(request, url, requiresToken, isAdmin : requiresToken, method: method);
    if(response is Success) {
      var r = apiResponse2FromJson(response.response as String);
      return r;
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}