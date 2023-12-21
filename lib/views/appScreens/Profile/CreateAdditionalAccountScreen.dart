

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../UiUtil/bottomsheet/selectTextBottomSheet.dart';
import '../../../UiUtil/bottomsheet/successAlertBottomSheet.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';
import '../../../models/requests/ProductCode.dart';
import '../../../models/response/FinedgeProduct.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';




class CreateAdditionalAccount extends StatefulWidget {
  const CreateAdditionalAccount({super.key});

  @override
  State<CreateAdditionalAccount> createState() => _CreateAdditionalAccountState();
}

class _CreateAdditionalAccountState extends State<CreateAdditionalAccount> {
  late ProfileBloc bloc;
  FinedgeProduct? selectedProduct;
  List<SelectionModal> selectionModels = [];
  TextEditingController productSelectControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const ProfileBankProductEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<ProfileBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileStateError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                bloc.initial();
              });
            });
          }
          if (state is ProfileBankProductState) {
            var products = state.response;
            for (var element in products) {
              selectionModels.add(SelectionModal(title: element.productName, id: element.productCode));
            }
            bloc.initial();
          }
          if (state is ProfileCreateAdditionalAccountState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                _receiptBottomSheet(state.response.nuban);
                bloc.initial();
              });
            });
          }
          return AppUtils().loadingWidget2(
            context: context,
            isLoading: state is ProfileStateLoading,
            child: Scaffold(resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.whiteFA,
              bottomSheet: SizedBox(
                height: 200.h,
                child: Center(
                  child:   selectedProduct != null ? blueBtn(title: 'Proceed', tap: () {
                    bloc.add( ProfileCreateAdditionalAccountEvent(request: ProductCode(productCode: selectedProduct?.productCode ?? "")));
                  }) : disabledBtn(title: 'Proceed'),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Account details",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child: Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    GestureDetector(
                      onTap: (){
                        productSelection();
                      },
                      child: CustomTextFieldWithValidation(
                        controller:productSelectControl, title: "Select product",
                        details: "Select product", inputType:TextInputType.text,
                        onChange: (v){},
                        enabled: false,
                        error: "",),),
                  ],),),)
                ),
              ],),
            ),
          );
        },
      ),
    );
  }
  void productSelection() async {
    await openBottomSheet(context, SelectTextBottomSheet(
      titleText: "Select product", items: selectionModels, height: 400.h, ),)
        .then((value) {
      if (value is SelectionModal){
        productSelectControl.text = value.title;
        selectedProduct = FinedgeProduct(productCode: value.id, productName: value.title);
        setState(() {});
      }
    }
    );
  }
  _receiptBottomSheet(accountNumber) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => SafeArea(
          child: Container(height: 700.h,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:  SuccessAlertBottomSheet(
                  isSuccessful: true, type: "Account created",
                  description: "Your account number is $accountNumber",
                  shareTap: (){
                    Share.share('my cedar bank account number $accountNumber');
                  }, downloadTap: () async {
                await Clipboard.setData(ClipboardData(text: 'my cedar bank account number $accountNumber')).then((value) => AppUtils.showSuccessSnack("account number copied", context));
              },
                  returnTap: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
          ),
        )
    );
  }
}
