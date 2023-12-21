import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/views/startScreen/login/loginFirstTime.dart';
import 'package:share_plus/share_plus.dart';

import '../UiUtil/CustomListBottomsheet.dart';
import '../UiUtil/bottomsheet/successAlertBottomSheet.dart';
import '../UiUtil/customTextfield.dart';
import '../UiUtil/customWidgets.dart';
import '../UiUtil/selectionTextField.dart';
import '../bloc/AuthBloc/auth_bloc.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/SecurityQuestionsResponse.dart';
import '../models/response/validateExistingUserAccountResponsse.dart';
import '../utils/appUtil.dart';
import '../utils/constants/Themes/colors.dart';

class CreateExistingUserScreen extends StatefulWidget {
  final ValidateExistingUserAccountResponse? userData;
  final String otp;
  const CreateExistingUserScreen({super.key, required this.userData, required this.otp});

  @override
  State<CreateExistingUserScreen> createState() => _CreateExistingUserScreenState();
}

class _CreateExistingUserScreenState extends State<CreateExistingUserScreen> {
  TextEditingController selectedQuestionControl = TextEditingController();
  TextEditingController questionResponseControl = TextEditingController();
  List<SecurityQuestion> securityQuestions = [];
  SecurityQuestion? selectedQuestion;
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    selectedQuestionControl.text = "Enter your security question";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const SecurityQuestionsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<AuthBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is SecurityQuestionState){
                securityQuestions = state.response;
                bloc.initial();
              }
              if(state is AuthStateCreateExisting){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(Duration.zero, (){
                    _receiptBottomSheet(widget.userData?.accountnumber,state.response.username);
                    bloc.initial();
                  });
                });
              }
              if (state is AuthStateError){
                var vMsg = apiErrorFromJson(json.encode(state.errorResponse.result?.error));
                var msg = vMsg.validationMessages?.isEmpty == true ? state.errorResponse.result?.message ?? "error occurred" : vMsg.validationMessages?[0];
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(Duration.zero, (){
                    AppUtils.showSnack(msg ?? "Error occurred", context);
                  });
                });
                bloc.initial();
              }

              return AppUtils().loadingWidget2(
                child: Column(children: [
                  appBarBackAndTxt(title: "Mobile banking registration",
                      backTap: (){Navigator.pop(context);}),
                  Expanded(child:
                  Padding(
                    padding: screenPadding(),
                    child: SingleChildScrollView(child: Column(children: [
                      gapH(30.h),
                      StreamBuilder<String>(
                          stream: bloc.validation.username,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation (
                              controller:null, title: "Username",
                              details: "", inputType:TextInputType.text,
                              onChange: bloc.validation.setUsername,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                            );
                          }
                      ),
                      StreamBuilder<Object>(
                          stream: bloc.validation.email,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation(
                              controller:null, title: "Email",
                              details: "", inputType:TextInputType.emailAddress,
                              onChange: bloc.validation.setEmail,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                            );
                          }
                      ),
                      StreamBuilder<Object>(
                          stream: bloc.validation.password,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation (
                              controller:null, title: "Password",
                              details: "", inputType:TextInputType.text,
                              onChange: bloc.validation.setPassword,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                              obsureText: true,
                            );
                          }
                      ),
                      StreamBuilder<Object>(
                          stream: bloc.validation.retypePassword,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation (
                              controller:null, title: "Retype password",
                              details: "", inputType:TextInputType.text,
                              onChange: bloc.validation.setRetypePassword,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                              obsureText: true,
                            );
                          }
                      ),
                      StreamBuilder<Object>(
                          stream: bloc.validation.transactionPin,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation (
                              controller:null, title: "Pin",
                              details: "", inputType:TextInputType.number,
                              onChange: bloc.validation.setTransactionPin,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                              obsureText: true,
                            );
                          }
                      ),
                      space(),
                      SelectionTextField(
                          controller: selectedQuestionControl,title:"Select security question",
                          tap: (){
                            showModalBottomSheet(
                                isDismissible: false, isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child:  CustomListBottomSheet(customList: securityQuestions,
                                      maxLines: 2, title: 'Select security question', onSelectedOption:
                                          (value) {
                                        setState(() {
                                          selectedQuestion = value;
                                          bloc.validation.setSecurityQuestion(selectedQuestion!);
                                          selectedQuestionControl.text = value.secretQuestion;
                                        });
                                      },)
                                )
                            );
                          }),
                      gapH(28.h),
                      StreamBuilder<String>(
                          stream: bloc.validation.securityAnswer,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation(
                              controller: null,
                              title: "Security question response",
                              details: "", inputType:TextInputType.text,
                              onChange: bloc.validation.setSecurityAnswer,
                              error: snapshot.hasError ? snapshot.error.toString() : "",);
                          }
                      ),
                      MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                      gapH(50.h): gapH(100.h),// if keyboard is open
                      StreamBuilder<Object>(
                          stream: bloc.validation.existingUserCreateFormValid,
                          builder: (context, snapshot) {
                            return snapshot.hasData && snapshot.data == true ?
                            blueBtn(title: 'Register', tap: () {
                              !snapshot.hasData ? null :
                              bloc.add(AuthEventCreateExistingUser(
                                  bloc.validation.createExistingUser(context,widget.userData,widget.otp)));
                            }): disabledBtn(title: "Register");

                          }
                      ),
                      gapH(50.h),
                    ],),),
                  ))
                ],),
                isLoading: state is AuthStateLoading,
                context: context,
              );
            }
        ),
      ),
    );
  }
  SizedBox space() => gapH(10.h);
  _receiptBottomSheet(accountNumber,username) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => SafeArea(
          child: Container(height: 760.h,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:  SuccessAlertBottomSheet(
                  isSuccessful: true, type: "Mobile banking account created",
                  description: "Your MoneyTronics MFB account number is $accountNumber",
                  shareTap: (){
                    Share.share('My MoneyTronics MFB bank account number $accountNumber');
                  }, downloadTap: () async {
                await Clipboard.setData(ClipboardData(text: 'my flutter MFB bank account number $accountNumber')).then((value) =>
                    AppUtils.showSuccessSnack("account number copied", context));
              },
                  returnTap: (){
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder: (context) => const LoginFirstTime(),
                      ), (Route<dynamic> route) => false,);
                    //
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    // const LoginFirstTime()));
                  })
          ),
        )
    );
  }
}
