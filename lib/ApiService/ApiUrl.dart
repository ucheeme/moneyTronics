



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
  static const fixedDepositLiquidationSummary = '$apiGateWay/fixed-deposit/liquidation-summary/';
  static const fixedDepositLiquidation = '$apiGateWay/fixed-deposit/liquidation';
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
  static const networkPlans = '$apiGateWay/bills/network-plans';
  static const airtimeVend = '$apiGateWay/bills/vend';
  static const getBankList = '$apiGateWay/transaction/banks';
  static const performTransaction = '$apiGateWay/transaction/funds-transfer';
  static const transactionHistory = '$apiGateWay/report/transaction-history';
  static const saveBeneficiary = '$apiGateWay/profile/save-beneficiary';
  static const getBeneficiary = '$apiGateWay/profile/get-beneficiaries';
  static const deviceRegistration = '$apiGateWay/settings/update-device';
  static const deleteBeneficiary = '$apiGateWay/profile/delete-beneficiary';
  static const accountVerification = '$apiGateWay/transaction/account-enquiry';
  static const billerGroupsUrl = '$apiGateWay/bills/biller-groups';
  static const billerGroupsDetailsUrl = '$apiGateWay/bills/biller-groupDetails/';
  static const billerPackageUrl = '$apiGateWay/bills/biller-slug/';
  static const billerCustomerLookUpUrl = '$apiGateWay/bills/customer-lookup';
  static const billerMakePaymentUrl = '$apiGateWay/bills/make-payment';
  static const statementRequestUrl = '$apiGateWay/report/statement-request';
  static const billerMakePaymentUrlSec = '$apiGateWay/bills/make-payment-sec';
  static const bvnInfo = '$apiGateWay/bvn/bvn-info';
  static const accountTierUpgrade = '$apiGateWay/account/account-tier-upgrade';
  static const docUpload = "$apiGateWay/utilities/upload-document";
  static const validateExistingBvn = '$apiGateWay/bvn/validate-existing-bvn';
  static const createExistingUser = '$apiGateWay/account/register-existing-user';
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