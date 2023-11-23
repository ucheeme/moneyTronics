
import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';

import '../UiUtil/TransactionPin.dart';
import '../UiUtil/loadingDialog.dart';
import '../UiUtil/textWidgets.dart';
import '../models/response/ApiResonse2.dart' as model2;
import '../models/response/ApiResponse.dart';
import 'constants/Themes/colors.dart';



final currencyFormatter =  NumberFormat("#,##0.00", "en_US");

class AppUtils{
  static String convertDateTimeDisplay(String date, String format) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat(format);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  static String convertDate(DateTime now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String convertDateWithCustomFormat(String date, String format) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat(format);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  static String convertDateSystem(DateTime now, {format = 'dd-MM-yyyy'}) {
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(now);
    return formatted;
  }
  static void showSnack(String msg, BuildContext? context){
    CherryToast.error(
        title:   Text(msg)
    ).show(context!);
  }
  static void showSuccessSnack(String msg, BuildContext? context){
    CherryToast.success(
        title:   Text(msg)
    ).show(context!);
  }
  static void showInfoSnack(String msg, BuildContext? context){
    CherryToast.info(
        title:   Text(msg)
    ).show(context!);
  }
  static ApiResponse defaultErrorResponse({String? msg = "Error occurred"}){
    var returnValue =  ApiResponse();
    returnValue.result = Result();
    returnValue.result!.message = msg;
    return returnValue;
  }

  static model2.ApiResponse2 defaultErrorResponse2({String? msg = "Error occurred"}){
    var returnValue =  model2.ApiResponse2();
    returnValue.result = model2.Result();
    returnValue.result!.message = msg;
    return returnValue;
  }

  static Widget loadingWidget( {required bool isLoading, required Widget child}){
    return LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: const SpinKitCubeGrid(
          color: AppColors.moneyTronicsBlue,
          size: 50.0,
        ),
        child: child);
  }
  Widget loadingWidget2( {required bool isLoading, required Widget child , loaderTitle, loaderDescription, required BuildContext context}){
    if (isLoading){
      FocusManager.instance.primaryFocus?.unfocus();
    }
    return Stack(
        children: [
          Container(child: child,),
          isLoading ? Container(
            color: Colors.black.withOpacity(0.5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(

              children: [
                Spacer(),
                Container(
                  width: double.infinity,height: 247.h,
                  color: AppColors.white,
                  child: Column(
                    children: [
                      gapHeight(30.h),
                      loadingIndicator(),
                      gapHeight(25.h),
                      SizedBox(
                        width: 270.w,
                        child: Column(children: [
                          ctmTxtGroteskMid("Processing", AppColors.black, 24.sp),
                          gapHeight(15.h),
                          ctmTxtGroteskMid("Please wait while we process your request",
                              AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.center)


                        ],),
                      ),
                    ],
                  ),
                ),
              ],
            ),): gapHeight(1.0)
        ]);
  }
  Container loadingIndicator() {
    return Container(
      width: 270.w,height:35.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.10),
          ),
          BoxShadow(
            color: AppColors.moneyTronicsSkyBlue,
            spreadRadius: -0.0,
            blurRadius: 10.r,
            offset: const Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          greenCircle(),
          SizedBox(width: 200.w,height: 15.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                backgroundColor: AppColors.moneyTronicsBlue,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.moneyTronicsSkyBlue),
              ),
            ),
          ),
          greenCircle(),
        ],),

    );
  }
  Container greenCircle() {
    return Container(
      width: 15.h,height: 18.r,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.moneyTronicsBlue
      ),

    );
  }
  dismissibleBottomSheet(BuildContext context, Widget modal, double height, {Function()? onTap}) async{
    await showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => SafeArea(
          child: Container(height: height,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:  modal
          ),
        )
    ).then((value) => onTap);
  }

  static showLoadingDialog(BuildContext context, String title, bool show) async {
    if (show) {
      openBottomSheet(context, const LoadingDialog(
        title: "Processing",
        description: "Hold on a minute, while we process your request",)
      );
    }else{
      Navigator.pop(context);
    }
  }
  static void debug(dynamic msg){
    if (kDebugMode) {
      print(msg);
    }
  }
  static void showAlertDialog(BuildContext context, onTap, {String? msg}) {
    Widget okButton = ElevatedButton(onPressed: onTap, child: const Text("Done"));
    AlertDialog alert = AlertDialog(content:  Text(msg ?? "Action Successful!"),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  static String currency(BuildContext context) {
    var format = NumberFormat.simpleCurrency(name: "NGN");
    return "NGN";
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return false;
    }
    else {
      return true;
    }
  }
  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp =  RegExp(pattern);
    if (value.isEmpty) {
      return false;
    }
    if (value.length != 11) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r"[a-z]"))) return false;
    if (!password.contains(RegExp(r"[A-Z]"))) return false;
    if (!password.contains(RegExp(r"[0-9]"))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }


  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
  static String? parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString = parse(document.body?.text).documentElement?.text;
    return parsedString;
  }
  static String? parseHtml(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString = parse(document.body?.text).documentElement?.outerHtml;
    return parsedString;
  }
}



bool validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern as String);
  if (!regex.hasMatch(value)) {
    return false;
  }
  else {
    return true;
  }
}
bool validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp =  RegExp(pattern);
  if (value.isEmpty) {
    return false;
  }
  if (value.length < 10) {
    return false;
  }
  // else if (!regExp.hasMatch(value)) {
  //   return false;
  // }
  return true;
}

bool isPasswordValid(String password) {
  if (password.length < 8) return false;
  if (!password.contains(RegExp(r"[a-z]"))) return false;
  if (!password.contains(RegExp(r"[A-Z]"))) return false;
  if (!password.contains(RegExp(r"[0-9]"))) return false;
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
  return true;
}
String getTimeDifference(String timeStamp){
  DateTime currentTime = DateTime.now();
  DateTime elapseTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timeStamp));
  if (currentTime.difference(elapseTime).inDays > 0)
  {
    return "${currentTime.difference(elapseTime).inDays} day(s) ago";
  }
  if (currentTime.difference(elapseTime).inHours > 0)
  {
    return "${currentTime.difference(elapseTime).inHours} hour(s) ago";
  }
  if (currentTime.difference(elapseTime).inMinutes > 0)
  {
    return "${currentTime.difference(elapseTime).inMinutes} minute(s) ago";
  }
  return "${currentTime.difference(elapseTime).inSeconds} sec(s) ago";
}

abstract class PostWidgetCallback{
  postWidgetBuild(Function() proceed);
}
nonDismissibleBottomSheet(BuildContext context, Widget modal) {
  showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SafeArea(
        child: Container(height: 700.h,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child:  modal
        ),
      )
  );
}

logReport(dynamic result){
  print("printing result: $result");
}

dismissibleBottomSheet(BuildContext context, Widget modal, double height, {Function()? onTap}) async{
  await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => SafeArea(
        child: Container(height: height,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child:  modal
        ),
      )
  ).then((value) => onTap);
}

void openPinScreen(BuildContext context, Function(String) completionHandler)async {
  var pin = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
      TransactionPinScreen()));
  if (pin != null){
    AppUtils.debug("pin entered $pin");
    completionHandler(pin);
  }
}