import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_page_lifecycle/flutter_page_lifecycle.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../UiUtil/bottomsheet/SelectOptionBottomSheet.dart';
import '../../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/infos.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../bloc/settings/setting_bloc.dart';
import '../../../../models/requests/DocumentUploadRequest.dart';
import '../../../../models/response/ApiResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';
import '../../../startScreen/login/loginFirstTime.dart';
import '../AccountUpgradeScreen.dart';

class AccountUpgradeScreen extends StatefulWidget {
  const AccountUpgradeScreen({super.key});

  @override
  State<AccountUpgradeScreen> createState() => _AccountUpgradeScreenState();
}

class _AccountUpgradeScreenState extends State<AccountUpgradeScreen> {
  final PageController _sendingAccPageController = PageController();
  // value 72.8.w for each state progress out 5 stages

  late SettingBloc bloc;
  late File file;
  UploadedDocument? utilityDoc;
  UploadedDocument? signatureDoc;
  UploadedDocument? passport;
  UploadedDocument? idCard;
  UploadedDocument? profilePhoto;

  @override
  void initState() {
    utilityDoc = loginResponse?.customerDocumentUpload?.uploadedDocument.firstWhere((element) => element.documentName.trim().toLowerCase() == "Utility Bill".trim().toLowerCase());
    signatureDoc = loginResponse?.customerDocumentUpload?.uploadedDocument.firstWhere((element) => element.documentName.trim().toLowerCase() == "signature".trim().toLowerCase());
    passport = loginResponse?.customerDocumentUpload?.uploadedDocument.firstWhere((element) => element.documentName.trim().toLowerCase() == "Passport Photograph".trim().toLowerCase());
    idCard = loginResponse?.customerDocumentUpload?.uploadedDocument.firstWhere((element) => element.documentName.trim().toLowerCase() == "Identification Card".trim().toLowerCase());
    profilePhoto = loginResponse?.customerDocumentUpload?.uploadedDocument.firstWhere((element) => element.documentName.trim().toLowerCase() == "Profile Photograph".trim().toLowerCase());
    super.initState();
  }

  double _progressValue = 0;
  void _updateProgress(double addedProgressValue) {
    setState(() {
      _progressValue = addedProgressValue;
      // _progressValue += addedProgressValue;
      // if (_progressValue >= 364) {
      //   _progressValue = 364;
      // }
    });
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
  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingBvnInfoState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  const UpgradeAccount()));
              _launchURL(state.response.url);
              bloc.initial();
            });
          });
        }
        if (state is SettingLoginSuccessfulState){
          loginResponse = state.response;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              bloc.initial();
            });
          });
        }

        if (state is SettingDocumentUploadState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              _receiptBottomSheet();
              bloc.initial();
            });
          });
        }

        if (state is SettingStateError){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.result?.message ?? "Error occurred", context);
              bloc.initial();
            });
          });
        }
        return AppUtils().loadingWidget2(
          context: context,
          isLoading: state is SettingStateLoading,
          child: PageLifecycle(
            stateChanged: (bool appeared) {
              if (appeared){
                bloc.add(SettingLoginEvent(request: loginRequest!));
              }
            },
            child: Scaffold(backgroundColor: AppColors.whiteFA,
                body: Column(children: [
                  appBarBackAndTxt(title: "Account upgrade",
                      backTap: (){Navigator.pop(context);}),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        children: [
                          selectAccountColumn (
                            title: "Select sending account",
                            pageView: SizedBox(
                              width: double.infinity,height: 100.h,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _sendingAccPageController,
                                onPageChanged: (int page) {
                                  //bloc.formValidation.setSelectedAccount(userAccounts![page]);
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
                            ),
                          ),
                          // gapH(30.h),
                          // accountProgressCard(completeText: '20%', progressValue: 20.w),/// progress card
                          gapH(20.h),
                          UploadKycCard(
                            title: "Customer signature",
                            description: "Upload a picture of your signature signed on a white background",
                            isUploaded: signatureDoc?.status.isNotEmpty == true,
                            statusWidget: const SizedBox(),
                            tap: () {
                              selectOption(optionTitle: "Upload document",
                                  list: ["Upload from local files"],
                                  height: 300.h, docId: signatureDoc!.docId);
                            },
                          ),
                          gapH(20.h),
                          UploadKycCard(
                            title: "Utility bill",
                            description: "Upload a picture of your signature signed on a white background",
                            isUploaded:  utilityDoc?.status.isNotEmpty == true,
                            statusWidget: const SizedBox(),
                            tap: () async{
                              selectOption(optionTitle: "Upload document",
                                  list: ["Upload from local files"],
                                  height: 200.h, docId: utilityDoc!.docId);
                            },
                          ),
                          gapH(20.h),
                          UploadKycCard(
                            title: "BVN",
                            description: "Upload a picture of your signature signed on a white background",
                            isUploaded: loginResponse?.registrationStatus == "00",
                            statusWidget: const SizedBox(),
                            tap: () {
                              bloc.add(const SettingBvnInfoEvent());
                            },
                          ),
                          gapH(20.h),
                          UploadKycCard(
                            title: "Identification card",
                            description: "Upload a picture of your signature signed on a white background",
                            isUploaded: idCard?.status.isNotEmpty == true,
                            statusWidget: const SizedBox(),
                            tap: () async{
                              selectOption(optionTitle: "Upload document",
                                  list: ["Upload from local files"],
                                  height: 200.h, docId: idCard!.docId);
                            },
                          ),
                          // gapH(20.h),
                          // UploadKycCard(
                          //   title: "Next of kin",
                          //   description: "Upload a picture of your signature signed on a white background",
                          //   isUploaded: true,
                          //   statusWidget: const SizedBox(),
                          //   tap: () {
                          //     Navigator.push(context, MaterialPageRoute(builder:
                          //         (context)=> const NextOfKinScreen()));
                          //   },
                          // ),
                          gapH(50.h),
                        ],
                      ),
                    ),
                  ),]
                )
            ),
          ),
        );
      },
    );
  }
  selectOption({required String optionTitle, required List <String> list,required double height, required int docId})async{
    var result =  await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child:  SelectOptionBottomSheet(
              items: list,
              title: optionTitle,
              height: height,)
        )
    );
    if(result != null){
      setState(() {
        imagePicker(docId);
      });
    }
  }

  Container accountProgressCard({required String completeText,required double progressValue }) {
    return Container(
      margin: screenPadding(),
      padding: EdgeInsets.symmetric(horizontal:15.w,vertical:20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Column(children: [
        Row(children: [
          ctmTxtGroteskMid("Account setup",AppColors.black, 18.sp),
          const Spacer(),
          ctmTxtGroteskMid(completeText,AppColors.black, 18.sp),
        ],),
        gapH(20.h),
        manualProgressIndicator(
            progressWidthValue: progressValue),
      ],),
    );
  }
  imagePicker(int docId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      file = File(result.files.single.path ?? "");
      //  imageAsset = Image.file(file, height: 250.h, width: 250.h,);
      bloc.add(SettingDocUploadEvent(request: DocumentUploadRequest(documentType: docId, base64String: convertIntoBase64(file))));
    } else {
    }
    setState(() {
    });
  }
  String convertIntoBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }
  _receiptBottomSheet() {
    nonDismissibleBottomSheet(context,
        SimpleSuccessAlertBottomSheet(
            isSuccessful: true,
            type: "Document upload",
            description: "Document uploaded successfully",
            accountBtn: "Close",
            returnTap: (){
              bloc.add(SettingLoginEvent(request: loginRequest!));
              Navigator.pop(context);
            }));
  }
}


