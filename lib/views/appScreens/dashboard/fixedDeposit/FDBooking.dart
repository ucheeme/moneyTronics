

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../UiUtil/bottomsheet/ProductListBottomSheet.dart';
import '../../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../../UiUtil/currencyTextfield.dart';
import '../../../../UiUtil/customTextfield.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/selectionTextField.dart';
import '../../../../bloc/FixedDepositCalculator/fixed_deposit_calculator_bloc.dart';
import '../../../../models/response/FDProducts.dart';
import '../../../../models/response/UserAccountResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../dashboard.dart';
import 'FDCalculatorPage.dart';



class FDBookingPage extends StatefulWidget {
  const FDBookingPage({Key? key}) : super(key: key);
  @override
  State<FDBookingPage> createState() => _FDBookingPageState();
}

class _FDBookingPageState extends State<FDBookingPage> {
  final PageController pageController = PageController();
  final TextEditingController productNameControl = TextEditingController();
  late FixedDepositCalculatorBloc bloc;
  var rollOver = false;
  FdProducts? selectedProduct;
  UserAccount? selectedAccount = userAccounts?[0];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const FDProductListEvents());
    });
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<FixedDepositCalculatorBloc>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light
      ),
      child: BlocBuilder<FixedDepositCalculatorBloc,
          FixedDepositCalculatorState>(
          builder: (context, state) {
            if (state is FDStateError){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                   AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                  bloc.initial();
                });
              });
            }
            if (state is FDInvestResponseState){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Future.delayed(Duration.zero, (){
                  nonDismissibleBottomSheet(context,
                      SimpleSuccessAlertBottomSheet(
                          isSuccessful: true, type: "Successful",
                          description: "Fixed deposit request was successful",
                          accountBtn: "Close",
                          returnTap: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }));
                  bloc.initial();
                });
              });
            }
            if (state is FDCalculatorState){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
                Future.delayed(Duration.zero, () async{
                  bloc.initial();
                  await showModalBottomSheet(
                      isDismissible: false, isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child:  FDCalculatorPage(fdCalculatorResponse: state.response,)
                      )
                  ).then((value) {
                    if (value == true){
                      bloc.add(FDInvestEvent(bloc.validation.getInvestRequest(selectedAccount?.accountnumber ?? "", rollOver)));
                    }
                  });
                });
              });
            }
            return AppUtils().loadingWidget2(
              context: context,
              isLoading: state is FDLoadingState,
              child: Scaffold(
                backgroundColor: AppColors.whiteFA,
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: GestureDetector(
                    onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
                    child: SizedBox(
                      height: 650.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          selectAccountColumn(
                              title: "Select sending account",
                              pageView: SizedBox(width: double.infinity,height: 100.h,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: pageController,
                                  onPageChanged: (int page) {
                                    selectedAccount = userAccounts?[page];
                                  },
                                  itemCount: accountWidget().length,
                                  itemBuilder: (context, index) {
                                    return accountWidget()[index];
                                  },
                                ),
                              ),
                              pageIndicator: SmoothPageIndicator(
                                controller: pageController,
                                count: accountWidget().length,
                                effect: customIndicatorEffect(),
                              )
                          ),
                          gapH(20.0),
                          Expanded(
                            child: ListView(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align( alignment: Alignment.topLeft, child: Text("Book a new fixed deposit", textAlign: TextAlign.start,)),
                                ),
                                Padding(
                                  padding: screenPadding(),
                                  child: Column(children: [
                                    gapH(30.h),
                                    StreamBuilder<String>(
                                        stream: bloc.validation.purpose,
                                        builder: (context, snapshot) {
                                          return CustomTextFieldWithValidation(
                                            controller: null,
                                            title: "Enter Purpose",
                                            details: "",
                                            inputType: TextInputType.text,
                                            onChange: bloc.validation.setPurpose,
                                            error: snapshot.hasError ? snapshot.error
                                                .toString() : "",
                                          );
                                        }
                                    ),
                                    StreamBuilder<List<FdProducts>>(
                                        stream: bloc.productStream,
                                        builder: (context, snapshot) {
                                          return
                                            SelectionTextField(controller: productNameControl,title:"Select fixed deposit product",
                                                tap: (){
                                                  showModalBottomSheet(
                                                      isDismissible: false, isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) => Padding(
                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                          child:  ProductListBottomSheet(customList: (snapshot.hasData && snapshot.data != null) ? snapshot.data! : [],
                                                            maxLines: 2, title: 'Select fixed deposit product', onSelectedOption:
                                                                (value) {
                                                              setState(() {
                                                                selectedProduct = value;
                                                                bloc.validation.setProduct(selectedProduct!);
                                                                productNameControl.text = value.productName;
                                                              });
                                                            },)
                                                      )
                                                  );
                                                });

                                        }),
                                    gapH(18.h),
                                    StreamBuilder<Object>(
                                        stream: bloc.validation.tenure,
                                        builder: (context, snapshot) {
                                          return CustomTextFieldWithValidation(
                                            controller: null,
                                            title: "Select Tenor (days)",
                                            details: "",
                                            inputType: TextInputType.number,
                                            onChange: bloc.validation.setTenure,
                                            error: snapshot.hasError ? snapshot.error
                                                .toString() : "",
                                            obsureText: false,
                                          );
                                        }
                                    ),
                                    StreamBuilder<Object>(
                                        stream: bloc.validation.amount,
                                        builder: (context, snapshot) {
                                          return CurrencyTextFieldWithValidation(
                                            controller: null,
                                            title: "Enter amount",
                                            details: "",
                                            onChange: bloc.validation.setAmount,
                                            error: snapshot.hasError ? snapshot.error
                                                .toString() : "",
                                            obsureText: false,
                                          );
                                        }
                                    ),
                                  ],
                                  ),
                                ),
                                gapH(28.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      const Text("Rollover?", textAlign: TextAlign.start,),
                                      CupertinoSwitch(
                                        value: rollOver,
                                        onChanged: (value) {
                                          setState(() {
                                            rollOver = !rollOver;
                                          });
                                        },
                                        trackColor: Colors.grey,
                                        activeColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100.0,
                                  child: Center(
                                    child: StreamBuilder<Object>(
                                        stream: bloc.validation.validateForm,
                                        builder: (context, snapshot) {
                                          return (snapshot.data == true) ? blueBtn(title: 'Proceed',isEnabled: snapshot.hasData, tap: () {
                                            bloc.add(FDCalculatorEvent(bloc.validation.getCalculatorRequest()));
                                          }) : disabledBtn(title: 'Proceed');
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
