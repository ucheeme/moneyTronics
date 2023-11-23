import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../UiUtil/amountTextField.dart';
import '../../../../UiUtil/bottomsheet/selectDataPlanBottomSheet.dart';
import '../../../../UiUtil/bottomsheet/selectNetworkBottomSheet.dart';
import '../../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../../UiUtil/selectTextField.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../../../../bloc/BillBloc/bill_bloc.dart';
import '../../../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../../../../models/response/UserAccountResponse.dart';
import '../../../../utils/appUtil.dart';
import '../dashboard.dart';



class DataPurchaseScreen extends StatefulWidget {
  const DataPurchaseScreen({super.key});

  @override
  State<DataPurchaseScreen> createState() => _DataPurchaseScreenState();
}

class _DataPurchaseScreenState extends State<DataPurchaseScreen> {

  TextEditingController amountControl = TextEditingController();
  TextEditingController numberControl = TextEditingController();
  TextEditingController networkControl = TextEditingController();
  TextEditingController productControl = TextEditingController();
  final PageController _sendingAccPageController = PageController();
  SubscribedService? selectedNetworkProvider;
  PresetAmountList? selectedNetworkProduct;
  UserAccount? selectedSendingAccount;

  late BillBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSendingAccount = userAccounts?[0];
    if(networkProviders == null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        bloc.add(const BillGetNetworkProvidersEvents());
      });
    }
  }
  @override
  void dispose() {
    _sendingAccPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = context.read<BillBloc>();
    return darkStatusBar(
      GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<BillBloc, BillState>(
            builder: (context, state) {
              if (state is BillStateError){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Future.delayed(Duration.zero, (){
                    AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                    bloc.initial();
                  });
                });
              }
              if (state is BillVendSuccessState){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Future.delayed(Duration.zero, (){
                    nonDismissibleBottomSheet(context,
                        SimpleSuccessAlertBottomSheet(
                            isSuccessful: true, type: "Successful",
                            description: "Data purchase successful",
                            accountBtn: "Close",
                            returnTap: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }));
                    bloc.initial();
                  });
                });
              }
              if (state is BillNetworkProvidersSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  airtimeProvidersList = [];
                  dataProvidersList = [];
                  networkProviders = null;
                  networkProviders = state.response.responseEntity?.body?.subscribedServices;
                  if(networkProviders != null){
                    networkProviders!.forEach((service) {
                      if (service.presetAmountList!.isEmpty) {
                        airtimeProvidersList.add(service);
                      } else {
                        dataProvidersList.add(service);
                      }
                    });
                  }
                });
                bloc.initial();
              }
              return AppUtils().loadingWidget2(
                context: context,
                isLoading: state is BillStateLoading,
                child: Scaffold(backgroundColor: AppColors.whiteFA,
                  bottomSheet: SizedBox(
                    height: 100.0,
                    child: Center (
                      child: StreamBuilder<Object>(
                          stream: bloc.formValidation.validateDataForm,
                          builder: (context, snapshot) {
                            return (snapshot.data == true) ? blueBtn(
                                title: 'Proceed',
                                isEnabled: snapshot.hasData,
                                tap: () {
                                  openPinScreen(context, (pin) {
                                    bloc.add(BillPostVendEvents(request: bloc.formValidation.getVendRequest(pin, isData: true)));
                                  });
                                }) : disabledBtn(title: 'Proceed');
                          }),),
                  ),
                  body: Column(children: [
                    appBarBackAndTxt(title: "Data purchase",
                        backTap: (){Navigator.pop(context);}),
                    Expanded(child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(children: [
                              selectAccountColumn(
                                  title: "Select sending account",
                                  pageView: SizedBox(width: double.infinity,height: 100.h,
                                    child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: _sendingAccPageController,
                                      onPageChanged: (int page) {
                                        bloc.formValidation.setSelectedAccount(userAccounts![page]);
                                      },
                                      itemCount: accountWidget().length,
                                      itemBuilder: (context, index) {
                                        return accountWidget()[index];
                                      },
                                    ),
                                  ),
                                  pageIndicator: SmoothPageIndicator(
                                    controller: _sendingAccPageController,
                                    count: accountWidget().length,
                                    effect: customIndicatorEffect(),
                                  )
                              ),
                              gapH(30.h),
                              GestureDetector(
                                onTap: (){
                                  if(networkProviders != null){
                                    _selectNetwork(dataProvidersList);
                                  }else{
                                    bloc.add(const BillGetNetworkProvidersEvents());
                                  }
                                },
                                child: Padding( padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: SelectTextField(
                                      labelText: "Select network",
                                      controller: networkControl,
                                      onChange: (val){}),
                                ),
                              ),
                              gapH(30.h),
                              GestureDetector(
                                onTap: (){
                                  if(selectedNetworkProvider != null){
                                    _selectProduct(selectedNetworkProvider);
                                  }else{
                                  }
                                },
                                child: Padding( padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: SelectTextField(
                                      labelText: "Select product",
                                      controller: productControl,
                                      onChange: (val){}),
                                ),
                              ),
                              gapH(30.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal:16.w),
                                child: StreamBuilder<Object>(
                                  stream: bloc.formValidation.amount,
                                  builder: (context, snapshot) {
                                    return AmountTextField(
                                      enabled: false,
                                      labelText: 'Amount',
                                      inputType: TextInputType.number,
                                      controller: amountControl,
                                      onChange: bloc.formValidation.setAmount,
                                    );
                                  }
                                ),
                              ),
                              gapH(30.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal:16.w),
                                child: StreamBuilder<Object>(
                                  stream: bloc.formValidation.phone,
                                  builder: (context, snapshot) {
                                    return NormalTextFieldWithValidation(
                                      labelText: 'Enter number',
                                      inputType: TextInputType.number,
                                      controller: numberControl,
                                      onChange: bloc.formValidation.setPhone,
                                    );
                                  }
                                ),
                              ),
                              gapH(200.h),
                            ],),
                          ),
                        ),
                        gapH(40.h),
                      ],
                    ))
                  ],),
                ),
              );
            }
        ),
      ),
    );
  }
  _selectNetwork(List<SubscribedService>? list)async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  SelectNetworkBottomSheet(
            titleText: 'Select network',
            items:  list??[],
            height: 502.h,
          ),
        )
    );
    if(result != null){
      setState(() {
        selectedNetworkProvider = result;
        networkControl.text = selectedNetworkProvider?.name ?? '';
        productControl.clear();
        selectedNetworkProduct = null;
        amountControl.clear();
        bloc.formValidation.setSubscribedService(result);
      });
    }
  }

  _selectProduct(SubscribedService? list)async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  SelectDataPlanBottomSheet(
            titleText: 'Select product',
            items:  list?.presetAmountList??[],
            height: 502.h,
          ),
        )
    );
    if(result != null){
      setState(() {
        selectedNetworkProduct = result;
        productControl.text = selectedNetworkProduct?.description ?? '';
        amountControl.text = selectedNetworkProduct?.amount.toString() ?? "";
        bloc.formValidation.setProduct(result);
        bloc.formValidation.setAmount( amountControl.text);
      });
    }
  }
}
