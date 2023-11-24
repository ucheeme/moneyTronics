

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../bloc/settings/setting_bloc.dart';
import '../../../UiUtil/bottomsheet/selectTextBottomSheet.dart';
import '../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../models/requests/AccountTierUpgradeRequest.dart';
import '../../../models/response/FinedgeProduct.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import 'WebViewScreen.dart';

class UpgradeAccount extends StatefulWidget {
  const UpgradeAccount({super.key});

  @override
  State<UpgradeAccount> createState() => _UpgradeAccount();
}

class _UpgradeAccount extends State<UpgradeAccount> {
  late SettingBloc bloc;
  FinedgeProduct? selectedProduct;
  List<SelectionModal> selectionModels = [];
  TextEditingController codeControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    //  bloc.add(const SettingBvnInfoEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingStateError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                bloc.initial();
              });
            });
          }
          if (state is SettingBvnInfoState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                _launchURL(state.response.url);
                bloc.initial();
              });
            });
          }
          if (state is SettingAccountUpgradeState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                _receiptBottomSheet();
                bloc.initial();
              });
            });
          }
          return AppUtils().loadingWidget2(
            context: context,
            isLoading: state is SettingStateLoading,
            child: Scaffold(resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.whiteFA,
              bottomSheet: SizedBox(
                height: 150.h,
                child: Center(
                  child:   codeControl.text.isNotEmpty ? blueBtn(title: 'Proceed', tap: () {
                    bloc.add(SettingAccountUpgradeEvent(AccountTierUpgradeRequest(authorizationCode: codeControl.text )));
                  }) : disabledBtn(title: 'Proceed'),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Account tier upgrade",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child: Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    CustomTextFieldWithValidation(
                      controller:codeControl, title: "Enter bvn validation code",
                      details: "Get access code", inputType:TextInputType.text,
                      onChange: (v){
                        setState(() {

                        });
                      },
                      enabled: true,
                      detailTap: (){
                        bloc.add(const SettingBvnInfoEvent());
                      }, error: "",),
                  ],),),)
                ),
              ],),
            ),
          );
        },
      ),
    );
  }
  _receiptBottomSheet() {
    nonDismissibleBottomSheet(context,
    SimpleSuccessAlertBottomSheet(
        isSuccessful: true,
        type: "Airtime Payment Successful",
        description: "We’ve completed your transfer, You will be notified shortly",
        accountBtn: "Close",
        returnTap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }));
  }
  _launchURL(address) async {
    AppUtils.debug("the url: $address");
    var url = Uri.parse(address);
    if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
