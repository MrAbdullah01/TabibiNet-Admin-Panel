import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Provider/HealthCare/health_care_provider.dart';
import 'Components/doctor_profile_card.dart';

class HealthCareScreen extends StatelessWidget {
  HealthCareScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 20.w,
                  child: AppTextField2(
                    inputController: searchC,
                    hintText: "Search by Name",
                    prefixIcon: Icons.search,
                  )),
              SizedBox(width: 2.h,),
              SizedBox(
                  width: 20.w,
                  child: AppTextField2(
                    inputController: searchC,
                    hintText: "Search by Categories",
                    prefixIcon: Icons.search,
                  )),
            ],
          ),
          SizedBox(height: 3.h,),
          SizedBox(
            width: 100.w,
            height: 50,
            child: Consumer<HealthCareProvider>(
              builder: (context, value, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final isSelected = value.selectIndex == index;
                    return SubmitButton(
                      width: 15.w,
                      radius: 6,
                      bgColor: isSelected ? themeColor : bgColor,
                      textColor: isSelected ? bgColor : themeColor,
                      title: "Cardiology",
                      press: () {
                        value.setIndex(index);
                      },);
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 20,),
                );
              },),
          ),
          SizedBox(height: 2.h,),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
              mainAxisExtent: 48.h
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return const DoctorProfileCard();
            },)
        ],
      ),
    );
  }
}
