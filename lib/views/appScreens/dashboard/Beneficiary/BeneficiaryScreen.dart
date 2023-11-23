

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../UiUtil/Alerts/AlertDialog.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/searchTextField.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../bloc/Dashboard/dashboard_bloc.dart';
import '../../../../models/requests/DeleteBeneficiary.dart';
import '../../../../models/response/BeneficiaryResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Constants.dart';
import '../../../../utils/constants/Themes/colors.dart';




class BeneficiaryListScreen extends StatefulWidget {
  final bool isSelectible;
   bool? isFinedge = false;
   BeneficiaryListScreen({this.isFinedge, required this.isSelectible, Key? key}) : super(key: key);
  @override
  State<BeneficiaryListScreen> createState() => _BeneficiaryListScreenState();

}

class _BeneficiaryListScreenState extends State<BeneficiaryListScreen> {
  late DashboardBloc bloc;
  TextEditingController searchControl = TextEditingController();
  final _beneficiaryListSubject = BehaviorSubject<List<Beneficiary>>();
  Stream<List<Beneficiary>> get beneficiaryListStream =>  _beneficiaryListSubject.stream;
  List<Beneficiary> beneficiaries = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(const DashboardBeneficiaryEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DashboardBloc>();
    return
      darkStatusBar(
       GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardBeneficiaryState){

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Future.delayed(Duration.zero, (){
                    if (widget.isFinedge == true) {
                      for (var element in state.response) {
                        if (element.beneficiaryBankcode == Constants.cedarBankCode){
                          beneficiaries.add(element);
                        }
                      }
                    }else{
                      for (var element in state.response) {
                        if (element.beneficiaryBankcode != Constants.cedarBankCode){
                          beneficiaries.add(element);
                        }
                      }
                    }
                    _beneficiaryListSubject.add(beneficiaries);
                    bloc.initial();
                  });
                });
              }
              if (state is DashboardDelBeneficiaryState){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Future.delayed(Duration.zero, (){
                    bloc.add(const DashboardBeneficiaryEvent());
                  });
                });
              }
              return AppUtils().loadingWidget2(
                context: context,
                isLoading: state is DashboardStateLoading,
                child: Scaffold(backgroundColor: AppColors.whiteFA,
                  body: Column(children: [
                    appBarBackAndTxt(title: "Manage beneficiaries",
                        backTap: (){Navigator.pop(context);}),
                    Container(
                      width: double.infinity,height: 100.h,
                      padding: EdgeInsets.fromLTRB(16.w, 0.h,16.w,10.h),
                      color: AppColors.white,
                      child: SearchTextField(
                          labelText: "Search beneficiaries",
                          inputType: TextInputType.text,
                          controller: searchControl,
                          onChange: (val){
                            if (val.isEmpty){
                              _beneficiaryListSubject.add(beneficiaries);
                            }else{
                              List<Beneficiary> r = [];
                              for (var element in beneficiaries) {
                                if (element.beneficiaryFullName.toLowerCase().contains(val.toLowerCase()) || element.beneficiaryAccount.toLowerCase().contains(val.toLowerCase())){
                                  r.add(element);
                                }
                              }
                              _beneficiaryListSubject.add(r);
                            }
                          }),
                    ),
                    Expanded(
                      child: StreamBuilder<List<Beneficiary>>(
                        stream: beneficiaryListStream,
                        builder: (context, snapshot) {
                          return (snapshot.hasData && snapshot.data!.isNotEmpty) ?  ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return iconAndTextWidgets(snapshot.data![index]);
                              }
                          ) : Column(
                            children: [
                              gapH(50.0),
                              Image.asset("assets/png/images/empty_state.png", height: 200, width: 200,),
                              Center(
                                child:  ctmTxtGroteskMid("No beneficiary saved",AppColors.black4D, 20.sp),
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ],),
                ),
              );
            },
          ),
        ),
      );
  }
  Widget iconAndTextWidgets(Beneficiary beneficiary) {
    // Access widget.name here and perform the necessary operations
    var firstTwoLetters = "";
    List<String> wordList = beneficiary.beneficiaryFullName.split(' ');
    if (wordList.length > 1) {
      firstTwoLetters = wordList[0][0];// + wordList[0][0];
    }

    return GestureDetector(onTap: (){
      if (widget.isSelectible){
        Navigator.pop(context, beneficiary);
      }
    },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.5.h),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.white,borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 34.w,height: 32.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.green24
              ),
              child: Center(child: ctmTxtGroteskMid(firstTwoLetters.toUpperCase(),AppColors.white,14.sp),),
            ),
            gapW(15.w),
            Column(
              children: [
                SizedBox(width: 200.w,
                    child: ctmTxtGroteskMid(beneficiary.beneficiaryFullName.toUpperCase(),AppColors.green0C,18.sp,maxLines: 1)),
                SizedBox(width: 200.w,
                    child: ctmTxtGroteskReg("${beneficiary.beneficiaryBank} ${beneficiary.beneficiaryAccount}",AppColors.green0C,16.sp,maxLines: 1)),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                openBottomSheet(isDismissible: true, context, CustomAlertDialog(showIcon: false, body: "Do you want to delete ${beneficiary.beneficiaryFullName} from your beneficiaries",
                    proceedText: "Yes, Delete",
                    declineText: "No, Don't",
                    proceed: () async{
                      Navigator.pop(context);
                      bloc.add(DashboardDelBeneficiaryEvent(DeleteBeneficiary(beneficiaryId: int.parse(beneficiary.id))));
                    },
                    decline: (){
                     // openHome();
                      Navigator.pop(context);
                    })
                );
              },
                child: Image.asset("assets/png/icons/trash.jpg", width: 24, height: 24,)),

          ],),
      ),
    );
  }
}
