import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
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
          SizedBox(height: 10.sp,),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 15.sp,
                crossAxisSpacing: 15.sp,
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
