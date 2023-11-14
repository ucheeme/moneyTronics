import '../ApiService/ApiService.dart';
import '../ApiService/api_status.dart';
import '../models/response/ApiResponse.dart';
import '../utils/appUtil.dart';

class ApiRepository{
  ApiResponse? _errorResponse;
  ApiResponse? get errorResponse => _errorResponse;
  setErrorResponse(ApiResponse? value) {
    _errorResponse = value;
  }
  handleErrorResponse(dynamic response) {
    if (response is Failure) {
      if (response.errorResponse is ApiResponse) {
        try {
          setErrorResponse(response.errorResponse as ApiResponse);
        }
        catch (e) {
          setErrorResponse(AppUtils.defaultErrorResponse());
        }
      }else{
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
  Object handleSuccessResponse(dynamic response) {
    if (response is ApiResponse) {
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
}