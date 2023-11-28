import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../UiUtil/bottomsheet/SelectOptionBottomSheet.dart';
import '../../../../UiUtil/customTextfield.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../utils/constants/Themes/colors.dart';





class NextOfKinScreen extends StatefulWidget {
  const NextOfKinScreen({super.key});

  @override
  State<NextOfKinScreen> createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  TextEditingController nKFullNameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.whiteFA,
        body: Column(children: [
          appBarBackAndTxt(title: "Upload next of kin information",
              backTap: (){Navigator.pop(context);}),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: screenPadding(),
                child: Column(
                  children: [
                    gap(),
                    CustomTextFieldWithValidation(
                      controller:nKFullNameControl, title: "Next of kin’s full name",
                      details: "", inputType:TextInputType.text,
                      onChange: (val){},
                      error: "",
                    ),
                    gap(),
                    CustomTextFieldWithValidation(
                      controller:nKFullNameControl, title: "Next of kin’s email address",
                      details: "", inputType:TextInputType.emailAddress,
                      onChange: (val){},
                      error: "",
                    ),
                    gap(),
                    CustomTextFieldWithValidation(
                      controller:nKFullNameControl, title: "Next of kin’s phone number",
                      details: "", inputType:TextInputType.phone,
                      onChange: (val){},
                      error: "",
                    ),
                    gap(),
                    CustomTextFieldWithValidation(
                      controller:nKFullNameControl, title: "Next of kin’s home address",
                      details: "", inputType:TextInputType.text,
                      onChange: (val){},
                      error: "",
                    ),
                    gap(),
                    GestureDetector(
                      onTap: (){
                        selectOption(optionTitle: "Select relationship",
                            list: ["Wife","Sister","husband","Friend"],
                            height: 500.h);
                      },
                      child: CustomTextFieldWithValidation(
                        controller:nKFullNameControl, title: "What is your relationship with this person",
                        details: "", inputType:TextInputType.text,
                        onChange: (val){},
                        enabled: false,
                        error: "",
                      ),
                    ),



                  ]
                ),
              ),
            ),
          ),
        ]
        )
    );
  }
  selectOption({required String optionTitle, required List <String> list,required double height})async{
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

      });
    }
  }


  SizedBox gap() => gapH(30.h);
}
