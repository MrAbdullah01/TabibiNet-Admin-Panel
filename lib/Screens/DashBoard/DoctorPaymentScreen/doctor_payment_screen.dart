import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DoctorPaymentScreen/Components/invoice_dialogue_card.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/DoctorPayment/doctor_payment_provider.dart';

class DoctorPaymentScreen extends StatelessWidget {
  const DoctorPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Doctor Payment History",
                fontSize: 16.sp, fontWeight: FontWeight.w600,
                isTextCenter: false, textColor: themeColor,
                fontFamily: AppFonts.semiBold,
              ),
              Column(
                children: [
                  AppText(
                      text: "Monthly  Weekly  Today",
                      fontSize: 12.sp, fontWeight: FontWeight.w600,
                      isTextCenter: false, textColor: Colors.grey),
                  SizedBox(width: 13.w,child: const Divider(color: Colors.grey,))
                ],
              )
            ],
          ),
          Consumer<DoctorPaymentProvider>(
            builder: (context, value, child) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final isSelected = value.selectIndex == index;
                  return Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: isSelected ? greyColor : bgColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(AppAssets.doctorImage)
                                  )
                              ),
                            ),
                            SizedBox(width: 1.w,),
                            AppText(
                              text: "Alex",
                              fontSize: 14.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,
                              fontFamily: AppFonts.semiBold,),
                            const Spacer(),
                            AppText(
                              text: "June 9, 2024, 08:22 AM",
                              fontSize: 14.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,
                              fontFamily: AppFonts.semiBold,),
                            const Spacer(),
                            AppText(
                              text: "\$512",
                              fontSize: 14.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,
                              fontFamily: AppFonts.semiBold,),
                            const Spacer(),
                            SubmitButton(
                              width: 8.w,
                              height: 40,
                              bgColor: greenColor,
                              textColor: bgColor,
                              bdColor: greenColor,
                              title: "Completed",
                              press: () {

                              },),
                            SizedBox(width: 1.w,),
                            IconButton(
                                onPressed: () {
                                  value.setIndex(index);
                                },
                                icon: Icon(
                                  isSelected ?
                                  CupertinoIcons.chevron_down :
                                  CupertinoIcons.chevron_up,
                                  color: Colors.grey,)
                            )
                            // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
                          ],
                        ),
                        Visibility(
                            visible: isSelected,
                            child: const Divider(color: Colors.grey,)),
                        Visibility(
                          visible: isSelected,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const PayText(text1: "ID Payment", text2: "#001278965"),
                              const PayText(text1: "Date Paid", text2: "9-3-2024"),
                              const PayText(text1: "Invoice Date", text2: "June 9,2024"),
                              SubmitButton(
                                title: "Check Invoice",
                                height: 30,
                                textSize: 10.sp,
                                width: 8.w,
                                press: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const InvoiceDialogueCard(),);
                                },)
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20,),
              );
            },)
        ],
      ),
    );
  }
}

class PayText extends StatelessWidget {
  const PayText({
    super.key,
    required this.text1,
    required this.text2,
  });
  
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
            text: text1,
            fontSize: 10.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor
        ),
        AppText(
            text: text2,
            fontSize: 10.sp, fontWeight: FontWeight.w500, 
            isTextCenter: false, textColor: textColor)
        
      ],
    );
  }
}

