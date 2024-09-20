import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/add_button.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/Faq/faq_provider.dart';
import '../AddFaqScreen/add_faq_screen.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Consumer<FaqProvider>(
          builder: (context, value, child) {
            return Row(
              children: [
                AppText(
                  text: "FAQS",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: themeColor,
                  fontFamily: AppFonts.semiBold,),
                SizedBox(width: 1.w,),
                Visibility(
                  visible: value.isAddFaq == false,
                  child: AddButton(
                    onTap: () {
                      value.setAddFaq(true);
                    },),
                ),
              ],
            );
          },),
        Consumer<FaqProvider>(
            builder: (context, value, child) {
              return Visibility(
                visible: value.isAddFaq == false,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final isSelected = value.selectFaq == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText2(
                                text: "Q: What is TabibiNet?",
                                fontSize: 12.sp, fontWeight: FontWeight.w500,
                                isTextCenter: false, textColor: textColor,
                                fontFamily: AppFonts.medium,),
                              IconButton(
                                  onPressed: () {
                                    if(value.selectFaq != index){
                                      value.setFaq(index);
                                    }else{
                                      value.setFaq(null);
                                    }
                                  },
                                  icon: Icon(
                                    isSelected ? CupertinoIcons.chevron_down :
                                    CupertinoIcons.chevron_up,
                                    color: textColor,
                                    size: 18,
                                  )
                              )
                            ],
                          ),
                          const Divider(color: Colors.grey,thickness: 1.5,),
                          Visibility(
                            visible: isSelected,
                            child: AppText2(
                              text: "A: Using TabibiNet is simple. "
                                  "Download the app, create an account,"
                                  " and you can start booking appointments,"
                                  " consulting with doctors via video, and "
                                  "accessing your medical records—all from "
                                  "your smartphone or tablet.",
                              fontSize: 12.sp, fontWeight: FontWeight.w500,
                              isTextCenter: false, textColor: Colors.grey,
                              fontFamily: AppFonts.medium,maxLines: 10,
                            ),
                          ),
                          Visibility(
                            visible: isSelected,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SubmitButton(
                                width: 6.w,
                                height: 25,
                                textSize: 10.sp,
                                radius: 5,
                                title: "Delete",
                                press: () {

                                },),
                            ),
                          )
                        ],
                      ),
                    );
                  },),
              );
            },
        ),
        Consumer<FaqProvider>(
          builder: (context, value, child) {
            return Visibility(
                visible: value.isAddFaq,
                child: AddFaqScreen());
          },
        )

      ],
    );
  }
}
