import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DoctorPaymentScreen/Components/table_chart.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';

class InvoiceDialogueCard extends StatelessWidget {
  const InvoiceDialogueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "View Invoice",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: textColor,
                  fontFamily: AppFonts.semiBold,
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(AppIcons.closeIcon,height: 30,))
              ],
            ),
            const Divider(color: Colors.grey,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  AppText(
                    text: "9 June, 2024",
                    fontSize: 16.sp, fontWeight: FontWeight.w600,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,
                  ),
                  const Spacer(),
                  SvgPicture.asset(AppIcons.printerIcon,height: 40,),
                  SizedBox(width: 1.w,),
                  SubmitButton(
                    width: 10.w,
                    title: "Download",
                    press: () {

                    },)
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greyColor
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppAssets.logo2Image,height: 12.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RowText(text1: "Invoice No: ", text2: "#123456"),
                            SizedBox(height: 1.h,),
                            const RowText(text1: "Issued Date: ", text2: "11 June"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColumnText(
                            headingText: "Billing Form",
                            text1: "Mian Uzair",
                            text2: "New York America",
                            text3: ""),
                        ColumnText(
                            headingText: "Billing To",
                            text1: "Dr. John",
                            text2: "New York America",
                            text3: ""),
                        ColumnText(
                            alignment: CrossAxisAlignment.end,
                            headingText: "Payment Method",
                            text1: "Debit Card",
                            text2: "xxxxxxxxxx-251",
                            text3: "HDFC Bank"),
                      ],
                    ),
                    AppText(
                        text: "Invoice Details",
                        fontSize: 12.sp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: textColor,fontFamily: AppFonts.semiBold,),
                    SizedBox(height: 1.h,),
                    const TableChart(),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            AppText(
                                text: "Note:  ",
                                fontSize: 12.sp, fontWeight: FontWeight.w500,
                                isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium,),
                            SizedBox(
                              width: 25.w,
                              child: AppText(
                                  text: "An account of the present illness,"
                                      " which includes the circumstances surrounding"
                                      " the onset of recent health changes and the"
                                      " chronology of subsequent events that have"
                                      " led the patient to seek medicine",
                                  fontSize: 10.sp, fontWeight: FontWeight.w400,fontFamily: AppFonts.medium,
                                  isTextCenter: false, textColor: textColor, maxLines: 8,),
                            ),

                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowText(text1: "Subtotal: ", text2: "\$220"),
                            RowText(text1: "Disscount: ", text2: "-10%"),
                            RowText(text1: "Total: ", text2: "\$205"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
            text: text1, fontSize: 10.sp,
            fontWeight: FontWeight.w500, isTextCenter: false,
            textColor: textColor, fontFamily: AppFonts.medium,),
        SizedBox(width: 1.w,),
        AppText(
            text: text2, fontSize: 10.sp,
            fontWeight: FontWeight.w500, isTextCenter: false,
            textColor: Colors.grey, fontFamily: AppFonts.medium,),
      ],
    );
  }
}

class ColumnText extends StatelessWidget {
  const ColumnText({
    super.key,
    required this.headingText,
    required this.text1,
    required this.text2,
    required this.text3,
    this.alignment
  });

  final String headingText;
  final String text1;
  final String text2;
  final String text3;
  final CrossAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        AppText(
            text: headingText,fontFamily: AppFonts.semiBold,
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor),
        SizedBox(height: 1.h,),
        AppText(text: text1, fontSize: 10.sp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.grey),
        SizedBox(height: 1.h,),
        AppText(text: text2, fontSize: 10.sp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.grey),
        SizedBox(height: 1.h,),
        AppText(text: text3, fontSize: 10.sp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.grey),
      ],
    );
  }
}
