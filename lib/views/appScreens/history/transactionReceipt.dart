import 'dart:typed_data';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import '../../../UiUtil/bottomsheet/receiptBottomSheet.dart';
import '../../../UiUtil/bottomsheet/recieptBottomSheet.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../models/response/TransactionHistory.dart';
import '../../../utils/appUtil.dart';


class Receipt extends StatelessWidget {
  final GlobalKey _globalKey =  GlobalKey();
  final TransactionHistoryResponse response;
  Receipt({required this.response, Key? key}) : super(key: key);

  _shareScreenShot() async {
    ShareFilesAndScreenshotWidgets().shareScreenshot(
        _globalKey,
        1500,
        "transaction receipt",
        "receipt.png",
        "image/png",
        text: "");
  }
  Future<void> takePicture(context) async {
    RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject()  as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(pngBytes!, quality: 100);
    }
    AppUtils.showSuccessSnack("Saved to gallery", context);
  }

  @override
  Widget build(BuildContext context) {
    var isDebit = response.amount!.contains("-");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Column(
                  children: [
                    Container(
                      color: AppColors.accent,
                      height: 80.0,
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("MoneyTronics MFB",
                                  AppColors.black33, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                              ctmTxtGroteskMid("Microfinance bank",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                            ],
                          ) ,
                          const Spacer(),
                          Column(
                            children: [
                              ctmTxtGroteskMid("",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                              ctmTxtGroteskMid("Transaction receipt",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                            ],
                          ),
                        ],),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            ctmTxtGroteskMid("Transaction amount",
                                AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                            gapH(10.0),
                            ctmTxtGroteskMid(getAmount(),
                                AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                          ],
                        )
                    ),
                    Column(
                      children: [
                        Container(
                          height: 80.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Receiver details",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(response.beneficiaryName,
                                      AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ctmTxtGroteskMid("${response.destinationBank} | ${response.beneficiaryAccount}",
                                      AppColors.black66, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w400),
                                ],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Sender details",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: ctmTxtGroteskMid(response.accountHolderName,
                                        AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: EdgeInsets.only(top: 15, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Paid on",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(response.trandate!.split(" ")[0],
                                      AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ctmTxtGroteskMid(response.trandate!.split(" ")[1],
                                      AppColors.black66, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w400),
                                ],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Description",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ctmTxtGroteskMid(response.narration,
                                        AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ),],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Transaction reference",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(response.requestId,
                                      AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                ],
                              ),
                            ],
                          ),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Transaction type",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(isDebit ? "Debit" : "Credit",
                                      isDebit ? AppColors.red00 : AppColors.primary, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Transaction status",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid("Successful",
                                      AppColors.primary, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    gapH(10.0),
                    ctmTxtGroteskMid("Powered by MoneyTronics MFB",
                        AppColors.black6B, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                    gapH(10.0),
                  ],
                ),
              ),
              gapH(20.0),
              ReceiptBottomSheet2.shareOrDownloadReceiptBtn(shareTap: (){
                _shareScreenShot();
              }, downloadTap: (){
                takePicture(context);
              })
            ],
          ),
        ),
      ),
    );
  }
  Widget dottedLine(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0.h,
        dashLength: 5.0.w,
        dashColor: AppColors.black66.withOpacity(0.50),
      ),
    );
  }
  String getAmount(){
    var prefix = "";
    if (response.amount!.contains("-")){
      prefix = "-";
    }
    return "$prefix N${response.amount!.replaceAll("-", "")}";
  }
}


