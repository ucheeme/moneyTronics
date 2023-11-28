import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:local_auth/local_auth.dart';

import 'package:moneytronic/views/startScreen/signUpScreen/signUpScreen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../UiUtil/Alerts/AlertDialog.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../bloc/LoginBloc/login_bloc.dart';
import '../../../controllers/Controller/loginController.dart';
import '../../../models/requests/LoginRequest.dart';
import '../../../models/response/LoginResponse.dart';
import '../../../repository/DashboardRepository.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/userUtil.dart';
import '../../appScreens/bottomNav.dart';
import '../../appScreens/settings/device_registration.dart';
import '../loginOrSignUpScreen.dart';
import 'ForgotPasswordScreen.dart';


LoginResponse? loginResponse;
LoginRequest? loginRequest;

class LoginFirstTime extends StatefulWidget {
  const LoginFirstTime({super.key});
  @override
  State<LoginFirstTime> createState() => _LoginFirstTimeState();
}

class _LoginFirstTimeState extends State<LoginFirstTime> implements PostWidgetCallback {
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  var goToLoginSubject = PublishSubject<bool>();
  late LoginBloc bloc;
  final LocalAuthentication auth = LocalAuthentication();
  var canAuthenticateWithBiometrics = false;
  var biometricEnabled = false;
  initBiometric() async {
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    await _getSavedValidateUserRequest();
    biometricEnabled =   await SharedPref.getBool(SharedPrefKeys.enableBiometric);
    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();
    if (canAuthenticateWithBiometrics && biometricEnabled) {
      if (availableBiometrics.isNotEmpty) {
        if (availableBiometrics.contains(BiometricType.weak) ||
            availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.fingerprint)) {
          AppUtils.debug("available biometric weak or strong");
        } else {
          AppUtils.debug("available biometric face");
        }
      }
    }
    setState(() {});
  }
  _getSavedValidateUserRequest() async {
    try {
      var userPref = await SharedPref.read(SharedPrefKeys.loginRequestInfo);
      loginRequest = LoginRequest.fromJson(userPref);
      userNameControl.text = loginRequest?.clientId ?? "";
      bloc.validation.setClientId(loginRequest?.clientId ?? "");
    } catch (e) {
      AppUtils.debug("could not get login request $e");
    }
  }
  _authenticateWithBiometric() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to login');
      if (didAuthenticate){
        if (loginRequest != null) {
          bloc.add(LoginEventLoginUser(loginRequest!));
        }
      }
    } on PlatformException {
      // ...
    }
  }
  @override
  void initState() {
    super.initState();
    _getSavedValidateUserRequest();
    initBiometric();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<LoginBloc>();
    bloc.errorObs.listen((value){
      AppUtils.showSnack(value, context);
    });
    return darkStatusBar(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccessfulState){
              loginResponse = state.response;
              loginRequest ??= bloc.validation.loginValidation();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  if (biometricEnabled){
                    openHome();
                    return;
                  }
                  openBottomSheet(isDismissible: false, context, CustomAlertDialog(showIcon: true, body: "Do you want to use your biometric when next you log in",
                      proceedText: "Yes, Enable",
                      declineText: "No, Don't",
                      proceed: () async{
                        await SharedPref.saveBool(SharedPrefKeys.enableBiometric, true).then((value) => openHome());
                      },
                      decline: (){
                        openHome();
                      })
                  );
                  bloc.initial();
                });
              });
            }
            if (state is LoginIncompleteRegistration){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  DashboardRepository().getUsersAccount();
                  bloc.initial();
                });
              });
            }
            if (state is LoginDeviceChangeState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration.zero, (){
                  openDeviceManagement();
                  bloc.initial();
                });
              });
            }
            return  AppUtils().loadingWidget2(
              context: context,
              isLoading: state is LoginStateLoading,
              child: Scaffold(
                backgroundColor: AppColors.whiteFA,
                body: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      width: double.infinity,
                      child: appBarBackAndTxt(title: "",
                          backTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ctmTxtGroteskMid("Welcome to MoneyTronics MFB",
                              weight: FontWeight.w800,
                              AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start),
                          gapH(3.h),
                          ctmTxtGroteskMid("You're about to embark on a seamless financial journey with MoneyTronics MFB. ",
                              AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.start),
                        ],
                     ),
                    ),
                    Padding(
                      padding: screenPadding(),
                      child: SingleChildScrollView(child: Column(children: [
                        gapH(30.h),
                        StreamBuilder<String>(
                            stream: bloc.validation.clientId,
                            builder: (context, snapshot) {
                              return CustomTextFieldWithValidation(
                                controller: userNameControl,
                                title: "Enter your username",
                                details: "",
                                inputType: TextInputType.text,
                                onChange: bloc.validation.setClientId,
                                error: snapshot.hasError ? snapshot.error.toString() : "",
                              );
                            }
                        ),
                      //  gapH(28.h),
                        StreamBuilder<String>(
                            stream:  bloc.validation.clientSecret,
                            builder: (context, snapshot) {
                              return PasswordTextField(
                                controller: passwordControl,
                                title: "Enter password",
                                onChange: bloc.validation.setClientSecret,
                                error: snapshot.hasError ? snapshot.error.toString() : "",);
                            }
                        ),
                        gapH(30.h),
                        forgotPassword(tap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                          const ForgotPasswordScreen()));
                        })
                      ],),),
                    ),
                    gapH(108.h),
                    Row(
                      children: [
                        Expanded(
                          child: blueBtn(title: 'Proceed', tap: () {
                            bloc.add(LoginEventLoginUser(bloc.validation.loginValidation()));
                          }),
                        ),
                        gapW(10.0),
                        biometricEnabled ? GestureDetector(
                          onTap: (){
                            _authenticateWithBiometric();
                          },
                          child: Container(
                            margin: const EdgeInsets
                                .only(right: 20.0),
                            decoration: BoxDecoration(
                              color:AppColors.accent,// Customize the color of the indicator
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                  color: AppColors.primary,
                                  width:0.5.r
                              ),// Customize the border radius
                            ),
                            width: 50,
                            height: 55,
                            child: Center(child:
                            Image.asset("assets/png/icons/face_scan.png",
                              width: 20, height: 20, color: AppColors.primary,)
                            ),
                          ),
                        ) : gapW(1.0)
                      ],
                    ),
                    gapH(10.h),
                    doNotHaveAccount(tap: () {
                      Navigator.pop(context);
                    }),
                    gapH(70.h),
                  ],),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  postWidgetBuild(Function() proceed) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, (){
        proceed;
      });
    });
  }
  void openHome(){
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigator(),
      ), (Route<dynamic> route) => false,);
  }
  void openDeviceManagement() async{
    await Navigator.push(context,
        MaterialPageRoute(
          builder: (context) =>  DeviceRegistrationScreen(username: bloc.validation.loginValidation().clientId),
        )).then((value){
      print("poppped");
      if (value == true){
        bloc.add(LoginEventLoginUser(bloc.validation.loginValidation()));
      }
    });
  }
}

