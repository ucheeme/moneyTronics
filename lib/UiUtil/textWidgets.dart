import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants/Themes/colors.dart';

Text ctmTxtGroteskSB(title,color,size,{weight = FontWeight.w500,maxLines = 1, textAlign = TextAlign.start}) {
  return Text(title,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'HKGroteskSemiBold',
      fontWeight: weight,
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}
 Text ctmTxtGroteskReg(title,color,size,{weight = FontWeight.w400,maxLines = 1, textAlign = TextAlign.start}) {
  return Text(title,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'HKGroteskRegular',
      fontWeight: weight,
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}
Text ctmTxtGroteskMid(title,color,size,{weight = FontWeight.w500,maxLines = 1, textAlign = TextAlign.start}) {
  return Text(title,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'HKGroteskMedium',
      fontWeight: weight,
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}
Text nairaSign(text,size,{weight = FontWeight.w700,colors= AppColors.black ,textAlign = TextAlign.start}) {
  return Text(text,
      // '${currency(context).currencySymbol}',
      style: GoogleFonts.dmSans(
        color: colors,
        fontSize: size,
        fontWeight: weight,

      ),
    maxLines: 1,
    textAlign: textAlign,
    //   TextStyle(
    //   fontSize: size,
    //   letterSpacing: -2.0,
    //   fontWeight: weight,
    //   color: isDark? AppColors.white: AppColors.textGrey2D,
    // ),
  );
}