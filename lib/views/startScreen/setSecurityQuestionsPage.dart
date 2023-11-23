
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/bloc/setSecreteQuestion/secreteQuestionBloc.dart';

import '../../UiUtil/CustomListBottomsheet.dart';
import '../../UiUtil/customTextfield.dart';
import '../../UiUtil/customWidgets.dart';
import '../../UiUtil/protectAccountScreen.dart';
import '../../UiUtil/selectionTextField.dart';
import '../../bloc/setSecreteQuestion/secreteQuestionEvent.dart';
import '../../bloc/setSecreteQuestion/secreteQuestionState.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../utils/appUtil.dart';
import '../../utils/constants/Themes/colors.dart';

class SetSecurityQuestionsPage extends StatefulWidget {
  const SetSecurityQuestionsPage({super.key});

  @override
  State<SetSecurityQuestionsPage> createState() => _SetSecurityQuestionsPageState();
}

class _SetSecurityQuestionsPageState extends State<SetSecurityQuestionsPage> {
  TextEditingController selectedQuestionControl = TextEditingController();
  TextEditingController questionResponseControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  List<SecurityQuestion> securityQuestions = [];
  SecurityQuestion? selectedQuestion;
  late SetSecreteQuestionBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const SecurityQuestionsEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<SetSecreteQuestionBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SetSecreteQuestionBloc, SecreteQuestionState>(
        builder: (context, state) {
          if (state is SecurityQuestionState){
            securityQuestions = state.response;
          }
          if (state is SetSecurityQuestionState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                openBottomSheet(context, ProtectAccountScreen(title: "Successful",
                    body: "You security question and transaction pin has been "
                        "successfully set", proceedTap: () {
                  // Navigator.pop(context);
                  // Navigator.pop(context);

                }), isDismissible: false);
              });
            });
          }
          return     AppUtils().loadingWidget2(
            context: context,
            isLoading: state is SecreateQuestionStateLoading,
            child: Scaffold(resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.whiteFA,
              bottomSheet: Container(
                color: Colors.white,
                height: 100,
                child: Center(
                  child:   StreamBuilder<bool>(
                      stream: bloc.validation.validateForm,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                          bloc.add(
                              SetSecurityQuestionEvent(
                                  bloc.validation.getSecurityQuestion()
                          )
                          );
                        }) : disabledBtn(title: 'Proceed');
                      }
                  ),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Set security question",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapHeight(30.h),
                    SelectionTextField(controller: selectedQuestionControl,title:"Select security question",
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
                    gapHeight(28.h),
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
                    gapHeight(28.h),
                    MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                    gapHeight(50.h): gapHeight(300.h),// if keyboard is open
                    // gapH(28.h),

                    gapHeight(50.h),
                  ],),),
                )),
              ],),
            ),
          );
        },
      ),
    );
  }
}
