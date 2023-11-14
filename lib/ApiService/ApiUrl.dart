



import '../Env/env.dart';

class AppUrls {
  static const baseUrl = Env.baseUrl;
  static const apiGateWay = Env.apiGateway;
  static const createUser = '$apiGateWay/account/register-new-user';
  static const loginUser = '$apiGateWay/account/login';
  static const verifyRegistration = '$apiGateWay/account/finalize-registration';
  static const getSecretQuestions = '$apiGateWay/utilities/secret-questions';
  static const getUserAccount = '$apiGateWay/profile/get-accounts';
  static const setTransactionPin = '$apiGateWay/settings/set-transaction-pin';
  static const setSecurityQuestion = '$apiGateWay/settings/set-SecretQuestion-Answer';
  static const getFixedDeposit = '$apiGateWay/fixed-deposit';
  static const fixedDepositInvest = '$apiGateWay/fixed-deposit/invest';
  static const fixedDepositProducts = '$apiGateWay/fixed-deposit/products';
  static const fixedDepositCalculator = '$apiGateWay/fixed-deposit/calculator';
  static const changePassword = '$apiGateWay/settings/changepassword';
  static const forgotPasswordOtp = '$apiGateWay/settings/forget-password';
  static const resetPassword = '$apiGateWay/settings/password-reset';
  static const resetTPin = '$apiGateWay/settings/reset-transaction-pin';
  static const sendOtp = '$apiGateWay/account/send-otp';
  static const getCustomerDetails = '$apiGateWay/profile/customer-details';
  static const createAdditionalAccount = '$apiGateWay/account/create-additional-account';
  static const getProduct = '$apiGateWay/utilities/get-products';
}
class ApiResponseCodes {
  static const success = 200;
  static const error = 400;
  static const internalServerError = 500;
  static const authorizationError = 401;
  static const invalidData = 404;
  static const newDevice = 180;
  static const incompleteRegistration = 190;
  static const changePassword = -60;
}