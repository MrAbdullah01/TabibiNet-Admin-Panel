import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';

class HealthCareScreen extends StatelessWidget {
  HealthCareScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        SizedBox(height: 10.sp,)
      ],
    );
  }
}
