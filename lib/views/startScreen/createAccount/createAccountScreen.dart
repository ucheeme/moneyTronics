import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:moneytronic/UiUtil/customRadioButton.dart';
import 'package:moneytronic/bloc/AuthBloc/auth_bloc.dart';
import 'package:moneytronic/controllers/Controller/createAcctController.dart';
import 'package:moneytronic/cubits/createAcctCubit/create_acct_cubit.dart';
import 'package:moneytronic/utils/constants/text.dart';

import '../../../UiUtil/bottomsheet/selectTextBottomSheet.dart';
import '../../../UiUtil/customDatePicker.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/datetextField.dart';
import '../../../UiUtil/otpScreen.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import 'createAcct2.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>  {
  var controller = Get.put(CreateAcctController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  @override
  Widget build(BuildContext context) {
   //controller.cubit = context.read<CreateAcctCubit>();
   controller.bloc = context.read<AuthBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteFA,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: appBarBackAndImg(title: AppStrings.createAcctText,
                      backTap: (){Navigator.pop(context);}),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ctmTxtGroteskMid(AppStrings.welcomeText,
                        AppColors.black33,24.sp, weight: FontWeight.w800),
                    gapHeight(20.h),
                    ctmTxtGroteskMid(AppStrings.kindlyFillForm,AppColors.black1A,16.sp,maxLines: 3),
                  ],
                ),),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapHeight(20.h),
                    StreamBuilder<String>(
                        stream: controller.bloc.validation.firstName,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation (
                            controller:null, title: AppStrings.enterFirstNameText,
                            details: "", inputType:TextInputType.text,
                            onChange: controller.bloc.validation.setFirstName,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }
                    ),
                   //gapHeight(28.h),
                    StreamBuilder<Object>(
                        stream: controller.bloc.validation.lastName,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation(
                            controller:null, title: AppStrings.enterLastNameText,
                            details: "", inputType:TextInputType.text,
                            onChange: controller.bloc.validation.setLastName,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }),
                   // gapHeight(28.h),
                        StreamBuilder<Object>(
                            stream: controller.bloc.validation.middleName,
                            builder: (context, snapshot) {
                              return CustomTextFieldWithValidation(
                                controller:null, title: "Middle name",
                                details: "", inputType:TextInputType.text,
                                onChange: controller.bloc.validation.setMiddleName,
                                error: snapshot.hasError ? snapshot.error.toString() : "",
                              );
                            }
                        ),
                       // gapHeight(28.h),
                        StreamBuilder<Object>(
                            stream:controller.bloc.validation.phone,
                            builder: (context, snapshot) {
                              return CustomTextFieldWithValidation(
                                controller:null, title: "Phone number",
                                details: "", inputType:TextInputType.phone,
                                onChange: controller.bloc.validation.setPhone,
                                error: snapshot.hasError ? snapshot.error.toString() : "",
                              );
                            }
                        ),
                       // gapHeight(28.h),
                        StreamBuilder<Object>(
                            stream: controller.bloc.validation.email,
                            builder: (context, snapshot) {
                              return CustomTextFieldWithValidation(
                                controller:null, title: "Email",
                                details: "", inputType:TextInputType.emailAddress,
                                onChange:controller.bloc.validation.setEmail,
                                error: snapshot.hasError ? snapshot.error.toString() : "",
                              );
                            }
                        ),
                       // gapHeight(28.h),
                        DateTextField(controller:controller.dateController, title:"Enter date of birth",
                           tap: (){
                              _selectDate(context);
                             setState(() {});
                            }),
                        gapHeight(28.h),
                        ctmTxtGroteskMid("Select gender", AppColors.black, 16.sp, weight: FontWeight.w500),
                        gapHeight(25.h),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  if(controller.isActiveFemale){
                                    setState(() {
                                      controller.isActiveFemale=false;
                                      controller.isActive= true;
                                    });
                                  }else{
                                    setState(() {
                                      controller.isActive=true;
                                    });

                                  }
                                  controller.bloc.validation.setGender("Male");
                                },
                                child: CustomRadioButton(title: "Male", isActive: controller.isActive)),
                            const Gap(20),
                            GestureDetector(
                                onTap: (){
                                  if(controller.isActive){
                                    setState(() {
                                      controller.isActive=false;
                                      controller.isActiveFemale= true;

                                    });
                                  }else{
                                    setState(() {
                                      controller.isActiveFemale=true;
                                    });

                                  }
                                  controller.bloc.validation.setGender("Female");
                                },
                                child: CustomRadioButton(title: "Female", isActive: controller.isActiveFemale)),
                          ],
                        ),
                       // gapHeight(28.h),
                    MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                    gapHeight(50.h): gapHeight(50.h),// if keyboard is open
                    StreamBuilder<Object>(
                        stream: controller.bloc.validation.userInfoFormValid,
                        builder: (context, snapshot) {
                          return  snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed',isEnabled: snapshot.hasData, tap: () {
                           !snapshot.hasData ? null :
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            const CreateAccountScreen2()));
                          }): disabledBtn(title: "Proceed");
                        }
                    ),
                    gapHeight(70.h),
                  ],),),
                ))
              ],);

          },
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {

    var date = await Get.bottomSheet(
      backgroundColor: AppColors.white,
      isDismissible: true,
      SizedBox(
        height: 600.h,
        child: CustomDatePicker(),
      )
    );

    if(date is String){
      if(date.isNotEmpty){
        setState(() {
          controller.dateController.text= date;
        });}
    }
    else{

    }
  }

  void genderSelection() async{
    await openBottomSheet(context, SelectTextBottomSheet(titleText: "Select gender", items: [SelectionModal(title: "Male", id: "1"), SelectionModal(title: "Female", id: "2")], height: 400.h, ),)
        .then((value) {
      if (value is SelectionModal){
        controller.genderController.text = value.title;
        controller.bloc.validation.setGender(value.title);
      }
    });
  }

}

