import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Provider/Subscription/subscription_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/EditSubscriptionScreen/edit_subscription_screen.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Widgets/info_tile.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  final List<String> subscription = [
    "Basic",
    "Premium",
    "Advanced",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Consumer<SubscriptionProvider>(
          builder: (context, value, child) {
            return value.isEditSub ?
            const SizedBox() :
            SizedBox(
              height: 80,
              width: 100.w,
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 60,
                    crossAxisSpacing: 100
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final isSelected = value.selectPlan == index;
                  return SubmitButton(
                    title: subscription[index],
                    textColor: isSelected ? themeColor : textColor,
                    bdColor: isSelected ? themeColor : bgColor,
                    bgColor: bgColor,
                    textSize: 14.sp,
                    press: () {
                      value.setPlan(index);
                    },
                  );},),
            );
            },
        ),
        SizedBox(height: 1.h,),
        Consumer<SubscriptionProvider>(
          builder: (context, value, child) {
            return value.isEditSub ?
            EditSubscriptionScreen() :
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return InfoTile(
                  nameText: "ALexon",
                  emailText: "info@gmail.com",
                  phoneText: "+92 356 678 90",
                  statusText: "Basics",
                  isAddIcon: false,
                  isStatusText: true,
                  image: AppAssets.profileImage,
                  editTap: (){
                    value.setSub(true);
                  },
                  delTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: greenColor,
                          title: const Text(
                            'Delete Subscription!',
                            style: TextStyle(
                                fontFamily: AppFonts.semiBold,
                                color: bgColor
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to Delete Subscription of Alex?',
                            style: TextStyle(
                                fontFamily: AppFonts.regular,
                                color: bgColor
                            ),
                          ),
                          actions: <Widget>[
                            SubmitButton(
                              height: 30,
                              width: 8.w,
                              textSize: 12.sp,
                              bgColor: greenColor,
                              textColor: bgColor,
                              bdColor: bgColor,
                              title: "No",
                              press: () => Get.back(),),
                            SubmitButton(
                              height: 30,
                              width: 8.w,
                              textSize: 12.sp,
                              bgColor: bgColor,
                              textColor: greenColor,
                              bdColor: bgColor,
                              title: "Yes",
                              press: () => Get.back(),),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15.sp,);
              },);
          },)
      ],
    );
  }
}
